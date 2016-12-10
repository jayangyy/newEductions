<%-- 
    Document   : list
    Created on : 2016-8-18, 10:56:11
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
        <title>职工管理</title>
        <%@include file="/WEB-INF/views/jspf/commonjs.jspf"%>
        <style>
            #post-dialog p{border-bottom: #575765 dashed 1px;line-height:28px;margin:0px;text-indent:2em;cursor:pointer;}
            #post-dialog p:hover{background-color: #EAEAEA}
            #post-dialog p.select{background-color:#D4D4D4}
        </style>
        <script type="text/javascript">
            var _iseduuser = false;
            var _usercompanyid = "";
            var _iszjcuser = false;
            $(document).ready(function () {
                anticsrf();
                _iseduuser = ${iseduuser};
                _usercompanyid = "${usercompanyid}";
                _iszjcuser = ${iszjcuser};
                bindUnit();
                bindSystem();
                var _dwid = $("#cbUnit").combobox("getValue");
                $("#btnSetGzGw").linkbutton("disable");
                if(_iszjcuser || (_iseduuser && _usercompanyid == _dwid) )
                    $("#btnSetGzGw").linkbutton("enable");
                $("#tt").datagrid('getPager').pagination({
                    onSelectPage: function () {
                        $("#tt").datagrid("unselectAll");
                        bindData();
                    }
                });
            });
            function bindData() {
//                layer.load(2,{shade:[0.8,'#EAEAEA']});
                var index = layer.msg('加载数据中，请稍后...',{icon:16,time:10000,shade:[0.5,'#EAEAEA'],maxWidth:230});
                var pageNumber = $("#tt").datagrid('getPager').data("pagination").options.pageNumber;
                pageNumber = pageNumber === 0 ? 1 : pageNumber;
                var pageSize = $("#tt").datagrid('getPager').data("pagination").options.pageSize;
                var _dwid = $("#cbUnit").combobox("getValue");
                var _bmid="";
                var node = $("#cbDepartment").tree("getSelected");
                _bmid=node.id;
                var _filterRules = [];
                if (_dwid != "" && _dwid != "-1")
                    _filterRules.push({"field": "dwid", "op": "equals", "value": _dwid});
                if (_bmid != "" && _bmid != "-1")
                    _filterRules.push({"field": "bmid", "op": "equals", "value": _bmid});
                if ($("#tbName").val() != "")
                    _filterRules.push({"field": "mhss", "op": "custom", "value": $("#tbName").val()});
                var pids = $("#searchPid").val().split("\n").join(",");
                if(pids!="")
                    _filterRules.push({"field": "em_idcard", "op": "in", "value":pids });
//                if ($("#tbPidNo").val() != "")
//                    _filterRules.push({"field": "em_idcard", "op": "contains", "value": $("#tbPidNo").val()});
                var filterRuleStr = "";
                if (_filterRules.length > 0)
                    filterRuleStr = JSON.stringify(_filterRules);
                var _sort = $("#tt").datagrid('options').sortName;
                var _order = $("#tt").datagrid('options').sortOrder;
                if (_sort == null || _sort == "")
                    _order = "asc";
                $.ajax({
                    type: 'get',
                    url: 'allEmployee',
                    data: {page: pageNumber, rows: pageSize, filterRules: filterRuleStr, sort: _sort, order: _order},
                    dataType: "json",
                    success: function (r) {
                        if (r.result) {
                            $("#tt").datagrid("loadData", r);
                            if (r.rows && r.rows.length > 0)
                                $("#tt").datagrid("selectRow", 0);
                        } else
                            $.messager.alert("提示", r.info, "info");
                        $('#pid-dialog').dialog('close');
                        layer.close(index);
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "error");
                        layer.close(index);
                    }
                });
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
            function bindDepartment(){
                var _dwid= $("#cbUnit").combobox("getValue");
                var _dwname= $("#cbUnit").combobox("getText");
                $.ajax({
                    type: 'get',
                    url: '../specialjob/getDepartmentTree',
                    data: {dwid:_dwid},
                    async: false,
                    dataType: "json",
                    success: function (r) {
                        if(r.result){
                            var root = [{"id": "-1", "text": _dwname,"children":r.rows}];
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
            function bindSystem(){
                $.ajax({
                    type: 'get',
                    url: 'allSys',
                    data: {},
                    dataType: "json",
                    success: function (r) {
                        if(r.result){
                            var _html = "";
                            for (var i = 0; i < r.rows.length; i++) {
                                var row = r.rows[i];
                                _html+="<p onclick='bindGzBySystem(this,"+row.id+")'>"+row.name+"</p>";
                            }
                            $("#sysDiv").html(_html);
                            $("#sysDiv p").eq(0).click();
                        }
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "error");
                    }
                });
            }
            function bindGzBySystem(obj,_sysid){
                pClick(obj);
                $.ajax({
                    type: 'get',
                    url: 'getgz',
                    data: {sysid:_sysid},
                    dataType: "json",
                    success: function (r) {
                        if(r.result){
                            var _html = "";
                            for (var i = 0; i < r.rows.length; i++) {
                                var row = r.rows[i];
                                _html+="<p onclick='bindGwByGz(this,"+row.id+")'>"+row.name+"</p>";
                            }
                            $("#gzDiv").html(_html);
                            $("#gzDiv p").eq(0).click();
                        }
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "error");
                    }
                });
            }
            function bindGwByGz(obj,_gzid){
                pClick(obj);
                $.ajax({
                    type: 'get',
                    url: 'getgw',
                    data: {gzid:_gzid},
                    dataType: "json",
                    success: function (r) {
                        if(r.result){
                            var _html = "";
                            for (var i = 0; i < r.rows.length; i++) {
                                var row = r.rows[i];
                                _html+="<p onclick='pClick(this)'>"+row.name+"</p>";
                            }
                            $("#gwDiv").html(_html);
                            $("#gwDiv p").eq(0).click();
                        }
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "error");
                    }
                });
            }
            function pClick(obj){
                $(obj).siblings().removeClass("select");
                $(obj).addClass("select");
            }
            function searchClick() {
                $("#searchPid").val("");
                $("#tt").datagrid("unselectAll");
                bindData();
            }
            function datagridSort() {
                $("#tt").datagrid("unselectAll");
                bindData();
            }
            function setGzGwClick(){
                var rows = $("#tt").datagrid("getSelections");
                if (rows.length <= 0) {
                    $.messager.alert("提示", '请选择要设置工种岗位的职工！', "info");
                    return;
                }else{
                    $("#post-dialog").dialog("open");
                }
            }
            var _iscustom=false;
            function saveClick(){
                var rows = $("#tt").datagrid("getSelections");
                //工种
                var _gz = $("#gzDiv").find(".select").html();
                //岗位
                var _gw = $("#gwDiv").find(".select").html();
                
                if(_iscustom)
                {
                    _gz=$("#tbGz").val();
                    _gw=$("#tbGw").val();
                }
                $.messager.confirm("提示", "确定要设置所选职工的工种为：[" + _gz + "]和岗位为：["+_gw+"]？", function (r) {
                    if (r)
                    {
                        var _uids = "";
                        for (var i = 0; i < rows.length; i++) {
                            _uids += rows[i].em_id + ",";
                        }
                        _uids = _uids.substring(0, _uids.length - 1);
                        $.ajax({
                            type: 'post',
                            url: 'setGzgw',
                            data: {uids:_uids,gz:_gz,gw:_gw},
                            dataType: "json",
                            success: function (r) {
                                if(r.result){
                                    $.messager.alert("提示", "操作成功！", "alert");
                                    bindData();
                                    $("#post-dialog").dialog("close");
                                }
                            },
                            error: function () {
                                $.messager.alert("提示", "调用后台接口出错！", "error");
                            }
                        });
                    }
                });
            }
            function customGzGw(checked){
                if(checked) {$("#tbGz,#tbGw").textbox("enable");_iscustom=true;}
                else {$("#tbGz,#tbGw").textbox("disable");_iscustom=false;}
            }
            function datagridRowClick(index, row) {
                $("#tt").datagrid("unselectAll");
                $("#tt").datagrid("selectRow", index);
            }
            function formatViewGpz(value,row,index){
                if(value) return "<a target='_blank' href='view?pid="+row.em_idcard+"'>"+value+"</a>";
                else return "";
            }
        </script>
        </head>
    <body>
        
        <div id='cc' class="easyui-layout" data-options="fit:true">
            <div data-options="region:'west',split:true" title="部门列表" style="width:260px">
                <div class="easyui-layout" data-options="fit:true">
                    <div data-options="region:'north'" style="height:40px;padding:8px 10px;">
                        单位：
                        <input class="easyui-combobox" data-options="valueField:'id',textField:'name',onChange:bindDepartment" style="width:150px;" id="cbUnit">
                    </div>
                    <div data-options="region:'center',split:true" style="padding:5px;">
                        <ul class="easyui-tree" data-options="onSelect:bindData" id="cbDepartment"></ul>
                    </div>
                </div>
            </div>
            <div data-options="region:'center',split:true">
                <table id="tt" title="职工列表" class="easyui-datagrid" data-options="
                       rownumbers:true,
                       fit:true,
                       singleSelect:false,
                       pagination:true,
                       pageSize:20,
                       idField:'em_id',
                       onSortColumn:datagridSort,
                       onClickRow:datagridRowClick,
                       toolbar:'#menuTollbar'">
                    <thead>
                        <tr>
                            <th data-options="field:'ck',checkbox:true"></th>
                            <th data-options="field:'dwname',width:120,align:'center',halign:'center',sortable:'true'">单位</th>
                            <th data-options="field:'bmname',width:160,align:'center',halign:'center',sortable:'true'">部门</th>
                            <th data-options="field:'em_name',width:80,align:'center',halign:'center',sortable:'true'">姓名</th>
                            <th data-options="field:'em_egender',width:50,align:'center',halign:'center',sortable:'true'">性别</th>
                            <th data-options="field:'em_idcard',width:140,align:'center',halign:'center',sortable:'true'">身份证号码</th>
                            <!--<th data-options="field:'gh',width:80,align:'center',halign:'center',sortable:'true'">工号</th>-->
                            <th data-options="field:'em_gz',width:120,align:'center',halign:'center',sortable:'true'">工种</th>
                            <th data-options="field:'em_gw',width:160,align:'center',halign:'center',sortable:'true'">岗位/职务</th>
                            <th data-options="field:'em_gpz',width:160,align:'center',halign:'center',sortable:'true',formatter:formatViewGpz">岗培证</th>
                            <!--<th data-options="field:'zzmm',width:80,align:'center',halign:'center'">政治面貌</th>-->
                            <!--<th data-options="field:'zp',width:80,align:'center',halign:'center'">照片</th>-->
                        </tr>
                    </thead>
                </table>
                <div id="menuTollbar" style="height: auto;">
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-reload'" onclick="bindData();">刷新</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-add'" id="btnSetGzGw" onclick="setGzGwClick();">设置工种岗位</a>
                    <div style="padding:2px;border-top:1px solid #D4D4D4;">
                        <span>模糊搜索：</span>
                        <input class="easyui-textbox" style="width:200px" id="tbName" data-options="prompt:'姓名/工种/岗位'">
<!--                        <span>身份证号：</span>
                        <input class="easyui-textbox" style="width:120px" id="tbPidNo">-->
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-s-search'" onclick="searchClick()">查询</a>
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-s-search'" onclick="$('#pid-dialog').dialog('open');">身份证号批量搜索</a>
                    </div>
                </div>
            </div>
        </div>
        
        <div id="post-dialog" class="easyui-dialog" title="工种岗位选择" data-options="closed:true,iconCls:'icon-save',buttons: '#post-dlg-buttons'" style="width:600px;height:450px;padding:10px;">
            <div id='cc' class="easyui-layout" data-options="fit:true">
                <div data-options="region:'south'" style="height:40px;line-height: 38px;padding-left: 10px;">
                    <input id="btnCustom" class="easyui-switchbutton" data-options="offText:'打开自定义工种岗位',onText:'关闭自定义工种岗位',width:140,onChange:customGzGw">
                    <input class="easyui-textbox" style="width:150px;" id="tbGz" data-options="prompt:'请输入工种',disabled:true">
                    <input class="easyui-textbox" style="width:150px;" id="tbGw" data-options="prompt:'请输入岗位',disabled:true">
                </div>
                <div data-options="region:'west',split:true" id="sysDiv" title="系统选择" style="width:85px;">
                    
                </div>
                <div data-options="region:'center',split:true" id="gzDiv" title="工种选择">
                    
                </div>
                <div data-options="region:'east',split:true" id="gwDiv" title="岗位选择" style="width:260px;">
                    
                </div>
            </div>
        </div>
        <div id="post-dlg-buttons">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveClick()">确认</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-no'" onclick="$('#post-dialog').dialog('close');">关闭</a>
        </div>
        
        <div id="pid-dialog" class="easyui-dialog" title="身份证号批量搜索" data-options="closed:true,iconCls:'icon-save',buttons: '#pid-dlg-buttons'" style="width:200px;height:400px; padding:5px;">
            <!--<input class="easyui-textbox" id="searchPid" multiline="true" data-options="fit:true,prompt:'身份证号码：一行一个。'">-->
            <textarea id="searchPid" style="width:170px;height:307px;" placeholder="身份证号码：一行一个。"></textarea>
        </div>
        <div id="pid-dlg-buttons">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="bindData()">确认</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-no'" onclick="$('#pid-dialog').dialog('close');">关闭</a>
        </div>
        
    </body>
</html>
