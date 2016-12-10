<%-- 
    Document   : list
    Created on : 2016-8-11, 15:36:00
    Author     : milord
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="_csrf" content="${_csrf.token}"/>
        <meta name="_csrf_header" content="${_csrf.headerName}"/>
        <title>列表页</title>
        <%@include file="/WEB-INF/views/jspf/commonjs.jspf"%>
        <script type="text/javascript">
            var _teacherTypeData = [{"code": "all", "name": "全部"}, {"code": "iszz", "name": "职教专职人员"}, {"code": "isjpjz", "name": "局聘兼职教师"}, {"code": "iszdjz", "name": "站段兼职教师"}];
            var _iszjcuser = false;
            var _zjcid="";
            var _usercompanyid = "";
            var _isadmin = false;
            $(document).ready(function () {
                anticsrf();
                _zjcid = "${zjcid}";
                _iszjcuser = ${iszjcuser};
                _isadmin = ${isadmin};
                _usercompanyid = "${usercompanyid}";
                $("#btnAdd").linkbutton("disable");
                $("#btnEdit").linkbutton("disable");
                $("#btnDele").linkbutton("disable");
                if (_iszjcuser || _isadmin) {
                    $("#btnAdd").linkbutton("enable");
                    $("#btnEdit").linkbutton("enable");
                    $("#btnDele").linkbutton("enable");
                }
                $("#btnExport1").hide();
                $("#btnExport2").hide();
                $("#btnExport3").hide();
                $("#cbTeacherType").combobox("loadData", _teacherTypeData);
                $("#cbTeacherType").combobox("select", _teacherTypeData[0].code);
                if(_iszjcuser){
                    $("#btnExport1").show();
                    $("#btnExport2").show();
//                    $("#cbTeacherType").combobox("select", _teacherTypeData[0].code);
//                    $("#cbTeacherType").combobox("enable");
                }
                else{
                    $("#btnExport3").show();
//                    $("#cbTeacherType").combobox("select", "iszdjz");
//                    $("#cbTeacherType").combobox("disable");
                }
                bindUnit();
                $("#tt").datagrid('getPager').pagination({
                    onSelectPage: function () {
                        bindData();
                    }
                });
            });
            function bindData() {
                var index = layer.msg('加载数据中，请稍后...', {icon: 16, time: 10000, shade: [0.5, '#EAEAEA'], maxWidth: 230});
                var pageNumber = $("#tt").datagrid('getPager').data("pagination").options.pageNumber;
                pageNumber = pageNumber === 0 ? 1 : pageNumber;
                var pageSize = $("#tt").datagrid('getPager').data("pagination").options.pageSize;
                var _filterRules = [];
                var _teacherType = $("#cbTeacherType").combobox("getValue");
                if (_teacherType && _teacherType != "all")
                    _filterRules.push({"field": _teacherType, "op": "equals", "value": 1});
                var _dwid = $("#cbUnit").combobox("getValue");
                if ($("#tbName").val() != "")
                    _filterRules.push({"field": "name", "op": "contains", "value": $("#tbName").val()});
                if ($("#tbSubjectType").val() != "")
                    _filterRules.push({"field": "subject", "op": "custom", "value": $("#tbSubjectType").val()});
                if (_dwid != "-1")
                    _filterRules.push({"field": "dwid", "op": "equals", "value": _dwid});
                var filterRuleStr = "";
                if (_filterRules.length > 0)
                    filterRuleStr = JSON.stringify(_filterRules);
                var _sort = $("#tt").datagrid('options').sortName;
                var _order = $("#tt").datagrid('options').sortOrder;
                $.ajax({
                    type: 'get',
                    url: 'allTeachers',
                    data: {page: pageNumber, rows: pageSize, filterRules: filterRuleStr, sort: _sort, order: _order},
                    dataType: "json",
                    success: function (r) {
                        if (r.result) {
//                            $("#tt").datagrid({
//                                data: r, columns: getData1Colums(_teacherType)
//                            });
                            $("#tt").datagrid("loadData", r);
                            if (r.rows.length > 0)
                                $("#tt").datagrid("selectRow", 0);
                        } else
                            $.messager.alert("提示", r.info, "info");
                        layer.close(index);
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "error");
                        layer.close(index);
                    }
                });
            }
            function getData1Colums(type) {
                var colums;
                if (type == "all") {
                    colums = [[
                            {field: 'dwname', title: '单位', width: 100, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'bmtreename', title: '部门', width: 200, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'name', title: '姓名', width: 100, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'sex', title: '性别', width: 50, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'birthday', title: '出生日期', width: 80, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'em_gz', title: '职务', width: 80, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'edu_date', title: '专职人员<br>从教时间', width: 95, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'hire_date', title: '兼职教师<br>聘任日期', width: 95, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'jxjy_date', title: '继续教育日期', width: 95, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'cert', title: '资格证书', width: 130, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'prof', title: '专业', width: 130, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'memo', title: '备注', width: 130, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'drkc', title: '担任课程', width: 130, align: 'center', halign: 'center', colspan: 2}
                        ], [
                            {field: 'll', title: '理论', width: 100, align: 'center', halign: 'center', sortable: true}
                            , {field: 'sz', title: '实作', width: 100, align: 'center', halign: 'center', sortable: true}
                        ]];
                } else if (type == "iszz") {
                    colums = [[
                            {field: 'type', title: '分类', width: 100, align: 'center', halign: 'center', formatter: formatType}
                            , {field: 'bmname', title: '单位（部门）名称', width: 160, align: 'center', halign: 'center', sortable: true}
                            , {field: 'name', title: '姓名', width: 100, align: 'center', halign: 'center', sortable: true}
                            , {field: 'sex', title: '性别', width: 50, align: 'center', halign: 'center', sortable: true}
                            , {field: 'birthday', title: '出生日期', width: 80, align: 'center', halign: 'center', sortable: true}
                            , {field: 'em_politicalstatus', title: '政治面貌', width: 80, align: 'center', halign: 'center', sortable: true}
                            , {field: 'em_gz', title: '职务/职称', width: 150, align: 'center', halign: 'center', sortable: true}
                            , {field: 'em_graduatedfrom', title: '毕业院校', width: 150, align: 'center', halign: 'center', sortable: true}
                            , {field: 'em_sxzy', title: '专业', width: 150, align: 'center', halign: 'center', sortable: true}
                            , {field: 'em_eduback', title: '学历', width: 150, align: 'center', halign: 'center', sortable: true}
                            , {field: 'edu_date', title: '聘用（下令）<br>日期', width: 95, align: 'center', halign: 'center', sortable: true}
                            , {field: 'memo', title: '备注', width: 130, align: 'center', halign: 'center', sortable: true}
                        ]];
                } else if (type == "isjpjz") {
                    colums = [[
                            {field: 'system', title: '系统', width: 100, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'prof', title: '执教专业', width: 100, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'name', title: '姓名', width: 100, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'dwname', title: '单位', width: 160, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'em_gz', title: '职务', width: 80, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'em_joblevel', title: '技术职称<br>(技能等级)', width: 130, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'zjjl', title: '执教经历<br>(成果及获奖情况，特、专长)', width: 200, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'drkc', title: '担任课程', width: 130, align: 'center', halign: 'center', colspan: 2}
                        ], [
                            {field: 'll', title: '理论', width: 100, align: 'center', halign: 'center', sortable: true}
                            , {field: 'sz', title: '实作', width: 100, align: 'center', halign: 'center', sortable: true}
                        ]];
                } else if (type == "iszdjz") {
                    colums = [[
                            {field: 'name', title: '姓名', width: 100, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'sex', title: '性别', width: 50, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'birthday', title: '出生日期', width: 80, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'bmname', title: '所在部门', width: 200, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'em_eduback', title: '文化程度', width: 80, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'em_degree', title: '学历类别', width: 80, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'em_graduatedfrom', title: '毕业学校', width: 80, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'em_sxzy', title: '所学专业', width: 80, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'em_gz', title: '职务', width: 80, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'em_joblevel', title: '技术职称<br>(技能等级)', width: 80, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'drkc', title: '担任课程', width: 130, align: 'center', halign: 'center', colspan: 2}
                            , {field: 'edu_date', title: '专职人员<br>从教时间', width: 95, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                            , {field: 'hire_date', title: '兼职教师<br>聘任日期', width: 95, align: 'center', halign: 'center', sortable: true, rowspan: 2}
                        ], [
                            {field: 'll', title: '理论', width: 100, align: 'center', halign: 'center', sortable: true}
                            , {field: 'sz', title: '实作', width: 100, align: 'center', halign: 'center', sortable: true}
                        ]];
                }
                return colums;
            }
            function formatType(value, row, index) {
                if (row.dwid==_zjcid)
                    return "路局职教部门";
                else if (row.dwname.endWith("基地"))
                    return "局级培训基地";
                else
                    return "基层站段";
            }
            function searchClick() {
                $("#tt").datagrid("unselectAll");
                bindData();
            }
            function addData() {
                var con = '<iframe src="edit" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                $("#edit-window").html(con);
                $("#edit-window").window({title: '新增兼职教师'})
                $("#edit-window").window("open");
            }
            function editData() {
                var row = $("#tt").datagrid("getSelected");
                if (row) {
                    var con = '<iframe src="edit?pid=' + row.pid + '" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                    $("#edit-window").html(con);
                    $("#edit-window").window({title: '编辑兼职教师[ ' + row.name + ' ]'})
                    $("#edit-window").window("open");
                } else
                    $.messager.alert("提示", "请选择要编辑的数据！", "warning");
            }
            function delData() {
                var row = $("#tt").datagrid("getSelected");
                if (row) {
                    $.messager.confirm("提示", "确定要删除兼职教师[ " + row.name + " ]？", function (r) {
                        if (r)
                        {
                            $.ajax({
                                type: 'delete',
                                url: 'teacher/' + row.pid,
                                data: {},
                                dataType: "json",
                                success: function (r) {
                                    $.messager.alert("提示", r.info, "info");
                                    if (r.result) {
                                        bindData();
                                    }
                                },
                                error: function () {
                                    $.messager.alert("提示", "调用后台接口出错！", "error");
                                }
                            });
                        }
                    });
                } else
                    $.messager.alert("提示", "请选择要删除的数据！", "warning");
            }
            function bindUnit() {
                $.ajax({
                    type: 'get',
                    url: '../specialjob/getAllUnit',
                    data: {},
                    async: false,
                    dataType: "json",
                    success: function (r) {
                        if (r.result) {
                            r.rows.unshift({"id": "-1", "name": "--所有--"});
                            $("#cbUnit").combobox("loadData", r.rows);
                            if (_iszjcuser) {
                                $("#cbUnit").combobox("select", r.rows[0].id);
                            } else {
                                $("#cbUnit").combobox("select", _usercompanyid);
                                $("#cbUnit").combobox("disable");
                            }
                        }
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "error");
                    }
                });
            }
            function bindDepartment() {
                var _dwid = $("#cbUnit").combobox("getValue");
                var _dwname = $("#cbUnit").combobox("getText");
                $.ajax({
                    type: 'get',
                    url: '../specialjob/getDepartmentTree',
                    data: {dwid: _dwid},
                    async: false,
                    dataType: "json",
                    success: function (r) {
                        if (r.result) {
                            var root = [{"id": "-1", "text": _dwname, "children": r.rows}];
//                            r.rows.unshift();
                            $("#cbDepartment").tree("loadData", root);
                            $("#cbDepartment").tree("select", $("#cbDepartment").tree("getRoot").target);
                        }
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "error");
                    }
                });
            }
            function exportData() {

            }
            function exportData(ty,tyname){
//                layer.msg('文件下载中，请稍后...', {icon: 16, time: 5000, shade: [0.5, '#EAEAEA'], maxWidth: 230});
                var _dwid = $("#cbUnit").combobox("getValue");
                window.location="exportData?type="+ty+"&typename="+tyname+"&dwid="+_dwid;
//                $.ajax({
//                    type: 'get',
//                    url: 'exportData',
//                    data: {type:ty,typename:tyname},
//                    success: function (r) {
//                    },
//                    error: function () {
//                        $.messager.alert("提示", "调用后台接口出错！", "error");
//                    }
//                });
            }
            function formatUserType(value,row,index){
                var temp = "";
                if(row.iszz=="1")
                    temp+="职教专职人员，";
                if(row.isjpjz=="1")
                    temp+="局聘兼职教师，";
                if(row.iszdjz=="1")
                    temp+="站段兼职教师，";
                temp = temp.substring(0,temp.length-1);
                return temp;
            }
        </script>
    </head>
    <body>
        <table id="tt" title="教师列表" class="easyui-datagrid" data-options="
               rownumbers:true,
               fit:true,
               singleSelect:true,
               pagination:true,
               pageSize:20,
               idField:'pid',
               onSortColumn:bindData,
               toolbar:'#menuTollbar'">
            <thead>
                <tr>
                    <!--<th data-options="field: 'type', title: '分类', width: 100, align: 'center', halign: 'center', formatter: formatType, rowspan: 2"></th>-->
                    <!--<th data-options="field: 'bmtreename', title: '部门', width: 200, align: 'center', halign: 'center', rowspan: 2"></th>-->
                    <th data-options="field: 'name', title: '姓名', width: 100, align: 'center', halign: 'center', rowspan: 2"></th>
                    <th data-options="field: 'sex', title: '性别', width: 50, align: 'center', halign: 'center', rowspan: 2"></th>
                    <th data-options="field: 'birthday', title: '出生日期', width: 80, align: 'center', halign: 'center', rowspan: 2"></th>
                    <th data-options="field: 'dwname', title: '单位', width: 100, align: 'center', halign: 'center', rowspan: 2"></th>
                    <!--<th data-options="field: 'em_politicalstatus', title: '政治面貌', width: 80, align: 'center', halign: 'center', rowspan: 2"></th>-->
                    <!--<th data-options="field: 'em_graduatedfrom', title: '毕业院校', width: 150, align: 'center', halign: 'center', rowspan: 2"></th>-->
                    <!--<th data-options="field: 'em_sxzy', title: '专业', width: 150, align: 'center', halign: 'center', rowspan: 2"></th>-->
                    <!--<th data-options="field: 'em_eduback', title: '学历', width: 150, align: 'center', halign: 'center', rowspan: 2"></th>-->
                    <th data-options="field: 'em_gz', title: '职务', width: 80, align: 'center', halign: 'center', rowspan: 2"></th>
                    <th data-options="field: 'rylx', title: '人员类型', width: 120, align: 'center', halign: 'center', rowspan: 2,formatter:formatUserType"></th>
                    <!--<th data-options="field: 'jxjy_date', title: '继续教育日期', width: 95, align: 'center', halign: 'center', rowspan: 2"></th>-->
                    <!--<th data-options="field: 'cert', title: '资格证书', width: 80, align: 'center', halign: 'center', rowspan: 2"></th>-->
                    <th data-options="field: 'drkc', title: '担任课程', width: 130, align: 'center', halign: 'center', colspan: 2"></th>
                    <th data-options="field: 'prof', title: '专业', width: 80, align: 'center', halign: 'center', rowspan: 2"></th>
                    <th data-options="field: 'edu_date', title: '专职人员<br>从教时间', width: 95, align: 'center', halign: 'center', rowspan: 2"></th>
                    <th data-options="field: 'hire_date', title: '兼职教师<br>聘任日期', width: 95, align: 'center', halign: 'center', rowspan: 2"></th>
                    <th data-options="field: 'phone', title: '办公电话', width: 95, align: 'center', halign: 'center', rowspan: 2"></th>
                    <th data-options="field: 'mobile', title: '移动电话', width: 95, align: 'center', halign: 'center', rowspan: 2"></th>
                    <th data-options="field: 'xh', title: '序号', width: 95, align: 'center', halign: 'center', rowspan: 2"></th>
                    <!--<th data-options="field: 'memo', title: '备注', width: 130, align: 'center', halign: 'center', rowspan: 2"></th>-->
                </tr>
                <tr>
                    <th data-options="field: 'll', title: '理论', width: 100, align: 'center', halign: 'center'"></th>
                    <th data-options="field: 'sz', title: '实作', width: 100, align: 'center', halign: 'center'"></th>
                </tr>
            </thead>
        </table>
        <div id="menuTollbar" style="height: auto;">
            <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-reload'" onclick="bindData();">刷新</a>
            <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-add'" id="btnAdd" onclick="addData();">添加</a>
            <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-edit'" id="btnEdit" onclick="editData();">编辑</a>
            <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-del'" id="btnDele" onclick="delData();">删除</a>
            <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-to-r'" id="btnExport1" onclick="exportData(1,'职工教育专职人员基本概况');">导出职教专职人员表</a>
            <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-to-r'" id="btnExport2" onclick="exportData(2,'局聘培训师资登记表');">导出局聘培训师资表</a>
            <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-to-r'" id="btnExport3" onclick="exportData(3,'职工教育专兼职培训师资登记表');">导出职教专兼职培训师资表</a>
            <div style="padding:2px;border-top:1px solid #D4D4D4;">
                <span>单位：</span>
                <input class="easyui-combobox" data-options="valueField:'id',textField:'name',onChange:bindData" style="width:150px;" id="cbUnit">
                <span style="padding-left:10px;">类型：</span>
                <input class="easyui-combobox" data-options="valueField:'code',textField:'name',onChange:bindData" style="width:100px;" id="cbTeacherType">
                <span>姓名：</span>
                <input class="easyui-textbox" style="width:120px" id="tbName">
                <span>课程：</span>
                <input class="easyui-textbox" style="width:120px" id="tbSubjectType">
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-s-search'" onclick="searchClick()">查询</a>
            </div>
        </div>

        <div id="edit-window" class="easyui-window" title="" data-options="modal:true,closed:true,iconCls:'icon-save',minimizable:false,collapsible:false" style="width:660px;height:480px;overflow:hidden;">

        </div>
    </body>
</html>
