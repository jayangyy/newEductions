<%-- 
    Document   : index
    Created on : 2016-8-3, 14:52:07
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="_csrf" content="${_csrf.token}" />
        <meta name="_csrf_header" content="${_csrf.headerName}" />
        <title>角色管理</title>
        <link href="../s/js/easyui/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css" />
        <link href="../s/js/easyui/themes/icon.css" rel="stylesheet" type="text/css">
        <script src="../s/js/easyui/jquery.min.js" type="text/javascript"></script>
        <script src="../s/js/easyui/jquery.easyui.min.js" type="text/javascript"></script>
        <script src="../s/js/json3/json3.js" type="text/javascript"></script>
        <script src="../s/js/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
        <script src="../s/js/common.js" type="text/javascript"></script>
    </head>
    <body>
        <table id="roles_grid" class="easyui-datagrid" style="width:400px;height:250px"
               data-options="url:'GetRolePage',method:'get',fitColumns:true,fit:true,idField:'roleid',checkbox:true,toolbar:'#tb',pagination:true,pageNumber:1,pageSize:20,sortOrder:'ASC',sortName:'roleid',singleSelect:true">
            <thead>
                <tr>
                    <th data-options="field:'ck',checkbox:true"></th>
                    <th data-options="field:'roleid',width:100,hidden:true">Code</th>
                    <th data-options="field:'rolename',width:100">角色名</th>
                    <th data-options="field:'rolecmt',width:100,align:'center'">角色描述</th>
                    <th data-options="field:'xxx',width:100,align:'center',formatter:rolesFormatter">角色选择</th>
                    <th data-options="field:'xx',width:100,align:'center',formatter:authFormatter">授权</th>
                </tr>
            </thead>
        </table>
        <div id="editDialog">
        </div>
        <div id="tb">    
            <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="append()">添加角色</a>
            <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="editIt()">修改角色</a>
            <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="removeIt()">删除角色</a>
        </div>
        <input type="hidden" name="oroleid" id="oroleid" value="0"/>      
        <input type="hidden" name="croleid" id="croleid" value="0"/>    
        <script type="text/javascript">
            $(function () {
                anticsrf();
            })
            //下发角色选择
            function rolesFormatter(value, row, index) {
                if (row.roleid) {
                    return '<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:\'icon-add\'" onclick="rolesDeps(\'' + row.roleid + '\')">选择角色</a>'
                }
            }
            //授权
            function authFormatter(value, row, index) {
                if (row.roleid) {
                    return '<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:\'icon-add\'" onclick="authRoles(\'' + row.roleid + '\')">授权</a>'
                }
            }
            function rolesDeps(roleid) {
                var roleid = $("#croleid").val(roleid);
                $('#editDialog').dialog({
                    title: '选择角色',
                    width: 500,
                    height: 300,
                    closed: false,
                    cache: false,
                    modal: true,
                    href: '${pageContext.request.contextPath}/Roles/roleDeps',
                    buttons: [{
                            text: '确定',
                            handler: function () {
                                if (!($("#editDialog").find('form').form('validate')))
                                {
                                    return false;
                                }
                                var selRoles = $("#editDialog").find('[name=rolesDeps]');
                                var resdons = [];
                                $.each(selRoles, function (index, item) {
                                    resdons.push($(item).val());
                                })
                                $.ajax({
                                    url: 'UpdateRolesTree',
                                    type: 'POST',
                                    data: {rolesdown: resdons.join(","), roleid: $("#roleid").val()},
                                    dataType: 'json'
                                }).done(function (result) {
                                    if (!result.result) {
                                        $.messager.alert('提示', result.info, 'info');
                                    }
                                    $("#croleid").val(0);
                                    $('#editDialog').dialog('close');
                                    $.messager.show({
                                        title: '消息提示',
                                        msg: '修改成功',
                                        timeout: 2000,
                                        showType: 'slide'
                                    });
                                }).error(function (errorMsg) {
                                    $("#croleid").val(0);
                                    $('#editDialog').dialog('close');
                                    $.messager.alert('提示', errorMsg, 'info');
                                })
                            }
                        }, {
                            text: '取消',
                            handler: function () {
                                $("#croleid").val(0);
                                $('#editDialog').dialog('close');
                            }
                        }]
                });
            }
            function authRoles(roleid) {
                $("#croleid").val(roleid);
                $('#editDialog').dialog({
                    title: '授权',
                    width: 500,
                    height: 300,
                    closed: false,
                    cache: false,
                    modal: true,
                    href: '${pageContext.request.contextPath}/Roles/authRoles',
                    buttons: [{
                            text: '确定',
                            handler: function () {
                                if (!($("#editDialog").find('form').form('validate')))
                                {
                                    return false;
                                }
                                var selRoles = $("#editDialog").find('[name=authRoles]');
                                var resdons = [];
                                $.each(selRoles, function (index, item) {
                                    resdons.push($(item).val());
                                })
                                $.ajax({
                                    url: 'UpdateResRoles',
                                    type: 'POST',
                                    data: {rolesdown: resdons.join(","), roleid: $("#roleid").val()},
                                    dataType: 'json'
                                }).done(function (result) {
                                    if (!result.result) {
                                        $.messager.alert('提示', result.info, 'info');
                                    }
                                    $("#croleid").val(0);
                                    $('#editDialog').dialog('close');
                                    $.messager.show({
                                        title: '消息提示',
                                        msg: '修改成功',
                                        timeout: 2000,
                                        showType: 'slide'
                                    });
                                }).error(function (errorMsg) {
                                    $("#croleid").val(0);
                                    $('#editDialog').dialog('close');
                                    $.messager.alert('提示', errorMsg, 'info');
                                })
                            }
                        }, {
                            text: '取消',
                            handler: function () {
                                $("#croleid").val(0);
                                $('#editDialog').dialog('close');
                            }
                        }]
                });
            }
            function formatenable(value, row, index) {
                if (row.res_enable) {
                    return "是";
                } else {
                    return "否";
                }
            }
            function append() {
                $("#oroleid").val("0");
                showDialog('Edit', '新增', 'POST', 'PutRole');
            }
            function showDialog(url, title, type, saveUrl) {
                $('#editDialog').dialog({
                    title: title,
                    width: 400,
                    height: 200,
                    closed: false,
                    cache: false,
                    href: url,
                    modal: true,
                    buttons: [{
                            text: '确定',
                            handler: function () {
                                if (!($("#editDialog").find('form').form('validate')))
                                {
                                    return false;
                                }
                                $.ajax({
                                    url: saveUrl,
                                    type: type,
                                    data: $("#editDialog").find('form').serializeArray(),
                                    dataType: 'json'
                                }).done(function (result) {
                                    if (!result.result) {
                                        $.messager.alert('提示', result.info, 'info');
                                    }
                                    $("#oroleid").val("0");
                                    $('#editDialog').dialog('close');
                                    $('#roles_grid').datagrid('reload');
                                }).error(function (errorMsg) {
                                    $.messager.alert('提示', errorMsg, 'info');
                                })
                            }
                        }, {
                            text: '取消',
                            handler: function () {
                                $("#oroleid").val("0");
                                $('#editDialog').dialog('close');
                            }
                        }]
                });
            }
            function removeIt() {
                var node = $('#roles_grid').datagrid('getSelected');
                if (node) {
                    $.messager.confirm('Confirm', '确定删除此菜单及其子菜单?', function (r) {
                        if (r) {
                            $.ajax({
                                url: 'DeleteRole?roleid=' + node.roleid,
                                type: 'GET',
                                dataType: 'json'
                            }).done(function (result) {
                                if (!result.result) {
                                    $.messager.alert('提示', result.info, 'info');
                                }
                                $('#roles_grid').datagrid('reload');
                            }).error(function (errorMsg) {
                                $.messager.alert('提示', errorMsg, 'info');
                            })
                        }
                    });
                } else {
                    $.messager.alert('提示', "至少选中一条目录", 'info');
                }

            }
            function editIt() {
                var node = $('#roles_grid').datagrid('getSelected');
                if (node) {
                    $("#oroleid").val(node.roleid);
                    showDialog('Edit', '编辑', 'POST', 'PatchRole');
                } else
                {
                    $.messager.alert('提示', "至少选择一条数据!", 'info');
                }
            }
        </script>
    </body>
</html>
