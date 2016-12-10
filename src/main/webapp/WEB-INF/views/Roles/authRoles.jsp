<%-- 
    Document   : authRoles
    Created on : 2016-8-4, 9:10:57
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
              <label>选择权限：</label>
            <select id="authRoles" name="authRoles" class="easyui-combotree" style="width:70%;"
                    data-options="label:'权限选择',labelPosition:'top',multiple:true,editable:false,cascadeCheck:false">
            </select>
            <input type="hidden" name="roleid" id="roleid" />
        </form>
        <script type="text/javascript">
            $(function () {
                var roleid = $("#croleid").val();
                $("#roleid").val(roleid);
                $.getJSON('${pageContext.request.contextPath}/Roles/GetResRolesTree?roleid=' + roleid, function (data) {
                    $("#authRoles").combotree({data: data});
                })
            })
        </script>
    </body>
</html>
