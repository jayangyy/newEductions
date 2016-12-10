<%-- 
    Document   : loadAhths
    Created on : 2016-8-10, 10:07:50
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="_csrf" content="${_csrf.token}" />
        <meta name="_csrf_header" content="${_csrf.headerName}" />
        <title>JSP Page</title>
        <link href="../s/js/easyui/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css" />
        <link href="../s/js/easyui/themes/icon.css" rel="stylesheet" type="text/css">
        <script src="../s/js/easyui/jquery.min.js" type="text/javascript"></script>
        <script src="../s/js/easyui/jquery.easyui.min.js" type="text/javascript"></script>
        <script src="../s/js/json3/json3.js" type="text/javascript"></script>
        <script src="../s/js/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
        <script src="../s/js/common.js" type="text/javascript"></script>
    </head>
    <body>
        <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="refreshAuths()">更新权限缓存</a>
        <script type="text/javascript">
            $(function () {
                anticsrf();
            })
            function refreshAuths()
            {
                $.ajax({
                    url: 'RefreshAuths',
                    type: 'POST',
                    dataType: 'json'
                }).done(function (result) {
                    if (!result.result) {
                        $.messager.alert('提示', result.info, 'info');
                    }
                    $.messager.show({
                        title: '消息提示',
                        msg: '修改成功',
                        timeout: 2000,
                        showType: 'slide'
                    });
                }).error(function (errorMsg) {
                    $.messager.alert('提示', errorMsg, 'info');
                })
            }
        </script>
    </body>
</html>
