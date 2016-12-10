<%-- 
    Document   : index
    Created on : 2016-9-26, 15:18:53
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="_csrf" content="${_csrf.token}" />
        <meta name="_csrf_header" content="${_csrf.headerName}" />
        <title>培训班级报名</title>
    </head>
    <body>
            <table id="stu_class_grid" class="easyui-datagrid" 
                   data-options="url:'getClassPage?selects=1',method:'get',fitColumns:false,fit:true,idField:'n_id',checkbox:true,toolbar:'#tb',pagination:true,pageNumber:1,pageSize:20,sortOrder:'DESC',sortName:'n_id',singleSelect:true">
                <thead>
                    <tr>
                        <th data-options="field:'unitid',width:100,align:'center',hidden:true">编号</th>
                        <th data-options="field:'planunitid',width:100,align:'center',hidden:true">编号</th>
                        <th data-options="field:'execunitid',width:100,align:'center',hidden:true">编号</th>
                        <th data-options="field:'departmanid',width:100,align:'center',hidden:true">编号</th>
                        <th data-options="field:'projmanid',width:100,align:'center',hidden:true">编号</th>
                        <th data-options="field:'ck',checkbox:true"></th>
                        <th data-options="field:'refdocurl',formatter:planViewModel.stusFormatter,width:100,align:'center'">选择考生</th>
                        <th data-options="field:'n_id',width:100,align:'center'">编号</th>
                        <th data-options="field:'unit',width:150,align:'center'">单位</th>
                        <th data-options="field:'classno',width:100">班级编号</th>
                        <th data-options="field:'classname',width:400,align:'center'">班级名称</th>
                        <th data-options="field:'startdate',width:150,align:'center'">开始日期</th>
                        <th data-options="field:'enddate',width:150,align:'center'">结束日期</th>
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

                    </tr>
                </thead>
            </table>
            <div id="editDialog">
            </div>
            <div id="tb">
                <form id="stu_search_form">
                    <a id="btn" href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-edit'" data-bind="click:students_saved">选择考生</a>
                    <span>承办单位:</span> <span  data-bind="text:unit"></span>
                    <!--<a id="stu_btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" data-bind="click:class_grid_search">搜索</a>-->
                </form>           
            </div>
        <input type="hidden" name="stu_class_oid" id="stu_class_oid" value="" data-bind="value:stu_class_oid"/>   
    </body>
    <%@include file="/WEB-INF/views/jspf/commonjs.jspf"%>
    <script type="text/javascript">
        var user = GetUrlObj(window.location.href);
        $(function () {
            anticsrf();
        })
        planViewModel = {
            $plansTable1: $("#stu_class_oid"),
            $plansTable2: $("#plantable2"),
            $plancode: user.id,
            stu_class_oid: ko.observable(""),
            transfers: ko.observableArray([]),
            unit: ko.observable('${unit_name}'),
            newjob: ko.observable(""),
            init: function () {
                var self = this;
                ko.applyBindings(planViewModel);
            },
            class_grid_search: function (value, row, index)
            {
                return '<a href="' + row.review_url + '">查看附件</a>'
            },
            stusFormatter: function (value, row, index) {
                return '<a href="#" data-bind="click:students_saved" onclick="saved()">选择考生</a>';
            },
            students_saved: function () {
                var selectClass = $("#stu_class_grid").datagrid('getSelected');
                if (selectClass == undefined || selectClass == null)
                {
                    return;
                }
                this.stu_class_oid(selectClass.classno);
                this.newjob(selectClass.newpost);
                var window1 = $('<div/>')
                window1.dialog({
                    title: '选择考生',
                    width: 900,
                    height: 600,
                    closed: false,
                    maximizable: true,
                    cache: false,
                    href: 'stuSelect',
                    modal: true,
                    onClose: function () {
                        window1.dialog('clear');
                        planViewModel.stu_class_oid("");
                    },
                    buttons: [{
                            text: '取消',
                            handler: function () {
                                window1.dialog('clear');
                                window1.dialog('close');
                                planViewModel.stu_class_oid("");
                            }
                        }]
                });
            },
        }
        planViewModel.init();
        function  saved() {
            planViewModel.students_saved();
        }
    </script>
</html>
