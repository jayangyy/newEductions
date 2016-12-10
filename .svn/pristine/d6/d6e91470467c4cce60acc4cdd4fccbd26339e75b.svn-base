<%-- 
    Document   : EditRoles
    Created on : 2016-8-5, 10:57:46
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
            <input id="userRoles" name="userRoles" class="easyui-combotree" data-options="label:'选择角色:',labelPosition:'top',multiple:true,editable:false" style="width:70%">
            <input type="hidden" name="username" id="username" />
        </form>
        <script type="text/javascript">
            $(function () {
                var username = $("#ousername").val();
                $("#username").val(username);
                $.getJSON('${pageContext.request.contextPath}/users/GetUserRolesTree?username=' + username, function (data) {
                    $("#userRoles").combotree({data: data});
                })
            })
        </script>
    </body>
</html>
