<%-- 
    Document   : scsoonedit
    Created on : 2016-10-26, 11:38:51
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
        <script type="text/javascript" src="../s/js/Generation_Guid.js"></script>
        <style>
            table.datatable td {
                padding: 0px;
            }
            .input{border:none;}
        </style>
        <script>
            var _id;
            var _name;
            $(function(){
                anticsrf();
                _id = GetQueryString("id");
                _name = GetQueryString("name");
                var _dwid = GetQueryString("dwid");
                var _newpost = GetQueryString("newpost");
                bindCanCopyNewPost(_dwid,_newpost);
            });
            function bindCanCopyNewPost(_dwid,_newpost) {
                var pageNumber = 1;
                var pageSize = 10;
                var _sort = "";
                var _order = "";
                
                var _filterRules = [];
                _filterRules.push({"field": "iszjcuser", "op": "custom", "value": ""});
                _filterRules.push({"field": "dwid", "op": "equals", "value": _dwid});
                _filterRules.push({"field": "new_post", "op": "equals", "value": _newpost});
                _filterRules.push({"field": "id", "op": "noequals", "value": _id});
                
                var filterRuleStr = "";
                if (_filterRules.length > 0)
                    filterRuleStr = JSON.stringify(_filterRules);
                m.ajax('get','allDatas',{page: pageNumber, rows: pageSize, filterRules: filterRuleStr, sort: _sort, order: _order},function(r){
                    if (r.result) {
                        $("#edunewpostusers").combobox("loadData", r.rows);
                        if(r.rows.length>0)
                            $("#edunewpostusers").combobox("select", r.rows[0].id);
                    } else
                        $.messager.alert("提示", r.info, "info");
                });
            }
            function bindData(){
                var newpostid = $("#edunewpostusers").combobox("getValue");
                var pageNumber = $("#tt2").datagrid('getPager').data("pagination").options.pageNumber;
                pageNumber = pageNumber === 0 ? 1 : pageNumber;
                var pageSize = $("#tt2").datagrid('getPager').data("pagination").options.pageSize;
                var _filterRules = [];
                _filterRules.push({"field": "newpostid", "op": "equals", "value": newpostid});
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
            function saveDataClick(){
                var _fromid = $("#edunewpostusers").combobox("getValue");
                var uname = $("#edunewpostusers").combobox("getText");
                $.messager.confirm("提示", "确定要复制[ " + uname + " ]的学习内容到[ "+_name+" ]？", function (r) {
                    if (r)
                    {
                        m.ajax('post','copyStudyContent',{fromid:_fromid,toid:_id},function(r){
                            if (r.result) {
                                parent.bindData2();
                                parent.$('#edit-window').window('close');
                            } else
                                $.messager.alert("提示", r.info, "info");
                        });
                    }
                });
            }
        </script>
    </head>
    <body>
        <table class="datatable" style="position:fixed;top:0px;left:0px;z-index:99999;background-color:#fff;">
            <tr>
                <td class="rightTd" colspan="2" style="text-align:left;">
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveDataClick()">确定</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-no'" onclick="parent.$('#edit-window').window('close')">关闭</a>
                </td>
            </tr>
        </table>
        <table class="datatable" style="margin-top:27px">
            <tr>
                <td class="leftTd">职工选择：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-combobox" style='width:100%;' data-options="valueField:'id',textField:'username',editable:false,onChange:bindData" id="edunewpostusers">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">学习内容预览：</td>
                <td class="rightTd" style="height:327px;">
                    <table id="tt2" class="easyui-datagrid" data-options="
                            rownumbers:true,
                            fit:true,
                            singleSelect:true,
                            pagination:true,
                            pageSize:20,
                            idField:'id'">
                        <thead>
                            <tr>
                                <th data-options="field:'orderno',align:'center'">排序号</th>
                                <th data-options="field:'study_type',align:'center'">学习类别</th>
                                <th data-options="field:'study_content',align:'center'">学习内容</th>
                                <th data-options="field:'teacher',align:'center'">主讲人</th>
                                <th data-options="field:'study_hours',align:'center'">学时</th>
                                <th data-options="field:'memo',align:'center'">成绩或备注</th>
                            </tr>
                        </thead>
                    </table>
                </td>
            </tr>
        </table>
    </body>
</html>
