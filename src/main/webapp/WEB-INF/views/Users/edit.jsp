<%-- 
    Document   : edit
    Created on : 2016-8-4, 15:05:57
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
        <form id="edituserForm" style="text-align: center;">
            <table>
                <tr>
                    <th>
                        <label>角色名称:</label>  
                    </th>
                    <td>
                        <input type="text" name="username" id="username" value="" class="easyui-textbox" data-options="iconAlign:'left',required:true"/> 
                        <input type="hidden" name="password" id="password" value="11111" class="easyui-textbox" data-options="iconAlign:'left',required:true" />
                    </td>
                </tr>
            </table>
        </form>
        <script type="text/javascript">
            $(function () {
                var username = $("#ousername").val();
                if (username == "")
                {
                    //新增
                } else
                {
                    //编辑
                    $.getJSON('${pageContext.request.contextPath}/GetUser?username=' + username, function (data) {
                        if (data)
                        {
                            $("#username").textbox('setValue', data.username);
                            $("#password'").textbox('setValue', data.password);
                        }
                    }).error(function (errMsg) {
                        $("#edituserForm").attr('disabled', 'disabled');
                        $.messager.alert('提示', "未查到记录，稍后重试！", 'info');
                    })
                }
            })
        </script>
    </body>
</html>
