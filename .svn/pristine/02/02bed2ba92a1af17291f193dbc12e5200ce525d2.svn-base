<%-- 
    Document   : edit
    Created on : 2016-8-1, 15:35:58
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>编辑页面</title>
    </head>
    <body>
        <form id="editForm" style="text-align: center;">
            <table>
                <tr>
                    <th>
                        <label>菜单名称:</label> 
                    </th>
                    <td>          
                        <input type="text" name="res_name" id="res_name" value="" class="easyui-textbox" data-options="iconAlign:'left',required:true" />
                    </td>
                </tr>
                <tr>
                    <th>
                        <label>菜单地址:</label>  
                    </th>
                    <td>
                        <input type="text" name="res_url" id="res_url" value="" class="easyui-textbox" data-options="iconAlign:'left',required:true"/> 
                        <input type="hidden" name="res_pid" id="res_pid" value="0"/>
                        <input type="hidden" name="id" id="id" value="0" />
                    </td>
                </tr>
                <tr>
                    <th>
                        <label>是否启用:</label>  
                    </th>
                    <td>
                        <select id="res_enable" class="easyui-combobox" data-options="editable:false" name="res_enable" style="width:160px;">
                            <option value="1" checked="checked">是</option>
                            <option value="0">否</option>
                        </select>
                    </td>
                </tr>
            </table>

        </form>
        <script type="text/javascript">
            var id = $("#oid").val();
            var pid = $("#pid").val();
            if (id != "0") {
                $.getJSON('GetRes?resid=' + id, function (data) {
                    $("#res_name").textbox('setValue', data.res_name);
                    $("#res_url").textbox('setValue', data.res_url);
                    $("#res_pid").val(data.res_pid);
                    $("#id").val(data.id);
                    var enable=data.res_enable?"1":"0";
                    $('#res_enable').combobox('setValue',enable)
                }).error(function (errMsg) {
                    $("#editForm").attr('disabled', 'disabled');
                    $.messager.alert('提示', "未查到记录，稍后重试！", 'info');
                })
            } else
            {
                if (pid) {
                    $("#res_pid").val(pid);
                }
            }
        </script>
    </body>
</html>
