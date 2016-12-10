<%-- 
    Document   : authPasseds
    Created on : 2016-11-21, 10:46:30
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--批量审核-->
<style type="text/css">
    .doc-table {
        border-collapse: collapse;
        border-spacing: 0;  
        width: 100%;
        margin-bottom: 1.65em;
    }

    
    
    .doc-table th, .doc-table td {
        border: 0px solid #8CACBB;
        padding: 0.1em 0.1em;
        height: 40px;
        text-align: left;
    }

    .doc-table th {
        background: #eee;
    }

    .doc-table pre {
        font-family: Verdana;
        font-size: 12px;
        color: #006600;
        background: #fafafa;
        padding: 5px;
        margin: 12px 0;
        line-height: 120%;
    }

    .doc-table p {
        margin: 14px 0;
        line-height: 100%;
    }

    .doc-table input[type=text] {
        width: 300px;
        height: 100%;
    }

    .textcom {
        height: 100%;
    }
</style>
<body>
    <form id="authPassedForm" style="text-align:left;">
        <table class="doc-table">
            <tr>
                <th>
                    <span>审核人：</span>
                </th>
                <td>
                    <input type="text" data-bind="value:plan_name" name="reviewer" id="reviewer" value="${user.workername}" style="width:100%;height:70%" class="easyui-textbox" data-options="iconAlign:'left',required:true,editable:false" />              
                </td>
            </tr>
            <tr>
                <th>
                    <span>审核选项：</span>
                </th>
                <td>
                    <span>审核通过</span> 
                    <input id="review_status"  name="review_status" type="hidden" value="${passedEnum}" style="width:370px;" />
                </td>
            </tr>
            <tr>
                <th>
                    <span>审核意见：</span>
                </th>
                <td colspan="4">
                    <input type="text"  style="height:70%;width:450px;overflow: auto;" name="review_cmt" id="review_cmt" value="" class="easyui-textbox" data-options="iconAlign:'left',required:false" />
                </td>
            </tr>
            <tr style="display:none">
                <th>附件上传</th>
                <td colspan="3">
                    <input type="file" name="upload" id="upload" />
                    <span id="uploadurl"></span>   
                </td>
            </tr>
        </table>
        <input type="hidden" name="review_dcode" id="review_dcode"/>
        <input type="hidden" id="plan_code" name="plan_code"/>
        <input type="hidden" id="plan_status_cmt" name="plan_status_cmt" value="${passedEnumcmt}"/>
        <input type="hidden" id="review_url" name="review_url" value=""/>
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
    </script>
    <!--//所有移送计划-->
    <table id="plans_passed_grid" class="easyui-datagrid" 
           data-options="url:'getPlansPage?isAuth=1&if_union=2',method:'get',fitColumns:false,fit:true,idField:'plan_code',checkbox:true,pagination:true,pageNumber:1,pageSize:20,sortOrder:'DESC',sortName:'plan_sdate',singleSelect:false">
        <thead data-options="frozen:true">
            <tr>
                <th data-options="field:'ck',checkbox:true"></th>
                <th data-options="field:'plan_status_cmt',width:200,align:'center'">审核状态</th>
            </tr>
        </thead>
        <thead>
            <tr>
                <th data-options="field:'transfer_code',width:100,align:'center',hidden:true">移送代码</th>
                <th data-options="field:'cost_id',width:100,align:'center',hidden:true">移送代码</th>
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
</body>

