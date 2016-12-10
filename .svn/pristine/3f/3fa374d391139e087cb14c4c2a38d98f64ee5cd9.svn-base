<%-- 
    Document   : authTransfer
    Created on : 2016-9-2, 17:35:50
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<form id="authTransferForm" style="text-align:left;">
    <table class="doc-table">
        <tr>
            <th>
                <span>审核人：</span>
            </th>
            <td>
                <input type="text" data-bind="value:plan_name" name="reviewer" id="reviewer" value="${user.workername}" style="width:370px;height:70%" class="easyui-textbox" data-options="iconAlign:'left',required:true,editable:false" />              
                <input id="review_status"  name="review_status" type="hidden" value="${passedEnum}" style="width:370px;" />
            </td>
        </tr>
        <tr>
            <th>
                <span>审核意见：</span>
            </th>
            <td colspan="4">
                <input type="text"  style="height:70%;width:370px;overflow: auto;" name="review_cmt" id="review_cmt" value="" class="easyui-textbox" data-options="iconAlign:'left',required:false" />
            </td>
        </tr>
    </table>
    <input type="hidden" name="review_dcode" id="review_dcode"/>
    <input type="hidden" id="plan_code" name="plan_code"/>
    <input type="hidden" id="plan_status_cmt" name="plan_status_cmt" value="${passedEnumcmt}"/>
    <input type="hidden" id="review_url" name="review_url"/>
    <input type="hidden" id="idcard" name="idcard" value="${user.username}"/>
    <input type="hidden" id="current_unit" name="current_unit" value="${user.company}"/>
    <input type="hidden" id="current_unitid" name="current_unitid" value="${user.companyId}"/>
    <input type="hidden" id="transfer_code" name="transfer_code" value="${transfer_code}"/>
    <input type="hidden" id="cost_id" name="cost_id" value="${cost_id}"/>
</form>
<script type="text/javascript">
    $.extend($.fn.validatebox.defaults.rules, {
        canSelected: {
            validator: function (value, param) {
                return $.trim(value).indexOf("--") < 0;
            },
            message: '此节点不能选中'
        }, compareToSDate: {
            validator: function (value, param) {
                return new Date($(param[0]).datetimebox('getValue')) > new Date(value); //注意easyui 时间控制获取值的方式
            },
            message: '不能大于开始日期'
        }
    })
    var editObj = undefined;
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $(function () {
        init();
    })
    function init() {
        var id = $("#oplancode").val();
        if (id.length >= 0) {
            $("#plan_code").val(id);
            //新增
        }
    }
</script>
<table id="selectUnitUserGrid" class="easyui-datagrid" style="width:100%;height:300px;"
       data-options="url:'getEmployeePage?searchType=1',method:'get',fitColumns:true,fit:false,idField:'em_idcard',checkbox:true,toolbar:'#tb3',pagination:true,pageNumber:1,pageSize:20,sortOrder:'DESC',sortName:'dwname',singleSelect:false">
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
                   data-options="valueField:'name',textField:'name',onSelect:searchPlanUnit,url:'getOfficUnits?searchType=1&extraunit=',method:'get',editable:true,onLoadSuccess:officUnitSuccess">
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
        $("#selectUnitUserGrid").datagrid('reload', obj);
    }
</script>
