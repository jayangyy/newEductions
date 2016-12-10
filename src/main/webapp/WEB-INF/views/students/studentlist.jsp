<%-- 
    Document   : studentlist
    Created on : 2016-9-29, 15:17:04
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="_csrf" content="${_csrf.token}" />
        <meta name="_csrf_header" content="${_csrf.headerName}" />
        <title>成绩录入</title>
    </head>
    <body>
        <table id="stus_list_grid" class="easyui-datagrid" style="width:400px;height:250px"
               data-options="method:'get',fitColumns:false,fit:true,idField:'stu_idcard',checkbox:true,toolbar:'#stu_record_tb',pagination:true,pageNumber:1,pageSize:20,sortOrder:'DESC',sortName:'stu_name',singleSelect:true">
            <thead>
                <tr>
                    <th data-options="field:'stu_idcard',width:100,align:'center',hidden:true">编号</th>
                    <th data-options="field:'stu_oldjob',width:100,align:'center',hidden:true">编号</th>
                    <th data-options="field:'stu_curjob',width:100,align:'center',hidden:true">编号</th>
                    <th data-options="field:'class_no',width:100,align:'center',hidden:true">编号</th>
                    <th data-options="field:'ck',checkbox:true"></th>
                    <th data-options="field:'refdocurl',formatter:stuslistViewModel.stusFormatter,width:100,align:'center'">选择考生</th>
                    <th data-options="field:'stu_name',width:100,align:'center'">姓名</th>
                    <th data-options="field:'stu_sex',width:100,align:'center'">性别</th>
                    <th data-options="field:'stu_unit',width:100,align:'center'">单位</th>
                </tr>
            </thead>
        </table>
        <div id="stu_record_tb">
            <form id="stu_search_form3">
                <label for="stu_sname">培训班：</lable>
                    <input id="classno" class="easyui-combobox" name="classno" style="width:320px;"
                           data-options="url:'getStuClasses?idcard=&unit=${cur_unit}',valueField:'class_no',textField:'class_name',method:'get',editable:false,required:true,onSelect:stuslistViewModel.onClassSelected,onLoadSuccess:stuslistViewModel.onClassSuccess">
                    <!--<a id="stu_unselect_btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'"  onclick="unselectedsearch()">搜索</a>-->   
            </form>           
        </div>
        <%@include file="/WEB-INF/views/jspf/commonjs.jspf"%>
        <script type="text/javascript">
            $(function () {
                anticsrf();
            })
            stuslistViewModel = {
                $stuidcard: ko.observable(""),
                $cur_unit: ko.observable('${cur_unit}'),
                $classno: ko.observable(""),
                $classname: ko.observable(""),
                init: function () {
                    $("#stus_list_grid").datagrid({url: 'getStus?is_inputs=false&stu_sunit=${cur_unit}&is_search=true', queryParams: this.getparams()});

                },
                entryModify: function () {
                    var selectStu = $("#stus_list_grid").datagrid('getSelected');
                    if (selectStu == undefined || selectStu == null)
                    {
                        return;
                    }
                    this.$stuidcard(selectStu.stu_idcard);
                    this.$classno($("#classno").combobox('getValue'));
                    this.$classname($("#classno").combobox('getText'));
                    var window1 = $('<div/>')
                    window1.dialog({
                        title: '成绩录入',
                        width: 600,
                        height: 200,
                        closed: false,
                        maximizable: true,
                        cache: false,
                        href: 'stuRecord',
                        modal: true,
                        onClose: function () {
                            window1.dialog('clear');
                            stuslistViewModel.$stuidcard("");
                            stuslistViewModel.$classno('');
                            stuslistViewModel.$classname('');
                            // this.stu_class_oid("");
                        },
                        buttons: [
                            {
                                text: '保存',
                                handler: function () {
                                    $.ajax({
                                        url: 'recordStu',
                                        type: 'POST',
                                        data: $(window1).find('form').serializeArray(),
                                        dataType: 'json'
                                    }).done(function (result) {
                                        if (!result.result) {
                                            $.messager.alert('提示', result.info, 'info');
                                        } else {
                                            $(window1).dialog('clear');
                                            $(window1).dialog('close');
                                            stuslistViewModel.$stuidcard("");
                                            stuslistViewModel.$classno("");
                                            $.messager.show({
                                                title: '消息提示',
                                                msg: '执行成功',
                                                timeout: 2000,
                                                showType: 'slide'
                                            });
                                        }
                                    }).error(function (errorMsg) {
                                        $.messager.alert('提示', errorMsg, 'info');
                                    })
                                }
                            }, {
                                text: '取消',
                                handler: function () {
                                    window1.dialog('clear');
                                    window1.dialog('close');
                                    stuslistViewModel.$stuidcard("");
                                }
                            }]
                    });
                },
                stuTestList: function () {
                    var selectStu = $("#stus_list_grid").datagrid('getSelected');
                    if (selectStu == undefined || selectStu == null)
                    {
                        return;
                    }
                    this.$stuidcard(selectStu.stu_idcard);
                    var window1 = $('<div/>')
                    window1.dialog({
                        title: '成绩详细',
                        width: 420,
                        height: 600,
                        closed: false,
                        maximizable: true,
                        cache: false,
                        href: 'stuDetails',
                        modal: true,
                        onClose: function () {
                            window1.dialog('clear');
                            this.stu_class_oid("");
                        },
                        buttons: [{
                                text: '取消',
                                handler: function () {
                                    window1.dialog('clear');
                                    window1.dialog('close');
                                    this.$stuidcard("");
                                }
                            }]
                    });
                },
                stusFormatter: function (value, row, index) {
                    return '<a href="#" data-bind="click:students_saved" onclick="stus_saved()">成绩录入</a>';
                },
                onClassSuccess: function (data) {
                    if (data.length > 0)
                    {
                        $("#classno").combobox('select', data[0].class_no);
                    }
                },
                onClassSelected: function (record) {
                    stuslistViewModel.onSearch();
                },
                onSearch: function () {
                    $("#stus_list_grid").datagrid('reload', stuslistViewModel.getparams());
                },
                getparams: function () {
                    var Obj = {};
                    var array = $("#stu_search_form3").serializeArray();
                    if (array.length == 0)
                    {
                        return {classno: ''};
                    }
                    $.each(array, function (index, item) {
                        Obj[item.name] = item.value;
                    })
                    return Obj;
                }
            }
            stuslistViewModel.init();
            function addEntry()
            {
                stuslistViewModel.entryModify();
            }
            function showList()
            {
                stuslistViewModel.stuTestList();
            }
            function  stus_saved() {
                stuslistViewModel.entryModify();
            }
        </script>
    </body>
</html>
