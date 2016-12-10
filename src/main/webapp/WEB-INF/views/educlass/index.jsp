<%-- 
    Document   : index
    Created on : 2016-8-11, 15:19:13
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="_csrf" content="${_csrf.token}" />
        <meta name="_csrf_header" content="${_csrf.headerName}" />
        <title>培训班级管理</title>
        <%@include file="/WEB-INF/views/jspf/commonjs.jspf"%>

    </head>
    <body>
        <table id="class_grid" class="easyui-datagrid" style="width:400px;height:250px"
               data-options="url:'getClassPage',method:'get',fitColumns:false,fit:true,idField:'n_id',checkbox:true,toolbar:'#tb',pagination:true,pageNumber:1,pageSize:20,sortOrder:'DESC',sortName:'n_id',singleSelect:true">
            <thead>
                <tr>
                    <th data-options="field:'unitid',width:100,align:'center',hidden:true">编号</th>
                    <th data-options="field:'planunitid',width:100,align:'center',hidden:true">编号</th>
                    <th data-options="field:'execunitid',width:100,align:'center',hidden:true">编号</th>
                    <th data-options="field:'departmanid',width:100,align:'center',hidden:true">编号</th>
                    <th data-options="field:'projmanid',width:100,align:'center',hidden:true">编号</th>
                    <th data-options="field:'ck',checkbox:true"></th>
                    <th data-options="field:'n_id',width:100,align:'center'">编号</th>
                    <th data-options="field:'unit',width:150,align:'center'">单位</th>
                    <th data-options="field:'classno',width:100">班级编号</th>
                    <th data-options="field:'classname',width:400,align:'center'">班级名称</th>
                    <th data-options="field:'startdate',width:150,align:'center'">开始日期</th>
                    <th data-options="field:'enddate',width:150,align:'center'">结束日期</th>
                      <th data-options="field:'add_user_name',width:100,align:'center'">添加人</th>
                    <th data-options="field:'plandate',width:150,align:'center'">计划下达日期</th>
                    <th data-options="field:'signenddate',width:150,align:'center'">报名截止日期</th>
                    <th data-options="field:'studentscope',width:100,align:'center'">培训对象</th>
                    <th data-options="field:'classform',width:100,align:'center'">培训形式</th>
                    <th data-options="field:'classlevel',width:100,align:'center'">培训班等级</th>
                    <th data-options="field:'prof',width:100,align:'center'">培训专业</th>
                    <th data-options="field:'classtype',width:100,align:'center'">培训类型</th>
                    <th data-options="field:'crh',width:100,align:'center'">是否高铁</th>
                    <th data-options="field:'planunit',width:100,align:'center'">计划单位</th>
                    <th data-options="field:'execunit',width:100,align:'center'">执行单位</th>
                    <th data-options="field:'departman',width:100,align:'center'">部门负责人</th>
                    <th data-options="field:'projman',width:100,align:'center'">项目负责人</th>
                    <th data-options="field:'refdoc',width:100,align:'center'">培训依据（文件号）</th>
                    <th data-options="field:'telldate',width:100,align:'center'">通知日期</th>
                    <th data-options="field:'classplace',width:100,align:'center'">培训地点</th>
                    <th data-options="field:'studentnum',width:100,align:'center'">学生数量</th>
                    <th data-options="field:'newpost',width:100,align:'center'">新任职务</th>
                    <th data-options="field:'studentdays',width:100,align:'center'">人天数</th>
                    <th data-options="field:'classhours',width:100,align:'center'">学时</th>
                    <th data-options="field:'book1',width:100,align:'center'">教材1</th>
                    <th data-options="field:'bookfrom1',width:100,align:'center'">教材来源1</th>
                    <th data-options="field:'book2',width:100,align:'center'">教材2</th>
                    <th data-options="field:'bookfrom2',width:100,align:'center'">教材来源2</th>
                    <th data-options="field:'book3',width:100,align:'center'">教材3</th>
                    <th data-options="field:'bookfrom3',width:100,align:'center'">教材来源3</th>
                    <th data-options="field:'book4',width:100,align:'center'">教材4</th>
                    <th data-options="field:'bookfrom4',width:100,align:'center'">教材来源4</th>
                    <th data-options="field:'projreport',width:100,align:'center'">项目总结</th>
                    <th data-options="field:'archivedate',width:100,align:'center'">归档日期</th>
                    <th data-options="field:'projplan',width:100,align:'center'">项目计划</th>
                    <th data-options="field:'selfteach',width:100,align:'center'">自培或送培</th>
                    <th data-options="field:'refdocurl',formatter:fileFormatter,width:100,align:'center'">培训依据文件</th>
                    <!--                    <th data-options="field:'xxx',width:100,align:'center',formatter:rolesFormatter">角色选择</th>
                                        <th data-options="field:'xx',width:100,align:'center',formatter:groupsFormatter">用户组选择</th>-->
                </tr>
            </thead>
        </table>
        <div id="editDialog">
        </div>
        <div id="tb">
            <form id="search_form">
                <a id="btn" href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-add'" onclick="append()">添加班级</a>
                <a id="btn" href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-edit'" onclick="editIt()">修改班级</a>
                <a id="btn" href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-del'" onclick="removeIt()">删除班级</a>
                <span>承办单位:</span><input id="unitid1" class="easyui-combobox" name="unitid1" style="width:200px;height:30px;"
                                         data-options="valueField:'name',textField:'name',editable:false,onSelect:onSearch">
                <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="onSearch()">搜索</a>
            </form>           
        </div>
        <input type="hidden" name="oid" id="oid" value=""/>         
        <script type="text/javascript">
            $(function () {
                anticsrf();
                init();


            })
            function init() {
                $.getJSON('getUnits?levelId=0&searchType=1&uid=&uname=', function (data) {
                    if (data.length > 0) {
                        $('#unitid1').combobox({
                            data: data
                        });
                        // $('#unitid1').combobox('select', data[0].u_id);
                    }
                }).error(function (errMsg) {
                    $.messager.alert('提示', "未查到记录，稍后重试！", 'info');
                })
            }
            function fileFormatter(value, row, index) {
                if (row.refdocurl) {
                    return '<a  target="_blank" href="' + row.refdocurl + '" class="easyui-linkbutton" data-options="iconCls:\'icon-add\'">查看附件</a>'
                }
            }
            function onSearch()
            {
                var params = $("#search_form").serializeArray();
                var resdons = [];
                $.each(params, function (index, item) {
                    resdons.push(item.value);
                })
                $("#class_grid").datagrid('reload', {search: resdons.join(",")});
            }
            function getParams()
            {
                var obj = {search: '33'};
                return obj;
            }
            ///搜索
            function searchUsers()
            {
                //  $("#class_grid").datagrid('reload', {search: $("#suser_name").val()});
            }
            //下发角色选择
            function rolesFormatter(value, row, index) {
                if (row.username) {
                    return '<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:\'icon-add\'" onclick="rolesSelected(\'' + row.username + '\')">选择角色</a>'
                }
            }
            //授权
            function rolesSelected(usernmae) {
                $("#oid").val(usernmae);
                $('#editDialog').dialog({
                    title: '选择角色',
                    width: 500,
                    height: 300,
                    closed: false,
                    href: 'editRole',
                    cache: false,
                    modal: true,
                    buttons: [{
                            text: '确定',
                            handler: function () {
                                if (!($("#editDialog").find('form').form('validate')))
                                {
                                    return false;
                                }
                                var selRoles = $("#editDialog").find('[name=userRoles]');
                                var resdons = [];
                                $.each(selRoles, function (index, item) {
                                    resdons.push($(item).val());
                                })
                                $.ajax({
                                    url: 'UpdateUseRoles',
                                    type: 'POST',
                                    data: {roleids: resdons.join(','), username: $("#username").val()},
                                    dataType: 'json'
                                }).done(function (result) {
                                    if (!result.result) {
                                        $.messager.alert('提示', result.info, 'info');
                                    }
                                    $("#ousername").val("");
                                    $('#editDialog').dialog('close');
                                    $.messager.show({
                                        title: '消息提示',
                                        msg: '修改成功',
                                        timeout: 2000,
                                        showType: 'slide'
                                    });
                                }).error(function (errorMsg) {
                                    $("#ousername").val("");
                                    $.messager.alert('提示', errorMsg, 'info');
                                })
                            }
                        }, {
                            text: '取消',
                            handler: function () {
                                $("#ousername").val("");
                                $('#editDialog').dialog('close');
                            }
                        }]
                });
            }
            function append() {
                $("#oid").val("0");
                showDialog('edit', '新增', 'POST', 'putClass');
            }
            function showDialog(url, title, type, saveUrl) {
                var window1 = $('<div/>');
                $(window1).dialog({
                    title: title,
                    width: 1000,
                    height: 450,
                    closed: false,
                    cache: false,
                    href: url,
                    modal: true,
                    maximized: false,
                    maximizable: true,
                    onClose: function () {
                        $("#oid").val("0");
                        $(window1).dialog('clear');
                    },
                    buttons: [{
                            text: '确定',
                            handler: function () {
                                if (!($(window1).find('form').form('validate')))
                                {
                                    var data = $(window1).find('form').children();
                                    $.each(data, function (index, item) {
                                        if (!($(item).form('validate')))
                                        {

                                        }
                                    })
                                    return false;
                                }
                                var formData = $(window1).find('form').serializeArray();
                                $.each(formData, function (index, item) {
                                    switch (item.name)
                                    {
                                        case 'startdate':
                                            item.value = item.value.replace("-", "/").replace("-", "/");
                                            break;

                                        case 'enddate':
                                            item.value = item.value.replace("-", "/").replace("-", "/");
                                            break;
                                        case 'signenddate':
                                            item.value = item.value.replace("-", "/").replace("-", "/");
                                            break;
                                        case 'telldate':
                                            item.value = item.value.replace("-", "/").replace("-", "/");
                                            break;
                                    }
                                })
                                $.ajax({
                                    url: saveUrl,
                                    type: type,
                                    data: formData,
                                    dataType: 'json'
                                }).done(function (result) {
                                    if (!result.result) {
                                        $.messager.alert('提示', result.info, 'info');
                                    } else
                                    {
                                        $("#oid").val("0");
                                        if (result.result)
                                        {
                                            $.messager.show({
                                                title: '消息提示',
                                                msg: '修改成功',
                                                timeout: 2000,
                                                showType: 'slide'
                                            });
                                        }
                                        $('#class_grid').datagrid('reload');
                                        $(window1).dialog('clear');
                                        $(window1).dialog('close');
                                    }
                                }).error(function (errorMsg) {
                                    $.messager.alert('提示', errorMsg, 'info');
                                })
                            }
                        }, {
                            text: '取消',
                            handler: function () {
                                $("#oid").val("0");
                                $(window1).dialog('clear');
                                $(window1).dialog('close');
                            }
                        }]
                });
            }
            function removeIt() {
                var node = $('#class_grid').datagrid('getSelected');
                if (node) {
                    $.messager.confirm('提示', '确定删除此班级?', function (r) {
                        if (r) {
                            $.ajax({
                                url: 'deleteClass?id=' + node.n_id,
                                type: 'POST',
                                dataType: 'json'
                            }).done(function (result) {
                                if (!result.result) {
                                    $.messager.alert('提示', result.info, 'info');
                                }
                                $('#class_grid').datagrid('reload');
                            }).error(function (errorMsg) {
                                $.messager.alert('提示', errorMsg, 'info');
                            })
                        }
                    });
                } else {
                    $.messager.alert('提示', "至少选中一条目录", 'info');
                }

            }
            function editIt() {
                var node = $('#class_grid').datagrid('getSelected');
                if (node) {
                    $("#oid").val(node.n_id);
                    showDialog('edit', '编辑', 'POST', 'patchClass');
                } else
                {
                    $.messager.alert('提示', "至少选择一条数据!", 'info');
                }
            }
        </script>
    </body>
</html>
