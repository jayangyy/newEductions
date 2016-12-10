<%-- 
    Document   : selectPlans
    Created on : 2016-12-10, 16:09:46
    Author     : jayan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--获取自建立经办计划-->
<table id="select_plans_grid" class="easyui-datagrid"
       data-options="url:'getPlansPage?isAuth=2&if_union=0&reviewstatus=1',method:'get',fitColumns:false,fit:true,idField:'plan_code',checkbox:true,pagination:true,pageNumber:1,pageSize:20,sortOrder:'DESC',sortName:'plan_sdate',singleSelect:true">
    <thead data-options="frozen:true">
        <tr>
            <th data-options="field:'ck',checkbox:true"></th>
        </tr>
    </thead>
    <thead>
        <tr>

            <th data-options="field:'transfer_code',width:100,align:'center',hidden:true">移送代码</th>
            <th data-options="field:'plan_code',width:100,align:'center',hidden:true">ID</th>
            <th data-options="field:'plan_name',width:250,align:'center'">计划名称</th>
        </tr>
    </thead>
</table>