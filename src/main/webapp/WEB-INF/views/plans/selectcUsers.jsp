<%-- 
    Document   : selectUser
    Created on : 2016-8-31, 16:15:13
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<form id="authTransfersForm" style="text-align:left;">
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
        <input type="hidden" id="review_cmt" name="plan_status_cmt" value="${passedEnumcmt}"/>
    <input type="hidden" id="review_url" name="review_url"/>
    <input type="hidden" id="idcard" name="idcard" value="${user.username}"/>
    <input type="hidden" id="current_unit" name="current_unit" value="${user.company}"/>
    <input type="hidden" id="current_unitid" name="current_unitid" value="${user.companyId}"/>
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
<!--所有移送计划批量单位内移送-->

<table id="selectcUsersGrid" class="easyui-datagrid" style="width:100%;height:40%"
       data-options="url:'getEmployeePage?searchType=0',method:'get',fitColumns:true,fit:false,idField:'em_idcard',checkbox:true,toolbar:'#tb3',pagination:true,pageNumber:1,pageSize:20,sortOrder:'DESC',sortName:'dwname',singleSelect:false">
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
    <form id="search_cuser_form">
        <label for="plan_user_mainid">单位：</lable>
            <input id="offic_unit" class="easyui-combobox" name="offic_unit" style="width:150px;"
                   data-options="valueField:'name',textField:'name',onSelect:searchPlanUnit,url:'getOfficUnits?searchType=0&extraunit=${user.company}',method:'get',editable:false,enable:false,onLoadSuccess:officUnitSuccess">
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
        var formdata = $("#search_cuser_form").serializeArray();
        var obj = {};
        debugger;
        $.each(formdata, function (index, item) {
            obj[item.name] = item.value;
        })
        if (obj.offic_unit == '全部单位')
        {
            obj.offic_unit = '${user.company}';
        }
        $("#selectcUsersGrid").datagrid('reload', obj);
    }
</script>
<!--//所有移送计划-->
<table id="plan_cusers_grid" class="easyui-datagrid" style="width:100%;height:50%"
       data-options="url:'getPlansPage?isAuth=1&if_union=2',method:'get',fitColumns:false,fit:false,idField:'plan_code',checkbox:true,pagination:true,pageNumber:1,pageSize:20,sortOrder:'DESC',sortName:'plan_sdate',singleSelect:false">
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
