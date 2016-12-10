<%-- 
    Document   : edit
    Created on : 2016-8-3, 16:00:59
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>角色编辑</title>
    </head>
    <body>
        <form id="editroleForm" style="text-align: center;">
            <table>
                <tr>
                    <th>
                        <label>角色名称:</label>  
                    </th>
                    <td>
                        <input type="text" name="rolename" id="rolename" value="" class="easyui-textbox" data-options="iconAlign:'left',required:true"/> 
                        <input type="hidden" name="roleid" id="roleid" value="0" />
                         <input type="hidden" name="rolesdown" id="rolesdown"  />
                    </td>
                </tr>
                <tr>
                    <th>
                        <label>角色描述:</label> 
                    </th>
                    <td>          
                        <input type="text" name="rolecmt" id="rolecmt" value="" class="easyui-textbox" data-options="iconAlign:'left',required:true" />
                    </td>
                </tr>
            </table>
        </form>
        <script type="text/javascript">
            $(function () {
                debugger;
                var rleid = $("#oroleid").val();
                if (rleid =="0")
                {
                    //新增
                } else
                {
                    //编辑
                    $.getJSON('${pageContext.request.contextPath}/Roles/GetRole?roleid=' + rleid, function (data) {
                        if (data)
                        {
                            $("#roleid").val(data.roleid);
                            $("#rolecmt").textbox('setValue', data.rolecmt);
                            $("#rolename").textbox('setValue',data.rolename);
                            $("#rolesdown").val(data.rolesdown);
                        }
                    }).error(function (errMsg) {
                        $("#editForm").attr('disabled', 'disabled');
                        $.messager.alert('提示', "未查到记录，稍后重试！", 'info');
                    })
                }
            })
        </script>
    </body>
</html>
