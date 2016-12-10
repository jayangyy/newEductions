<%-- 
    Document   : selectUser
    Created on : 2016-8-31, 16:15:13
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<table id="selectUserGrid" class="easyui-datagrid" style="width:250px;height:100%"
       data-options="url:'getEmployeePage?searchType=0',method:'get',fitColumns:true,fit:true,idField:'em_idcard',checkbox:true,toolbar:'#tb3',pagination:true,pageNumber:1,pageSize:20,sortOrder:'DESC',sortName:'dwname',singleSelect:false">
    <thead>
        <tr>
            <th data-options="field:'ck',checkbox:true"></th>                           
            <th data-options="field:'dwid',width:120,align:'center',halign:'center',sortable:'true',hidden:true">单位</th>
            <th data-options="field:'dwname',width:120,align:'center',halign:'center',sortable:'true'">单位</th>
            <th data-options="field:'em_name',width:80,align:'center',halign:'center',sortable:'true'">姓名</th>
            <th data-options="field:'em_idcard',width:140,align:'center',halign:'center',sortable:'true',hidden:true">身份证号码</th>
        </tr>
    </thead>
</table>
<div id="tb3">
    <form id="search_user_form">
        <label for="plan_user_mainid">单位：</lable>
            <input id="offic_unit" class="easyui-combobox" name="offic_unit" style="width:150px;"
                   data-options="valueField:'name',textField:'name',onSelect:searchPlanUnit,url:'getOfficUnits?searchType=0&extraunit=',method:'get',editable:true,onLoadSuccess:officUnitSuccess">
            <input id="offic_username" name="offic_username"  class="easyui-textbox" style="width:100px;" />
            <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="selectUserSearch()">搜索</a>                    
    </form>           
</div>
<script type="text/javascript">

    function searchPlanUnit(record) {
        selectUserSearch();
    }
    function officUnitSuccess(record) {
        if (record)
        {
            $("#offic_unit").combobox('select', record[0].name)
        }
    }
    function selectUserSearch()
    {
        var formdata = $("#search_user_form").serializeArray();
        var obj = {};
        $.each(formdata, function (index, item) {
            obj[item.name] = item.value;
        })
        if (obj.offic_unit == '全部单位')
        {
            obj.offic_unit = '';
        }
        $("#selectUserGrid").datagrid('reload', obj);
    }
</script>
