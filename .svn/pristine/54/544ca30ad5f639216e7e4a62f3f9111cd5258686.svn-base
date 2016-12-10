<%-- 
    Document   : nlist
    Created on : 2016-10-18, 11:22:12
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
            function bindData() {
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
                if($("#tbUserName").val()!="")
                    _filterRules.push({"field": "username", "op": "contains", "value": $("#tbUserName").val()});
                else{
                    var _year = $("#cbYears").combobox("getValue");
                    _filterRules.push({"field": "year", "op": "custom", "value": _year});
                    if($("#tbNewPost").val()!="")
                        _filterRules.push({"field": "new_post", "op": "contains", "value": $("#tbNewPost").val()});
                }
                var _isgt = $("#cbisgt").get(0).checked?"1":"0";
                if(_isgt=="1")
                    _filterRules.push({"field": "crh", "op": "equals", "value": _isgt});
                
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
            function addData(){
                var con = '<iframe src="edit" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                $("#edit-window").html(con);
                $("#edit-window").window({title: '新职、转岗、晋升人员培训情况登记', width: '700px', height: '440px'});
                $("#edit-window").window("open");
            }
            function addDataSoon(){
                var row = $("#tt").datagrid("getSelected");
                if (row) {
                    var con = '<iframe src="edit?soon='+row.id+'" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                    $("#edit-window").html(con);
                    $("#edit-window").window({title: '新职、转岗、晋升人员培训情况登记', width: '700px', height: '440px'});
                    $("#edit-window").window("open");
                } else
                    $.messager.alert("提示", "请先选择一条现有数据！", "warning");
            }
            function editData(){
                var row = $("#tt").datagrid("getSelected");
                if (row) {
                    var con = '<iframe src="edit?id=' + row.id + '" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                    $("#edit-window").html(con);
                    $("#edit-window").window({title: '新职、转岗、晋升人员培训情况编辑[ ' + row.username + ' ]', width: '700px', height: '440px'});
                    $("#edit-window").window("open");
                } else
                    $.messager.alert("提示", "请选择要编辑的数据！", "warning");
            }
            function delData(){
                var row = $("#tt").datagrid("getSelected");
                if (row) {
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
            function datagridSelectRow(index, row){
                if(_usercompanyid==row.companyid && (_iseduuser || _iszjcuser)){
                    $("#btnEdit").linkbutton("enable");
                    $("#btnDele").linkbutton("enable");
                    $("#btnReLoad2").linkbutton("enable");
                    $("#btnAdd2").linkbutton("enable");
                    $("#btnImport2").linkbutton("enable");
                    $("#btnEdit2").linkbutton("enable");
                    $("#btnDele2").linkbutton("enable");
                }
                else{
                    $("#btnEdit").linkbutton("disable");
                    $("#btnDele").linkbutton("disable");
                    $("#btnReLoad2").linkbutton("disable");
                    $("#btnAdd2").linkbutton("disable");
                    $("#btnImport2").linkbutton("disable");
                    $("#btnEdit2").linkbutton("disable");
                    $("#btnDele2").linkbutton("disable");
                }
                bindData2();
            }
            function bindData2(){
                var row = $("#tt").datagrid("getSelected");
                if(row){
                    var enwid = row.id;
                    var pageNumber = $("#tt2").datagrid('getPager').data("pagination").options.pageNumber;
                    pageNumber = pageNumber === 0 ? 1 : pageNumber;
                    var pageSize = $("#tt2").datagrid('getPager').data("pagination").options.pageSize;
                    var _filterRules = [];
                    _filterRules.push({"field": "newpostid", "op": "equals", "value": enwid});
                    var filterRuleStr = "";
                    if (_filterRules.length > 0)
                        filterRuleStr = JSON.stringify(_filterRules);
                    m.ajax('get','getStudyContent',{page: pageNumber, rows: pageSize, filterRules: filterRuleStr, sort: "", order: ""},function(r){
                        if (r.result) {
                            $("#tt2").datagrid("loadData", r);
                            if (r.rows && r.rows.length > 0)
                                $("#tt2").datagrid("selectRow", 0);
                        } else
                            $.messager.alert("提示", r.info, "info");
                    });
                }
            }
            function addData2(){
                var row = $("#tt").datagrid("getSelected");
                if(row){
                    var con = '<iframe src="scedit?newpostid='+row.id+'" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                    $("#edit-window").html(con);
                    $("#edit-window").window({title: '添加人员学习内容', width: '400px', height: '315px'});
                    $("#edit-window").window("open");
                } else
                    $.messager.alert("提示", "请选择要添加学习内容的新、转、晋人员！", "warning");
            }
            function addData2Soon(){
                var row = $("#tt").datagrid("getSelected");
                if(row){
                    var con = '<iframe src="scsoonedit?id='+row.id+'&name='+escape(row.username)+'&dwid='+row.dwid+'&newpost='+escape(row.new_post)+'" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                    $("#edit-window").html(con);
                    $("#edit-window").window({title: '复制人员学习内容', width: '650px', height: '415px'});
                    $("#edit-window").window("open");
                } else
                    $.messager.alert("提示", "请选择要添加学习内容的新、转、晋人员！", "warning");
            }
            function editData2(){
                var row = $("#tt2").datagrid("getSelected");
                if (row) {
                    var con = '<iframe src="scedit?id=' + row.id + '" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                    $("#edit-window").html(con);
                    $("#edit-window").window({title: '编辑人员学习内容', width: '400px', height: '315px'});
                    $("#edit-window").window("open");
                } else
                    $.messager.alert("提示", "请选择要编辑的数据！", "warning");
            }
            function delData2(){
                var row = $("#tt2").datagrid("getSelected");
                if (row) {
                    $.messager.confirm("提示", "确定要删除学习内容[ " + row.study_content + " ]？", function (r) {
                        if (r)
                        {
                            m.ajax('post','delStudyContentById',{id:row.id},function(r){
                                $.messager.alert("提示", r.info, "info");
                                if (r.result) {
                                        bindData2();
                                    }
                            });
                        }
                    });
                } else
                    $.messager.alert("提示", "请选择要删除的数据！", "warning");
            }
            function bindUnit() {
                m.ajax('get','../specialjob/getAllUnit',{},function(r){
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
                });
            }
            function formatDate(value,row,index){
                if(value!="")
                    return value.split('-')[1] + "-" + value.split('-')[2];
                else return "";
            }
            function formatDate2(value,row,index){
                if(value!="")
                    return (value.split('-')[0]).substring(2,4) + "-" + value.split('-')[1] + "-" + value.split('-')[2];
                else return "";
            }
        </script>
    </head>
    <body>
        
        <div id='cc' class="easyui-layout" data-options="fit:true">
            <div data-options="region:'west',split:true" title="新、转、晋人员列表" style="width:800px">
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
                            <th data-options="field:'dworbm',align:'center'" rowspan="2">单位（部门）</th>
                            <th data-options="field:'new_post',align:'center'" rowspan="2">学习职名</th>
                            <th data-options="field:'aq',align:'center'" colspan="4">安全（入路）培训</th>
                            <th data-options="field:'ll',align:'center'" colspan="4">理论培训</th>
                            <th data-options="field:'sz',align:'center'" colspan="4">实作培训</th>
                            <th data-options="field:'fzrq',align:'center',formatter:formatDate2" rowspan="2">发证日期</th>
                            <th data-options="field:'dzl_date',align:'center',formatter:formatDate2" rowspan="2">下令日期</th>
                        </tr>
                        <tr>
                            <th data-options="field:'aq_begindate',align:'center',formatter:formatDate2">开始</th>
                            <th data-options="field:'aq_enddate',align:'center',formatter:formatDate">结束</th>
                            <th data-options="field:'aq_study_hour',align:'center'">学时</th>
                            <th data-options="field:'aq_cj',align:'center'">成绩</th>
                            <th data-options="field:'ll_begindate',align:'center',formatter:formatDate2">开始</th>
                            <th data-options="field:'ll_enddate',align:'center',formatter:formatDate">结束</th>
                            <th data-options="field:'ll_study_hour',align:'center'">学时</th>
                            <th data-options="field:'ll_cj',align:'center'">成绩</th>
                            <th data-options="field:'sz_begindate',align:'center',formatter:formatDate">开始</th>
                            <th data-options="field:'sz_enddate',align:'center',formatter:formatDate">结束</th>
                            <th data-options="field:'sz_study_hour',align:'center'">学时</th>
                            <th data-options="field:'sz_cj',align:'center'">成绩</th>
                        </tr>
                    </thead>
                </table>
                <div id="menuTollbar" style="height: auto;">
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-reload'" onclick="bindData();">刷新</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-add'" id="btnAdd" onclick="addData();">添加</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-add'" id="btnAdd" onclick="addDataSoon();">快捷添加</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-edit'" id="btnEdit" onclick="editData();">编辑</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-del'" id="btnDele" onclick="delData();">删除</a>
                    <div style="padding:2px;border-top:1px solid #D4D4D4;">
                        <span>单位：</span>
                        <input class="easyui-combobox" data-options="valueField:'id',textField:'name'" style="width:150px;" id="cbUnit">
                        <span style="padding-left:10px;">年度：</span>
                        <input class="easyui-combobox" data-options="valueField:'year',textField:'year',editable:false" style="width:60px;" id="cbYears">
                        <span>学习职名：</span>
                        <input class="easyui-textbox" style="width:120px" id="tbNewPost">
                        <span>姓名：</span>
                        <input class="easyui-textbox" style="width:80px" id="tbUserName">
                        <input type="checkbox" id="cbisgt" style="cursor:pointer"/><label for="cbisgt" style="cursor:pointer">高铁</label>
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-s-search'" onclick="bindData()">查询</a>
                    </div>
                </div>
            </div>
            <div data-options="region:'center'" title="学习内容">
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
                            <th data-options="field:'study_content',align:'left',width:200">学习内容</th>
                            <th data-options="field:'study_hours',align:'center'">学时</th>
                            <th data-options="field:'study_type',align:'center'">类别</th>
                            <th data-options="field:'teacher',align:'center'">主讲人</th>
                            <th data-options="field:'memo',align:'center'">成绩或备注</th>
                            <th data-options="field:'orderno',align:'center'">序号</th>
                        </tr>
                    </thead>
                </table>
                <div id="menuTollbar2" style="height: auto;">
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-reload'" id="btnReLoad2" onclick="bindData2();">刷新</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-add'" id="btnAdd2" onclick="addData2();">添加</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-add'" id="btnImport2" onclick="addData2Soon();">导入</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-edit'" id="btnEdit2" onclick="editData2();">编辑</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-del'" id="btnDele2" onclick="delData2();">删除</a>
                </div>
            </div>
        </div>
        <div id="edit-window" class="easyui-window" title="" data-options="modal:true,closed:true,iconCls:'icon-save',minimizable:false,collapsible:false" style="width:700px;height:440px;overflow:hidden;">

        </div>
    </body>
</html>
