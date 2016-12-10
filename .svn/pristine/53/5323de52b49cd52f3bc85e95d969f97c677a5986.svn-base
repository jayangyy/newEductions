<%-- 
    Document   : list
    Created on : 2016-10-12, 15:59:59
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
            var _isadmin = false;
            var _iszjcuser = false;
            $(function () {
                anticsrf();
                _isadmin = ${isadmin};
                _iszjcuser = ${iszjcuser};
                if(!_isadmin){
                    $("#btnAdd").linkbutton("disable");
                    $("#btnEdit").linkbutton("disable");
                    $("#btnDele").linkbutton("disable");
                }
                if(_iszjcuser)
                    $("#btnEdit").linkbutton("enable");
                    
                bindFisrtType();
                $("#tt").datagrid('getPager').pagination({
                    onSelectPage: function () {
                        bindData();
                    }
                });
            });
            function bindFisrtType(){
                $.ajax({
                    type: 'get',
                    url: 'getDataByParentId',
                    data: {parentid:0},
                    dataType: "json",
                    success: function (r) {
                        if(r.result && r.rows.length>0){
                            $("#cbFirstType").combobox("loadData", r.rows);
                            $("#cbFirstType").combobox("select", r.rows[0].id);
                        }else{
                            $.messager.alert("提示", r.info, "error");
                        }
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "error");
                    }
                });
            }
            function bindData(){
                var index = layer.msg('加载列表数据中，请稍后...',{icon:16,time:10000,shade:[0.5,'#EAEAEA'],maxWidth:230});
                var pageNumber = $("#tt").datagrid('getPager').data("pagination").options.pageNumber;
                pageNumber = pageNumber === 0 ? 1 : pageNumber;
                var pageSize = $("#tt").datagrid('getPager').data("pagination").options.pageSize;
                var parentType = $("#cbFirstType").combobox("getValue");
                
                var _filterRules = [];
                if (parentType !== "")
                    _filterRules.push({"field": "parentid", "op": "equals", "value": parentType});
                var filterRuleStr = "";
                if (_filterRules.length > 0)
                    filterRuleStr = JSON.stringify(_filterRules);
                var _sort = "typecode";//$("#tt").datagrid('options').sortName;
                var _order = $("#tt").datagrid('options').sortOrder;
                $.ajax({
                    type: 'get',
                    url: 'allDatas',
                    data: {page: pageNumber, rows: pageSize, filterRules: filterRuleStr, sort: _sort, order: _order},
                    dataType: "json",
                    success: function (r) {
                        if (r.result && r.rows.length>0){
                            $("#tt").datagrid("loadData", r);
                            $("#tt").datagrid("selectRow", 0);
                            mergeGridColCells($("#tt"),"type");
                        }
                        else
                            $.messager.alert("提示", r.info, "alert");
                        layer.close(index);
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "alert");
                        layer.close(index);
                    }
                });
            }
            function formatJwbz(value,row,index){
                var min_expense = row.jw_min_expense;
                var max_expense = row.jw_max_expense;
                if(min_expense!="" && max_expense=="")
                    return "≥"+min_expense;
                else if(max_expense!=""  && min_expense=="")
                    return "≤"+max_expense;
                else if(min_expense!="" && max_expense!="")
                    return min_expense + "-" + max_expense;
                else
                    return "";
            }
            function formatJnbz(value,row,index){
                var min_expense = row.jn_min_expense;
                var max_expense = row.jn_max_expense;
                if(min_expense!="" && max_expense=="")
                    return "≥"+min_expense;
                else if(max_expense!=""  && min_expense=="")
                    return "≤"+max_expense;
                else if(min_expense!="" && max_expense!="")
                    return min_expense + "-" + max_expense;
                else
                    return "";
            }
            function mergeGridColCells(grid,rowFildName)  
            {  
                var rows=grid.datagrid('getRows' );  
                var startIndex=0;  
                var endIndex=0;  
                if(rows.length< 1)  
                {  
                    return;  
                }  
                $.each(rows, function(i,row){  
                    if(row[rowFildName]==rows[startIndex][rowFildName])  
                    {  
                        endIndex=i;  
                    }  
                    else  
                    {  
                        grid.datagrid( 'mergeCells',{  
                            index: startIndex,  
                            field: rowFildName,  
                            rowspan: endIndex -startIndex+1  
                        });  
                        startIndex=i;  
                        endIndex=i;  
                    }  
                });  
                grid.datagrid( 'mergeCells',{  
                    index: startIndex,  
                    field: rowFildName,  
                    rowspan: endIndex -startIndex+1  
                });  
            }
            function delData(){
                var row = $("#tt").datagrid("getSelected");
                if (row) {
                    $.messager.confirm("提示", "确定要删除[ " + row.posttype + " ]的经费标准？", function (r) {
                        if (r)
                        {
                            $.ajax({
                                type: 'post',
                                url: 'delDataById',
                                data: {id:row.id},
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
            function addData(){
                var con = '<iframe src="edit" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                $("#edit-window").html(con);
                $("#edit-window").window({title: '新增经费标准'})
                $("#edit-window").window("open");
            }
            function editData(){
                var row = $("#tt").datagrid("getSelected");
                if (row) {
                    var con = '<iframe src="edit?id=' + row.id + '" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                    $("#edit-window").html(con);
                    $("#edit-window").window({title: '编辑经费标准[ ' + row.type + ' - ' + row.posttype + ' ]'})
                    $("#edit-window").window("open");
                } else
                    $.messager.alert("提示", "请选择要编辑的数据！", "warning");
            }
        </script>
    </head>
    <body>
        <table id="tt" title="资料信息列表" class="easyui-datagrid" data-options="
            rownumbers:true,
            fit:true,
            singleSelect:true,
            pagination:true,
            pageSize:20,
            idField:'id',
            toolbar:'#menuTollbar'">
            <thead>
                <tr>
                    <th data-options="field:'type'">项目</th>
                    <th data-options="field:'posttype'">工作事项</th>
                    <th data-options="field:'typecode'">工作事项代码</th>
                    <th data-options="field:'unit',align:'center'">计量单位</th>
                    <th data-options="field:'jwbz',align:'center',formatter:formatJwbz">局外标准</th>
                    <th data-options="field:'jnbz',align:'center',formatter:formatJnbz">局内标准</th>
                    <th data-options="field:'memo'">备注</th>
                </tr>
            </thead>
        </table>
        <div id="menuTollbar" style="height: auto;">
            <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-reload'" onclick="bindData();">刷新</a>
            <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-add'" id="btnAdd" onclick="addData();">添加</a>
            <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-edit'" id="btnEdit" onclick="editData();">编辑</a>
            <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-del'" id="btnDele" onclick="delData();">删除</a>
            <div style="padding:2px;border-top:1px solid #D4D4D4;">
                <span style="padding-left:10px;">类别筛选：</span>
                <input class="easyui-combobox" data-options="valueField:'id',textField:'type',editable:false,onChange:bindData" style="width:130px;" id="cbFirstType">
            </div>
        </div>
        
        <div id="edit-window" class="easyui-window" title="" data-options="modal:true,closed:true,iconCls:'icon-save',minimizable:false,collapsible:false" style="width:700px;height:440px;overflow:hidden;">

        </div>
    </body>
</html>
