<%-- 
    Document   : list
    Created on : 2016-11-4, 14:59:11
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
        <title>JSP Page</title>
        <%@include file="/WEB-INF/views/jspf/commonjs.jspf"%>
         <script>
            var _iseduuser = false;
            var _iszjcuser = false;
            var _usercompanyid = "";
            $(function () {
                anticsrf();
                _iseduuser = ${iseduuser};
                _iszjcuser = ${iszjcuser};
                _usercompanyid = "${usercompanyid}";
                $("#btnAdd").linkbutton("disable");
                $("#btnEdit").linkbutton("disable");
                $("#btnDele").linkbutton("disable");
                if (_iseduuser || _iszjcuser) {
                    $("#btnAdd").linkbutton("enable");
                }
                bindUnit();
                var yearArr=[];
                var nowyear = new Date().getFullYear();
                for (var i = nowyear; i > nowyear-10; i--) {
                    yearArr.push({"year":i});
                }
                $("#cbYears").combobox("loadData", yearArr);
                $("#cbYears").combobox("select", yearArr[0].year);
                bindData();
                $("#tt").datagrid('getPager').pagination({
                    onSelectPage: function () {
                        bindData();
                    }
                });
                $("#tt2").datagrid('getPager').pagination({
                    onSelectPage: function () {
                        bindData2();
                    }
                });
            });
            function bindUnit() {
                m.ajax('get','../specialjob/getAllUnit',{},function(r){
                    if (r.result) {
//                        r.rows.unshift({"id": "-1", "name": "--所有--"});
                        $("#cbUnit").combobox("loadData", r.rows);
                        if (_iszjcuser) {
                            $("#cbUnit").combobox("select", r.rows[0].id);
                        } else {
                            $("#cbUnit").combobox("select", _usercompanyid);
                            $("#cbUnit").combobox("disable");
                        }
                    }
                });
            }
            function bindData(){
                var index = layer.msg('加载数据中，请稍后...', {icon: 16, time: 10000, shade: [0.5, '#EAEAEA'], maxWidth: 230});
                var pageNumber = $("#tt").datagrid('getPager').data("pagination").options.pageNumber;
                pageNumber = pageNumber === 0 ? 1 : pageNumber;
                var pageSize = $("#tt").datagrid('getPager').data("pagination").options.pageSize;
                var _sort = $("#tt").datagrid('options').sortName;
                var _order = $("#tt").datagrid('options').sortOrder;
                if (_sort == null || _sort == "")
                    _order = "asc";
                
                var _filterRules = [];
                _filterRules.push({"field": "iszjcuser", "op": "custom", "value": _iszjcuser+""});
                var _dwid = $("#cbUnit").combobox("getValue");
                if (_dwid != "-1")
                    _filterRules.push({"field": "dwid", "op": "equals", "value": _dwid});
                var _year = $("#cbYears").combobox("getValue");
                _filterRules.push({"field": "year", "op": "custom", "value": _year});
                if($("#tbUserName").val()!="")
                    _filterRules.push({"field": "username", "op": "contains", "value": $("#tbUserName").val()});
                
                var filterRuleStr = "";
                if (_filterRules.length > 0)
                    filterRuleStr = JSON.stringify(_filterRules);
                m.ajax('get','allDatas',{page: pageNumber, rows: pageSize, filterRules: filterRuleStr, sort: _sort, order: _order},function(r){
                    if (r.result) {
                        $("#tt").datagrid("loadData", r);
                        if (r.rows && r.rows.length > 0)
                            $("#tt").datagrid("selectRow", 0);
                        else{
                            $("#tt2").datagrid("loadData", []);
                        }
                    } else
                        $.messager.alert("提示", r.info, "info");
                    layer.close(index);
                });
            }
            function bindData2(){
                var row = $("#tt").datagrid("getSelected");
                if (row) {
                    var pageNumber = $("#tt2").datagrid('getPager').data("pagination").options.pageNumber;
                    pageNumber = pageNumber === 0 ? 1 : pageNumber;
                    var pageSize = $("#tt2").datagrid('getPager').data("pagination").options.pageSize;
                    var _sort = $("#tt2").datagrid('options').sortName;
                    var _order = $("#tt2").datagrid('options').sortOrder;
                    if (_sort == null || _sort == "")
                        _order = "asc";

                    var _filterRules = [];
                    _filterRules.push({"field": "stu_idcard", "op": "equals", "value": row.userpid});
                    _filterRules.push({"field": "startdate", "op": "custom", "value": row.begindate});

                    var filterRuleStr = "";
                    if (_filterRules.length > 0)
                        filterRuleStr = JSON.stringify(_filterRules);
                    m.ajax('get','allLxDatas',{page: pageNumber, rows: pageSize, filterRules: filterRuleStr, sort: _sort, order: _order},function(r){
                        if (r.result) {
                            $("#tt2").datagrid("loadData", r);
                        } else
                            $.messager.alert("提示", r.info, "info");
                    });
                }
            }
            function datagridSelectRow(index, row){
                if(_usercompanyid==row.companyid && (_iseduuser || _iszjcuser)){
                    $("#btnEdit").linkbutton("enable");
                    $("#btnDele").linkbutton("enable");
                }
                else{
                    $("#btnEdit").linkbutton("disable");
                    $("#btnDele").linkbutton("disable");
                }
                bindData2();
            }
            function addData(){
                var con = '<iframe src="edit" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                $("#edit-window").html(con);
                $("#edit-window").window({title: '班组长培训情况登记', width: '700px', height: '440px'});
                $("#edit-window").window("open");
            }
            function editData(){
                var row = $("#tt").datagrid("getSelected");
                if (row) {
                    var con = '<iframe src="edit?id=' + row.id + '" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                    $("#edit-window").html(con);
                    $("#edit-window").window({title: '班组长培训情况编辑[ ' + row.username + ' ]', width: '700px', height: '440px'});
                    $("#edit-window").window("open");
                } else
                    $.messager.alert("提示", "请选择要编辑的数据！", "warning");
            }
            function delData(){
                var row = $("#tt").datagrid("getSelected");
                if (row) {
                    if(row.fzdw=="" || row.fzdate==""){
                        $.messager.alert("提示", "已经发证的数据不允许删除！", "error");
                        return;
                    }
                    $.messager.confirm("提示", "确定要删除[ " + row.username + " ]的信息？", function (r) {
                        if (r)
                        {
                            m.ajax('post','delDataById',{id:row.id},function(r){
                                $.messager.alert("提示", r.info, "info");
                                if (r.result) {
                                    bindData();
                                }
                            });
                        }
                    });
                } else
                    $.messager.alert("提示", "请选择要删除的数据！", "warning");
            }
            function fomatBz(value,row,index){
                var result = "";
                if(value!=""){
                    var arr = value.split('-');
                    result = arr.length>1?arr[1]:arr[0];
                }
                return result;
            }
            function fomatBm(value,row,index){
                var result = row.bz;
                if(result!=""){
                    var arr = result.split('-');
                    result = arr[0];
                }
                return result;
            }
            function fomatBirthday(value,row,index){
                var result = row.userpid;
                result = result.substring(6,10)+"-"+result.substring(10,12)+"-"+result.substring(12,14);
                return result;
            }
            function exportData(){
                var _dwid = $("#cbUnit").combobox("getValue");
                var _dwname = $("#cbUnit").combobox("getText");
                var _year = $("#cbYears").combobox("getValue");
                if (_dwid != "-1")
                    window.location="exportData?dwid="+_dwid+"&dwname="+_dwname+"&year="+_year;
                else
                    alert("请选择一个具体的单位数据导出");
            }
            function formatDate(value,row,index){
                if(value!="")
                    return value.split(' ')[0];
                else return "";
            }
        </script>
    </head>
    <body>
        <div id='cc' class="easyui-layout" data-options="fit:true">
            <div data-options="region:'west',split:true" title="班组长培训情况列表" style="width:800px">
                <table id="tt" class="easyui-datagrid" data-options="
                       rownumbers:true,
                       fit:true,
                       singleSelect:true,
                       pagination:true,
                       pageSize:20,
                       idField:'id',
                       onSelect:datagridSelectRow,
                       toolbar:'#menuTollbar'">
                    <thead>
                        <tr>
                            <th data-options="field:'username',align:'center'" rowspan="2">姓名</th>
                            <th data-options="field:'usersex',align:'center'" rowspan="2">性别</th>
                            <th data-options="field:'userbird',align:'center',formatter:fomatBirthday" rowspan="2">出生日期</th>
                            <th data-options="field:'bmm',align:'center',formatter:fomatBm" rowspan="2">部门(车间)</th>
                            <th data-options="field:'bz',align:'center',formatter:fomatBz" rowspan="2">班组</th>
                            <th data-options="field:'rzpx',align:'center'" colspan="5">任职培训</th>
                            <th data-options="field:'rzl',align:'center'" colspan="2">任职令</th>
                        </tr>
                        <tr>
                            <th data-options="field:'address',align:'center'">培训地点</th>
                            <th data-options="field:'begindate',align:'center'">开始日期</th>
                            <th data-options="field:'enddate',align:'center'">结束日期</th>
                            <th data-options="field:'study_hour',align:'center'">总学时</th>
                            <th data-options="field:'cj',align:'center'">考试成绩</th>
                            <th data-options="field:'dzldate',align:'center'">下令日期</th>
                            <th data-options="field:'dzlh',align:'center'">令号</th>
                        </tr>
                    </thead>
                </table>
                <div id="menuTollbar" style="height: auto;">
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-reload'" onclick="bindData();">刷新</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-add'" id="btnAdd" onclick="addData();">添加</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-edit'" id="btnEdit" onclick="editData();">编辑</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-del'" id="btnDele" onclick="delData();">删除</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-to-r'" id="btnExport" onclick="exportData();">导出台账</a>
                    <div style="padding:2px;border-top:1px solid #D4D4D4;">
                        <span>单位：</span>
                        <input class="easyui-combobox" data-options="valueField:'id',textField:'name'" style="width:150px;" id="cbUnit">
                        <span style="padding-left:10px;">年度：</span>
                        <input class="easyui-combobox" data-options="valueField:'year',textField:'year',editable:false" style="width:60px;" id="cbYears">
                        <span>姓名：</span>
                        <input class="easyui-textbox" style="width:80px" id="tbUserName">
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-s-search'" onclick="bindData()">查询</a>
                    </div>
                </div>
            </div>
            <div data-options="region:'center'" title="轮训记录">
                <table id="tt2" class="easyui-datagrid" data-options="
                       rownumbers:true,
                       fit:true,
                       singleSelect:true,
                       pagination:true,
                       pageSize:20,
                       idField:'id',
                       toolbar:'#menuTollbar2'">
                    <thead>
                        <tr>
                            <th data-options="field:'pxrq',align:'center'" colspan="2">培训日期</th>
                            <th data-options="field:'STU_PHY_POINTS',align:'center'" rowspan="2">考试成绩</th>
                        </tr>
                        <tr>
                            <th data-options="field:'STARTDATE',align:'center',formatter:formatDate">开始日期</th>
                            <th data-options="field:'ENDDATE',align:'center',formatter:formatDate">结束日期</th>
                        </tr>
                    </thead>
                </table>
                <div id="menuTollbar2" style="height: auto;">
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-reload'" id="btnReLoad2" onclick="bindData2();">刷新</a>
                </div>
            </div>
        </div>
        <div id="edit-window" class="easyui-window" title="" data-options="modal:true,closed:true,iconCls:'icon-save',minimizable:false,collapsible:false" style="width:700px;height:440px;overflow:hidden;">

        </div>
    </body>
</html>
