<%-- 
    Document   : thorwPlans
    Created on : 2016-11-21, 14:18:20
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--废弃计划-->
<form id="trhowsforms">
    <input type="hidden" name="review_dcode" id="review_dcode"/>
    <input type="hidden" id="plan_code" name="plan_code"/>
    <input type="hidden" id="review_status" name="review_status" value="${passedEnudm}"/>
    <input type="hidden" id="plan_status_cmt" name="plan_status_cmt" value="${passedEnumcmt}"/>
    <input type="hidden" id="review_cmt" name="review_cmt" value="${passedEnumcmt}"/>
    <input type="hidden" id="review_url" name="review_url"/>
    <input type="hidden" id="idcard" name="idcard" value="${user.username}"/>
    <input type="hidden" id="current_unit" name="current_unit" value="${user.company}"/>
    <input type="hidden" id="current_unitid" name="current_unitid" value="${user.companyId}"/>
</form>
<!--//所有自建计划-->
<table id="plan_throws_grid" class="easyui-datagrid" 
       data-options="url:'getPlansPage?isAuth=1&if_union=0',method:'get',fitColumns:false,fit:true,idField:'plan_code',checkbox:true,pagination:true,pageNumber:1,pageSize:20,sortOrder:'DESC',sortName:'plan_sdate',singleSelect:false">
    <thead data-options="frozen:true">
        <tr>
            <th data-options="field:'ck',checkbox:true"></th>
            <th data-options="field:'plan_status_cmt',width:200,align:'center'">审核状态</th>
        </tr>
    </thead>
    <thead>
        <tr>
            <th data-options="field:'transfer_code',width:100,align:'center',hidden:true">移送代码</th>
            <th data-options="field:'plan_code',width:100,align:'center',hidden:true">ID</th>
            <th data-options="field:'plan_class',width:100,align:'center'">培训类别</th>                            
            <th data-options="field:'plan_prof',width:100,align:'center'">专业系统</th>
            <th data-options="field:'plan_name',width:250,align:'center'">培训班名</th>
            <th data-options="field:'plan_num',width:70">培训人数</th>
            <th data-options="field:'plan_periods',width:70,align:'center'">培训期数</th>
            <th data-options="field:'plan_sdate',width:155,align:'center'">培训开始时间</th>
            <th data-options="field:'plan_edate',width:155,align:'center'">培训结束时间</th>
            <th data-options="field:'plan_object',width:100,align:'center'">培训对象</th>
            <th data-options="field:'plan_cmt',width:200,align:'center'">培训内容</th>
            <th data-options="field:'plan_type',width:100,align:'center'">培训方式</th>
            <th data-options="field:'plan_executeunit',width:150,align:'center'">承办单位</th>
            <th data-options="field:'plan_unit',width:150,align:'center'">主办单位</th>
            <th data-options="field:'plan_situation',width:100,align:'center'">落实情况</th>
            <th data-options="field:'plan_execunitid',width:100,align:'center',hidden:true">职称</th>
            <th data-options="field:'plan_unitid',width:100,align:'center',hidden:true">职称</th>
            <th data-options="field:'plan_profid',width:100,align:'center',hidden:true">职称</th>
        </tr>
    </thead>
</table>
