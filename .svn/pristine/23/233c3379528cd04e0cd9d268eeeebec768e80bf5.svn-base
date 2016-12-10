<%-- 
    Document   : editRoles
    Created on : 2016-8-5, 11:15:31
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form>
            <label>选择角色：</label>
            <input id="groupRoles" name="groupRoles" class="easyui-combotree" data-options="label:'选择角色:',labelPosition:'top',multiple:true" style="width:60%">
            <input type="hidden" name="groupid" id="groupid" />
        </form>
        <script type="text/javascript">
            $(function () {
                var groupid = $("#ogroupid").val();
                $("#groupid").val(groupid);
                $.getJSON('${pageContext.request.contextPath}/groups/GetGroupsRoleTree?groupid=' + groupid, function (data) {
                    $("#groupRoles").combotree({data: data});
                })
            })
        </script>
    </body>
</html>
