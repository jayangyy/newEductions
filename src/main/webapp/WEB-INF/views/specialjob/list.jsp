<%-- 
    Document   : list
    Created on : 2016-7-20, 15:23:06
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
        <title>特种作业证</title>
        <%@include file="/WEB-INF/views/jspf/commonjs.jspf"%>
        <script type="text/javascript">
            var _iseduuser = false;
            var _usercompanyid = "";
            var _iszjcuser = false;
            var _statusData = [{"code": "", "name": "--所有--"}, {"code": "2", "name": "有效"}, {"code": "1", "name": "需复审"}, {"code": "0", "name": "过期"}];
            $(document).ready(function () {
                anticsrf();
                _iseduuser = ${iseduuser};
                _usercompanyid = "${usercompanyid}";
                _iszjcuser = ${iszjcuser};
                $("#btnAdd").linkbutton("disable");
                $("#btnBatchAdd").linkbutton("disable");
                $("#btnEdit").linkbutton("disable");
                $("#btnDele").linkbutton("disable");
                $("#btnReview").linkbutton("disable");
                if (_iseduuser || _iszjcuser) {
                    $("#btnAdd").linkbutton("enable");
                    $("#btnBatchAdd").linkbutton("enable");
                }
                bindUnit();
                var token = $("meta[name='_csrf']").attr("content");
                var header = $("meta[name='_csrf_header']").attr("content");
                $('#upload').uploadify({
                    swf: '../s/js/uploadify/uploadify.swf',
                    uploader: 'importexcel?_csrf=' + token + '&_csrf_header=' + header,
                    queueID: 'filelist',
                    buttonText: '选择文件',
                    auto: false,
                    multi: false,
                    fileTypeExts: '*.xls; *.xlsx',
                    onUploadSuccess: function (file, data, response) {
//                        if (queueData.uploadsErrored > 0) {
//                            $.messager.alert("提示", "文件上传失败！！", "alert");
//                        }else{
//                            bindData();
//                            $.messager.alert("提示", "导入数据成功！！", "alert");
//                            $("#import-dialog").dialog("close");
//                        }
                        var r = eval("[" + data + "]")[0];
                        $.messager.alert("提示", r.info, "info");
                        $(".messager-icon").hide();
                        if (r.result) {
                            bindData();
                            $("#import-dialog").dialog("close");
                        }
                    }
                });
                var d1 = myformatter(new Date());
                $('#dtReviewDate').datebox('setValue', d1);
                $("#cbStatus").combobox("loadData", _statusData);
                bindZylb();
                bindData();
                $("#tt").datagrid('getPager').pagination({
                    onSelectPage: function () {
                        bindData();
                    }
                });
            });
            function myformatter(date) {
                var y = date.getFullYear();
                var m = date.getMonth() + 1;
                var d = date.getDate();
                var str = y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
                return str;
            }
            function bindData() {
                var pageNumber = $("#tt").datagrid('getPager').data("pagination").options.pageNumber;
                pageNumber = pageNumber === 0 ? 1 : pageNumber;
                var pageSize = $("#tt").datagrid('getPager').data("pagination").options.pageSize;
                var _zylb = $("#cbZylb").combobox("getValue");
                var _zcxm = $("#cbZcxm").combobox("getValue");
                var _status = $("#cbStatus").combobox("getValue");
                var _reviewbegindate = $("#dtReviewBeginDate").datebox('getValue');
                var _reviewenddate = $("#dtReviewEndDate").datebox('getValue');
                var _dwid = $("#cbUnit").combobox("getValue");
                var _bmid="";
                var node = $("#cbDepartment").tree("getSelected");
                _bmid=node.id;
                var _filterRules = [];
                if (_dwid != "" && _dwid != "-1")
                    _filterRules.push({"field": "dwid", "op": "equals", "value": _dwid});
                if (_bmid != "" && _bmid != "-1")
                    _filterRules.push({"field": "bmid", "op": "equals", "value": _bmid});
                if ($("#tbCardNo").val() != "")
                    _filterRules.push({"field": "card_no", "op": "contains", "value": $("#tbCardNo").val()});
                if ($("#tbName").val() != "")
                    _filterRules.push({"field": "name", "op": "contains", "value": $("#tbName").val()});
                if (_zylb != "" && _zylb != "-1")
                    _filterRules.push({"field": "lbcode", "op": "equals", "value": _zylb});
                if (_zcxm != "" && _zcxm != "-1")
                    _filterRules.push({"field": "xmcode", "op": "equals", "value": _zcxm});
                if (_status != "")
                    _filterRules.push({"field": "status", "op": "equals", "value": _status});
                if (_reviewbegindate != "" || _reviewenddate != "") {
                    _filterRules.push({"field": "reviewdate", "op": "custom", "value": _reviewbegindate + "@" + _reviewenddate});
                }
                var filterRuleStr = "";
                if (_filterRules.length > 0)
                    filterRuleStr = JSON.stringify(_filterRules);
                var _sort = $("#tt").datagrid('options').sortName;
                var _order = $("#tt").datagrid('options').sortOrder;
                if (_sort == null || _sort == "")
                    _order = "asc";
                $.ajax({
                    type: 'get',
                    url: 'allCards',
                    data: {page: pageNumber, rows: pageSize, filterRules: filterRuleStr, sort: _sort, order: _order},
                    dataType: "json",
                    success: function (r) {
                        if (r.result) {
                            $("#tt").datagrid("loadData", r);
                            if (r.rows && r.rows.length > 0)
                                $("#tt").datagrid("selectRow", 0);
                        } else
                            $.messager.alert("提示", r.info, "info");
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "error");
                    }
                });
            }
            function bindUnit() {
                $.ajax({
                    type: 'get',
                    url: 'getAllUnit',
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
                    url: 'getDepartmentTree',
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
            function formatValidDate(value, row, index) {
                return row.valid_begin_date + " 至 " + row.valid_end_date;
            }
            function formatReviewDate(value, row, index) {
                if (value)
                    return value;//.replace("-"+value.split("-")[2],"");
                else
                    return "";
            }
            function reviewDateStyler(value, row, index) {
                if (row.status == 1)
                    return 'background-color:yellow;color:black;';//需要复审（在复审期内）
                else if (row.status == 0)
                    return 'background-color:red;color:black;';//已经过期（超时未审核/超过有效期）
                else
                    return 'background-color:#fff;color:black;';//有效证件，不需复审
            }
            function addCard() {
                var con = '<iframe src="edit" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                $("#card-window").html(con);
                $("#card-window").window({title: '新增特种作业证'})
                $("#card-window").window("open");
            }
            function editCard() {
                var rows = $("#tt").datagrid("getSelections");
                if (rows.length > 0) {
                    var row = rows[rows.length - 1];
                    var con = '<iframe src="edit?cardno=' + row.card_no + '" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                    $("#card-window").html(con);
                    $("#card-window").window({title: '编辑特种作业证[ ' + row.card_no + ' ]'})
                    $("#card-window").window("open");
                } else
                    $.messager.alert("提示", "请选择要编辑的数据！", "warning");
            }
            function delCard() {
                var rows = $("#tt").datagrid("getSelections");
                if (rows.length > 0) {
                    var row = rows[rows.length - 1];
                    $.messager.confirm("提示", "确定要删除特种作业证[ " + row.card_no + " ]？", function (r) {
                        if (r)
                        {
                            $.ajax({
                                type: 'delete',
                                url: 'card/' + row.card_no,
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
            function bindZylb() {
                bindSpecialJobType($("#cbZylb"), "0");
            }
            function bindZcxm() {
                var zylb = $("#cbZylb").combobox("getValue");
                bindSpecialJobType($("#cbZcxm"), zylb);
            }
            function bindSpecialJobType(obj, fcode) {
                $(obj).combobox("loadData", []);
                $.ajax({
                    type: 'get',
                    url: 'sjtype',
                    data: {fcode: fcode},
                    dataType: "json",
                    success: function (r) {
                        if (r.result) {
                            r.rows.unshift({"code": "-1", "name": "--所有--"});
                            $(obj).combobox("loadData", r.rows);
                            $(obj).combobox("select", r.rows[0].code);
                        } else
                            $.messager.alert("提示", r.info, "info");
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "error");
                    }
                });
            }
            function batchAddCard() {
                $("#import-dialog").dialog("open");
            }
            function saveImportClick() {
                $('#upload').uploadify("upload", "*");
            }
            function reviewCard() {
                var rows = $("#tt").datagrid("getSelections");
                if (rows.length > 0) {
                    $('#review-dialog').dialog({title: "复审时间选择（ 所选证书个数： " + rows.length + " ）"});
                    $('#review-dialog').dialog('open');
                } else
                    $.messager.alert("提示", "请选择要复审的数据！", "warning");
            }
            function saveReviewCard() {
                var rows = $("#tt").datagrid("getSelections");
                if (rows.length <= 0) {
                    $.messager.alert("提示", '请选择要复审的数据！', "info");
                    return;
                }
                var _cardnos = "";
                var _temp = "";
                for (var i = 0; i < rows.length; i++) {
                    var card_no = rows[i].card_no;
                    if (rows[i].status == 0 || rows[i].status == 1)
                        _cardnos += card_no + ',';
                    else
                        _temp += card_no + ',';
                }
                if (_temp != "")
                    _temp = _temp.substring(0, _temp.length - 1);
                //更新复查时间和有效日期，同时记录复查日志
                if (_cardnos != "") {
                    _cardnos = _cardnos.substring(0, _cardnos.length - 1);
                    var _reviewdate = $("#dtReviewDate").datebox('getValue');
                    $.ajax({
                        type: 'post',
                        url: 'reviewcard',
                        data: {cardnos: _cardnos, reviewdate: _reviewdate},
                        dataType: "json",
                        success: function (r) {
                            if (r.result) {
                                if (_temp != "") {
                                    $.messager.alert("提示", r.info + "其中所选卡号[" + _temp + "]不需要复审，已跳过！", "info");
                                } else {
                                    $.messager.alert("提示", r.info, "info");
                                }
                                bindData();
                                $('#review-dialog').dialog('close');
                            } else
                                $.messager.alert("提示", r.info, "info");
                        },
                        error: function () {
                            $.messager.alert("提示", "调用后台接口出错！", "error");
                        }
                    });
                } else {
                    $.messager.alert("提示", "所选卡号[" + _temp + "]不需要复审！", "info");
                    $('#review-dialog').dialog('close');
                }
            }
            function datagridRowClick(index, row) {
                $("#tt").datagrid("unselectAll");
                $("#tt").datagrid("selectRow", index);
                showHideBotton(row);
            }
            function datagridRowCheck(index, row) {
                showHideBotton(row);
            }
            function showHideBotton(row) {
                if (_usercompanyid == row.companyid) {
                    $("#btnEdit").linkbutton("enable");
                    $("#btnDele").linkbutton("enable");
                    $("#btnReview").linkbutton("enable");
                } else {
                    $("#btnEdit").linkbutton("disable");
                    $("#btnDele").linkbutton("disable");
                    $("#btnReview").linkbutton("disable");
                }
            }
            function searchClick() {
                $("#tt").datagrid("unselectAll");
                bindData();
            }
            function datagridSort() {
                $("#tt").datagrid("unselectAll");
                bindData();
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
                <table id="tt" title="特种作业证书列表" class="easyui-datagrid" data-options="
                       rownumbers:true,
                       fit:true,
                       singleSelect:false,
                       pagination:true,
                       pageSize:20,
                       idField:'card_no',
                       onSortColumn:datagridSort,
                       onClickRow:datagridRowClick,
                       onCheck:datagridRowCheck,
                       toolbar:'#menuTollbar'">
                    <thead>
                        <tr>
                            <th data-options="field:'ck',checkbox:true"></th>
                            <th data-options="field:'dwname',width:100,align:'center',halign:'center',sortable:'true'">单位</th>
                            <th data-options="field:'bmname',width:150,align:'center',halign:'center',sortable:'true'">部门</th>
                            <th data-options="field:'card_no',width:120,align:'center',halign:'center',sortable:'true'">卡号</th>
                            <th data-options="field:'cert_no',width:140,align:'center',halign:'center',sortable:'true'">证号</th>
                            <th data-options="field:'name',width:80,align:'center',halign:'center',sortable:'true'">姓名</th>
                            <th data-options="field:'sex',width:50,align:'center',halign:'center',sortable:'true'">性别</th>
                            <th data-options="field:'zylb',width:100,align:'center',halign:'center',sortable:'true'">作业类别</th>
                            <th data-options="field:'zcxm',width:150,align:'center',halign:'center',sortable:'true'">准操项目</th>
                            <th data-options="field:'firstdate',width:100,align:'center',halign:'center',sortable:'true'">初领日期</th>
                            <th data-options="field:'validDate',width:160,align:'center',halign:'center',formatter:formatValidDate">有效日期</th>
                            <th data-options="field:'reviewdate',width:100,align:'center',halign:'center',sortable:'true',formatter:formatReviewDate,styler:reviewDateStyler">复审日期</th>
                        </tr>
                    </thead>
                </table>
                <div id="menuTollbar" style="height: auto;">
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-reload'" onclick="bindData();">刷新</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-add'" id="btnAdd" onclick="addCard();">添加</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-edit'" id="btnEdit" onclick="editCard();">编辑</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-del'" id="btnDele" onclick="delCard();">删除</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-add'" id="btnBatchAdd" onclick="batchAddCard();">批量导入</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-man'" id="btnReview" onclick="reviewCard();">复审</a>
                    <div style="padding:2px;border-top:1px solid #D4D4D4;">
                        <span>卡号：</span>
                        <input class="easyui-textbox" style="width:120px" id="tbCardNo">
                        <span>姓名：</span>
                        <input class="easyui-textbox" style="width:80px" id="tbName">
                        <span style="padding-left:10px;">作业类别：</span>
                        <input class="easyui-combobox" data-options="valueField:'code',textField:'name',onChange:bindZcxm" style="width:150px;" id="cbZylb">
                        <span style="padding-left:10px;">准操项目：</span>
                        <input class="easyui-combobox" data-options="valueField:'code',textField:'name'" style="width:200px;" id="cbZcxm">
                        <span style="padding-left:10px;">状态：</span>
                        <input class="easyui-combobox" data-options="valueField:'code',textField:'name'" style="width:100px;" id="cbStatus">
                        <span style="padding-left:10px;">复审日期：</span>
                        <input class="easyui-datebox" id="dtReviewBeginDate" style="width:100px;">
                        至
                        <input class="easyui-datebox" id="dtReviewEndDate" style="width:100px;">
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-s-search'" onclick="searchClick()">查询</a>
                    </div>
                </div>
            </div>
        </div>

        <div id="card-window" class="easyui-window" title="" data-options="modal:true,closed:true,iconCls:'icon-save',minimizable:false,collapsible:false" style="width:640px;height:440px;overflow:hidden;">

        </div>

        <div id="review-dialog" class="easyui-dialog" title="复审时间选择" data-options="closed:true,iconCls:'icon-save',buttons: '#review-dlg-buttons'" style="width:260px;height:120px;padding:10px;text-align:center;">
            <input class="easyui-datebox" id="dtReviewDate" data-options="formatter:myformatter">
        </div>
        <div id="review-dlg-buttons">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveReviewCard()">确认</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-no'" onclick="$('#review-dialog').dialog('close');">关闭</a>
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
                        <a href="../s/file/特种作业证导入模板.xlsx">点击下载</a>
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
