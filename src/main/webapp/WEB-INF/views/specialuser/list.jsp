<%-- 
    Document   : list
    Created on : 2016-8-1, 16:25:53
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
        <title>特种设备作业人员证书</title>
        <%@include file="/WEB-INF/views/jspf/commonjs.jspf"%>
        <script type="text/javascript">
            var _iszjcuser=false;
            var _iseduuser=false;
            var _usercompanyid="";
            $(document).ready(function () {
                anticsrf();
                _iszjcuser = ${iszjcuser};
                _iseduuser = ${iseduuser};
                _usercompanyid = "${usercompanyid}";
                $("#btnAdd").linkbutton("disable");
                $("#btnAdd2").linkbutton("disable");
                $("#btnBatchAdd").linkbutton("disable");
                $("#btnBatchAdd2").linkbutton("disable");
                $("#btnEdit").linkbutton("disable");
                $("#btnDele").linkbutton("disable");
                $("#btnEdit2").linkbutton("disable");
                $("#btnDele2").linkbutton("disable");
                if(_iseduuser || _iszjcuser){
                    $("#btnAdd").linkbutton("enable");
                    $("#btnAdd2").linkbutton("enable");
                    $("#btnBatchAdd").linkbutton("enable");
                    $("#btnBatchAdd2").linkbutton("enable");
                }
                var token = $("meta[name='_csrf']").attr("content");
                var header = $("meta[name='_csrf_header']").attr("content");
                $('#upload').uploadify({
                    swf: '../s/js/uploadify/uploadify.swf',
                    uploader: 'importexcel?_csrf='+token+'&_csrf_header='+header,
                    queueID: 'filelist',
                    buttonText: '选择文件',
                    auto: false,
                    multi:false,
                    fileTypeExts:'*.xls; *.xlsx',
                    onUploadSuccess:function(file,data,response){
                        var r = eval("["+data+"]")[0];
                        $.messager.alert("提示", r.info, "info");
                        $(".messager-icon").hide();
                        if(r.result){
                            bindData();
                            bindData2();
                            $("#import-dialog").dialog("close");
                        }
                    }
                });
                bindUnit();
                bindData();
                $("#tt").datagrid('getPager').pagination({
                    onSelectPage: function () {
                        bindData();
                    }
                });
            });
            function bindData() {
                var pageNumber = $("#tt").datagrid('getPager').data("pagination").options.pageNumber;
                pageNumber = pageNumber === 0 ? 1 : pageNumber;
                var pageSize = $("#tt").datagrid('getPager').data("pagination").options.pageSize;
                var _dwid = $("#cbUnit").combobox("getValue");
                var _bmid="";
                var node = $("#cbDepartment").tree("getSelected");
                _bmid=node.id;
                var _filterRules = [];
                if (_dwid != "-1")
                    _filterRules.push({"field": "dwid", "op": "equals", "value": _dwid});
                if (_bmid != "-1")
                    _filterRules.push({"field": "bmid", "op": "equals", "value": _bmid});
                if($("#tbName").val())
                    _filterRules.push({"field": "name", "op": "contains", "value": $("#tbName").val()});
                if($("#tbAwardUnit").val())
                    _filterRules.push({"field": "award_unit", "op": "contains", "value": $("#tbAwardUnit").val()});
                if ($("#tbNo").val())
                    _filterRules.push({"field": "no", "op": "custom", "value": $("#tbNo").val()});
                var filterRuleStr = "";
                if (_filterRules.length > 0)
                    filterRuleStr = JSON.stringify(_filterRules);
                var _sort = $("#tt").datagrid('options').sortName;
                var _order = $("#tt").datagrid('options').sortOrder;
                if (_sort == null || _sort == "")
                    _order = "desc";
                $.ajax({
                    type: 'get',
                    url: 'allCards',
                    data: {page: pageNumber, rows: pageSize, filterRules: filterRuleStr, sort: _sort, order: _order},
                    dataType: "json",
                    success: function (r) {
                        if (r.result) {
                            $("#tt").datagrid("loadData", r);
                            if (r.rows.length > 0)
                                $("#tt").datagrid("selectRow", 0);
                            else
                                $("#tt2").datagrid("loadData", []);
                        } else
                            $.messager.alert("提示", r.info, "info");
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "error");
                    }
                });
            }
            function addCard() {
                var con = '<iframe src="edit" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                $("#card-window").html(con);
                $("#card-window").window({title: '新增特种人员信息'})
                $("#card-window").window("open");
            }
            function editCard() {
                var row = $("#tt").datagrid("getSelected");
                if (row) {
                    var con = '<iframe src="edit?pid=' + row.pid + '" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                    $("#card-window").html(con);
                    $("#card-window").window({title: '编辑特种作业人员[ ' + row.name + ' ]'})
                    $("#card-window").window("open");
                } else
                    $.messager.alert("提示", "请选择要编辑的数据！", "warning");
            }
            function delCard() {
                var row = $("#tt").datagrid("getSelected");
                if (row) {
                    $.messager.confirm("提示", "确定要删除特种作业人员[ " + row.name + " ]？", function (r) {
                        if (r)
                        {
                            $.ajax({
                                type: 'delete',
                                url: 'card/' + row.pid,
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
            function batchAddCard(){
                $("#import-dialog").dialog("open");
            }
            function saveImportClick(){
                $('#upload').uploadify("upload", "*");
            }
            function searchClick() {
                $("#tt").datagrid("unselectAll");
                bindData();
            }
            function searchClick2() {
                $("#tt2").datagrid("unselectAll");
                bindData2();
            }
            function bindData2(){
                var row = $("#tt").datagrid("getSelected");
                if(row){
                    var pageNumber = $("#tt2").datagrid('getPager').data("pagination").options.pageNumber;
                    pageNumber = pageNumber === 0 ? 1 : pageNumber;
                    var pageSize = $("#tt2").datagrid('getPager').data("pagination").options.pageSize;
                    var _filterRules = [];
                    _filterRules.push({"field": "pid", "op": "equals", "value": row.pid});
                    if($("#tbEquipmentCode").val())
                        _filterRules.push({"field": "equipment_code", "op": "contains", "value": $("#tbEquipmentCode").val()});
                    if($("#tbHandUesr").val())
                        _filterRules.push({"field": "hand_uesr", "op": "contains", "value": $("#tbHandUesr").val()});
                    var filterRuleStr = "";
                    if (_filterRules.length > 0)
                        filterRuleStr = JSON.stringify(_filterRules);
                    var _sort = $("#tt2").datagrid('options').sortName;
                    var _order = $("#tt2").datagrid('options').sortOrder;
                    if (_sort == null || _sort == "")
                        _order = "desc";
                    $.ajax({
                        type: 'get',
                        url: 'allExams',
                        data: {page: pageNumber, rows: pageSize, filterRules: filterRuleStr, sort: _sort, order: _order},
                        dataType: "json",
                        success: function (r) {
                            if (r.result) {
                                $("#tt2").datagrid("loadData", r);
                            } else
                                $.messager.alert("提示", r.info, "info");
                        },
                        error: function () {
                            $.messager.alert("提示", "调用后台接口出错！", "error");
                        }
                    });
                }
            }
            function addCard2() {
                var row = $("#tt").datagrid("getSelected");
                var con = '<iframe src="editexam?pid='+row.pid+'" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                $("#card-window").html(con);
                $("#card-window").window({title: '新增特种人员考试合格信息', width: '500px', height: '333px'})
                $("#card-window").window("open");
            }
            function editCard2() {
                var row = $("#tt2").datagrid("getSelected");
                if (row) {
                    var con = '<iframe src="editexam?id=' + row.id + '" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                    $("#card-window").html(con);
                    $("#card-window").window({title: '编辑特种作业人员考试合格信息[ ' + row.equipment_code + ' ]', width: '500px', height: '333px'})
                    $("#card-window").window("open");
                } else
                    $.messager.alert("提示", "请选择要编辑的数据！", "warning");
            }
            function delCard2() {
                var row = $("#tt2").datagrid("getSelected");
                if (row) {
                    $.messager.confirm("提示", "确定要删除特种作业人员考试合格信息[ " + row.equipment_code + " ]？", function (r) {
                        if (r)
                        {
                            $.ajax({
                                type: 'delete',
                                url: 'exam/' + row.id,
                                data: {},
                                dataType: "json",
                                success: function (r) {
                                    $.messager.alert("提示", r.info, "info");
                                    if (r.result) {
                                        bindData2();
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
            function formatValidDate(value,row,index){
                return "<div style='border-bottom:1px solid #CCCCCC'>"+row.valid_begin_date+"</div><div>"+row.valid_end_date+"</div>";
            }
            function formatEquipment(value,row,index){
                return value+"("+row.equipment_name+")";
            }
            function datagridSelectRow(index, row){
                if(_usercompanyid==row.companyid){
                    $("#btnAdd2").linkbutton("enable");
                    $("#btnEdit").linkbutton("enable");
                    $("#btnEdit2").linkbutton("enable");
                    $("#btnDele").linkbutton("enable");
                    $("#btnDele2").linkbutton("enable");
                }
                else{
                    $("#btnAdd2").linkbutton("disable");
                    $("#btnEdit").linkbutton("disable");
                    $("#btnEdit2").linkbutton("disable");
                    $("#btnDele").linkbutton("disable");
                    $("#btnDele2").linkbutton("disable");
                }
                bindData2();
            }
            function bindUnit(){
                $.ajax({
                    type: 'get',
                    url: '../specialjob/getAllUnit',
                    data: {},
                    async: false,
                    dataType: "json",
                    success: function (r) {
                        if(r.result){
                            r.rows.unshift({"id": "-1", "name": "--所有--"});
                            $("#cbUnit").combobox("loadData", r.rows);
                            if(_iszjcuser){
                                $("#cbUnit").combobox("select", r.rows[0].id);
                            }else{
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
        </script>
    </head>
    <body>
        
        <div class="easyui-layout" data-options="fit:true">
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

        <div id='cc' class="easyui-layout" data-options="fit:true">
            <div data-options="region:'west',split:true" title="特种作业人员列表" style="width:800px">
                <table id="tt" class="easyui-datagrid" data-options="
                       rownumbers:true,
                       fit:true,
                       singleSelect:true,
                       pagination:true,
                       pageSize:20,
                       idField:'pid',
                       onSortColumn:bindData,
                       onSelect:datagridSelectRow,
                       toolbar:'#menuTollbar'">
                    <thead>
                        <tr>
                            <!--<th data-options="field:'ck',checkbox:true"></th>-->
                            <th data-options="field:'dwname',width:100,align:'center',halign:'center',sortable:'true'">单位</th>
                            <th data-options="field:'bmname',width:150,align:'center',halign:'center',sortable:'true'">部门</th>
                            <th data-options="field:'name',width:100,align:'center',halign:'center',sortable:'true'">姓名</th>
                            <th data-options="field:'card_no',width:120,align:'center',halign:'center',sortable:'true'">证件编号</th>
                            <th data-options="field:'archives_no',width:120,align:'center',halign:'center',sortable:'true'">档案编号</th>
                            <th data-options="field:'award_unit',width:160,align:'center',halign:'center',sortable:'true'">发证机关</th>
                        </tr>
                    </thead>
                </table>
                <div id="menuTollbar" style="height: auto;">
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-reload'" onclick="bindData();">刷新</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-add'" id="btnAdd" onclick="addCard();">添加</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-edit'" id="btnEdit" onclick="editCard();">编辑</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-del'" id="btnDele" onclick="delCard();">删除</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-add'" id="btnBatchAdd" onclick="batchAddCard();">批量导入</a>
                    <div style="padding:2px;border-top:1px solid #D4D4D4;">
                        <span>姓名：</span>
                        <input class="easyui-textbox" style="width:100px" id="tbName">
                        <span style="padding-left:10px;">编号：</span>
                        <input class="easyui-textbox" style="width:200px" data-options="prompt:'身份证编号/证件编号/档案编号'" id="tbNo">
                        <span style="padding-left:10px;">发证机关：</span>
                        <input class="easyui-textbox" style="width:200px" id="tbAwardUnit">
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-s-search'" onclick="searchClick()">查询</a>
                    </div>
                </div>
            </div>
            <div data-options="region:'center'" title="特种作业人员考试合格项目列表">
                <table id="tt2" class="easyui-datagrid" data-options="
                       rownumbers:true,
                       fit:true,
                       singleSelect:true,
                       pagination:true,
                       pageSize:20,
                       idField:'id',
                       onSortColumn:bindData2,
                       toolbar:'#menuTollbar2'">
                    <thead>
                        <tr>
                            <th rowspan="2" data-options="field:'equipment_code',width:200,align:'left',halign:'center',sortable:'true',formatter:formatEquipment">作业项目代号</th>
                            <th>批准日期</th>
                            <th rowspan="2" data-options="field:'hand_uesr',width:120,align:'center',halign:'center',sortable:'true'">经办人</th>
                        </tr>
                        <tr>
                            <th data-options="field:'valid_date',width:120,align:'center',halign:'center',formatter:formatValidDate">有效日期</th>
                        </tr>
                    </thead>
                </table>
                <div id="menuTollbar2" style="height: auto;">
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-reload'" onclick="bindData2();">刷新</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-add'" id="btnAdd2" onclick="addCard2();">添加</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-edit'" id="btnEdit2" onclick="editCard2();">编辑</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-del'" id="btnDele2" onclick="delCard2();">删除</a>
                    <div style="padding:2px;border-top:1px solid #D4D4D4;">
                        <span>作业项目代号：</span>
                        <input class="easyui-textbox" style="width:100px" id="tbEquipmentCode">
                        <span style="padding-left:10px;">经办人：</span>
                        <input class="easyui-textbox" style="width:100px" id="tbHandUesr">
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-s-search'" onclick="searchClick2()">查询</a>
                    </div>
                </div>
            </div>
        </div>
        
            </div>
        </div>
        <div id="card-window" class="easyui-window" title="" data-options="modal:true,closed:true,iconCls:'icon-save',minimizable:false,collapsible:false" style="width:640px;height:380px;overflow:hidden;">

        </div>

        
        <div id="import-dialog" class="easyui-dialog" title="选择导入的excel文件" data-options="closed:true,iconCls:'icon-save',buttons: '#import-dlg-buttons'" style="width:420px;height:260px;padding:10px;">
            
        <table class="datatable">
            <tr>
                <td class="leftTd">文件选择：</td>
                <td class="rightTd">
                    <input id="upload" />
                </td>
            </tr>
            <tr class="editElem">
                <td class="leftTd">当前选择文件：</td>
                <td class="rightTd">
                    <div id="filelist"></div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">导入模板下载：</td>
                <td class="rightTd">
                    <a href="../s/file/特种设备作业人员证导入模板.xlsx">点击下载</a>
                </td>
            </tr>
        </table>
        </div>
        <div id="import-dlg-buttons">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveImportClick();">确认</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-no'" onclick="$('#import-dialog').dialog('close');">关闭</a>
        </div>
    </body>
</html>
