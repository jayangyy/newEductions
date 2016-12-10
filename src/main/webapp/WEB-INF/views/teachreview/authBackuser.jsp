<%-- 
    Document   : authBackuser
    Created on : 2016-9-2, 17:36:28
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <form id="authbackForm" style="text-align:left;">
        <table class="doc-table">
            <tr>
                <th>
                    <span>操作人：</span>
                </th>
                <td>
                    <input type="text" data-bind="value:plan_name" name="reviewer" id="reviewer" value="${user.workername}" style="width:370px;height:70%" class="easyui-textbox" data-options="iconAlign:'left',required:true,editable:false" />              
                </td>
            </tr>
            <tr>
                <th>
                    <span>说明：</span>
                </th>
                <td>
                    <span data-bind="text:">返${to_user}</span> 
                        <input id="review_status"  name="review_status" type="hidden" value="${passedEnum}" style="width:370px;" />
                </td>
            </tr>
            <tr>
                <th>
                    <span>回返意见：</span>
                </th>
                <td colspan="4">
                    <input type="text"  style="height:70%;width:450px;overflow: auto;" name="review_cmt" id="review_cmt" value="" class="easyui-textbox" data-options="iconAlign:'left',required:false" />
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
        <input type="hidden" id="transfer_to_user" name="transfer_to_user" value="${to_user}"/>
        <input type="hidden" id="transfer_to_idcard" name="transfer_to_idcard" value="${to_uid}"/>
        <input type="hidden" id="transfer_to_unit" name="transfer_to_unit" value="${to_unit}"/>
        <input type="hidden" id="transfer_to_uid" name="transfer_to_uid" value="${to_unitid}"/>
        <input type="hidden" id="transfer_from_user" name="transfer_from_user" value="${user.workername}"/>
        <input type="hidden" id="transfer_from_idcard" name="transfer_from_idcard" value="${user.username}"/>
         <input type="hidden" id="cost_id" name="cost_id" value="${costid}"/>
    </form>
    <script type="text/javascript">
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
</body>
