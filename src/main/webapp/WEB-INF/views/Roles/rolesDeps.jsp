<%-- 
    Document   : rolesDeps
    Created on : 2016-8-4, 9:11:24
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
            <select id="rolesDeps" name="rolesDeps" class="easyui-combotree" style="width:70%;"
                    data-options="labelPosition:'top',multiple:true,editable:false">
            </select>
            <input type="hidden" name="roleid" id="roleid" />
        </form>

        <script type="text/javascript">
            $(function () {
                var roleid = $("#croleid").val();
                $("#roleid").val(roleid);
                $.getJSON('${pageContext.request.contextPath}/Roles/GetRolesTree?roleid=' + roleid, function (data) {
                    $("#rolesDeps").combotree({data: data});
                })
            })
        </script>

    </body>
</html>
