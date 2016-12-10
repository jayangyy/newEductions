<%-- 
    Document   : viewSesssion
    Created on : 2016-9-6, 17:50:19
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Session Viewer</title>
        <%@include file="/WEB-INF/views/jspf/commonjs.jspf"%>
    </head>
    <body>
        <table id="review_grid" class="easyui-datagrid" 
               data-options="url:'./getSessions',striped:true,nowrap:false,method:'get',fitColumns:true,fit:true,idField:'name',checkbox:true,sortOrder:'DESC',sortName:'name',singleSelect:true,autoRowHeight:true">
            <thead>
                <tr>
                    <th data-options="field:'name',width:150,align:'center',resizable:true,fixed:true">用户</th>
                    <th data-options="field:'value',width:150,align:'center'">单位</th>
                    <th data-options="field:'sessionCount',width:100,align:'center'">用户相关SESSION个数</th>
                      <th data-options="field:'lastquest',width:450,align:'center'">用户最后活动时间</th>
                    
                    <th data-options="field:'totalCount',width:50,align:'center'">用户总数</th>
                </tr>
            </thead>
        </table>
        <table id="review_grid" class="easyui-datagrid" 
               data-options="url:'./getSessions',striped:true,nowrap:false,method:'get',fitColumns:true,fit:true,idField:'name',checkbox:true,sortOrder:'DESC',sortName:'name',singleSelect:true,autoRowHeight:true">
            <thead>
                <tr>
                    <th data-options="field:'name',width:500,align:'center',resizable:true,fixed:true">SESSION_NAME</th>
                    <th data-options="field:'value',width:500,align:'center'">SESSION_VALUE</th>
                </tr>
            </thead>
        </table>
    </body>
</html>
