<%-- 
    Document   : edit
    Created on : 2016-8-4, 15:06:41
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
           <form id="editgroupForm" style="text-align: center;">
            <table>
                <tr>
                    <th>
                        <label>用户组名称:</label>  
                    </th>
                    <td>
                        <input type="text" name="group_name" id="group_name" value="" class="easyui-textbox" data-options="iconAlign:'left',required:true"/> 
                        <input type="hidden" name="id" id="id" value="0"/>
                    </td>
                </tr>
            </table>
        </form>
        <script type="text/javascript">
            $(function () {
                var groupid = $("#ogroupid").val();
                if (groupid =="0")
                {
                    //新增
                } else
                {
                    //编辑
                    $.getJSON('${pageContext.request.contextPath}/groups/GetGroup?groupid=' + groupid, function (data) {
                        if (data)
                        {
                            $("#group_name").textbox('setValue', data.group_name);
                            $("#id").val(data.id);
                        }
                    }).error(function (errMsg) {
                        $("#editgroupForm").attr('disabled', 'disabled');
                        $.messager.alert('提示', "未查到记录，稍后重试！", 'info');
                    })
                }
            })
        </script>
    </body>
</html>
