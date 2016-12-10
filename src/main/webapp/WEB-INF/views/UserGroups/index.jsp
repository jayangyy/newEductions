<%-- 
    Document   : inedex
    Created on : 2016-8-4, 15:06:32
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="_csrf" content="${_csrf.token}" />
        <meta name="_csrf_header" content="${_csrf.headerName}" />
        <title>用户组管理</title>
        <link href="../s/js/easyui/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css" />
        <link href="../s/js/easyui/themes/icon.css" rel="stylesheet" type="text/css">
        <script src="../s/js/easyui/jquery.min.js" type="text/javascript"></script>
        <script src="../s/js/easyui/jquery.easyui.min.js" type="text/javascript"></script>
        <script src="../s/js/json3/json3.js" type="text/javascript"></script>
        <script src="../s/js/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
        <script src="../s/js/common.js" type="text/javascript"></script>
    </head>
    <body>
        <table id="groups_grid" class="easyui-datagrid" style="width:400px;height:250px"
               data-options="url:'GetGroupsPage',method:'get',fitColumns:true,fit:true,idField:'id',checkbox:true,toolbar:'#tb',pagination:true,pageNumber:1,pageSize:20,sortOrder:'ASC',sortName:'id',singleSelect:true">
            <thead>
                <tr>
                    <th data-options="field:'ck',checkbox:true"></th>
                    <th data-options="field:'id',width:100,align:'center'">ID</th>
                    <th data-options="field:'group_name',width:100">用户名</th>
                    <th data-options="field:'xxx',width:100,align:'center',formatter:rolesFormatter">角色选择</th>
                </tr>
            </thead>
        </table>
        <div id="editDialog">
        </div>
        <div id="tb">
            <form id="search_form">
                <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="append()">添加用户组</a>
                <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="editIt()">修改用户组</a>
                <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="removeIt()">删除用户组</a>
            </form>           
        </div>
        <input type="hidden" name="ogroupid" id="ogroupid" value=""/>         
        <script type="text/javascript">
            $(function () {
                anticsrf();
            })
            ///搜索
            function searchUsers()
            {
                $("#groups_grid").datagrid('reload', $("#search_form").serializeArray());
            }
            //用户组-角色选择
            function rolesFormatter(value, row, index) {
                if (row.id) {
                    return '<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:\'icon-add\'" onclick="rolesSelected(\'' + row.id + '\')">选择角色</a>'
                }
            }
            function rolesSelected(id) {
                var groupid = $("#ogroupid").val(id);
                $('#editDialog').dialog({
                    title: '选择角色',
                    width: 500,
                    height: 300,
                    closed: false,
                    href: 'editRole',
                    cache: false,
                    modal: true,
                    buttons: [{
                            text: '确定',
                            handler: function () {
                                if (!($("#editDialog").find('form').form('validate')))
                                {
                                    return false;
                                }
                                var selGroups = $("#editDialog").find('[name=groupRoles]');
                                var resdons = [];
                                $.each(selGroups, function (index, item) {
                                    resdons.push($(item).val());
                                })
                                $.ajax({
                                    url: 'UpdateGroupsRole',
                                    type: 'POST',
                                    data: {groupid: $("#groupid").val(), roleids: resdons.join(',')},
                                    dataType: 'json'
                                }).done(function (result) {
                                    if (!result.result) {
                                        $.messager.alert('提示', result.info, 'info');
                                    }
                                    $("#ogroupid").val("0");
                                    $('#editDialog').dialog('close');
                                    $.messager.show({
                                        title: '消息提示',
                                        msg: '修改成功',
                                        timeout: 2000,
                                        showType: 'slide'
                                    });
                                }).error(function (errorMsg) {
                                    $("#ogroupid").val("0");
                                    $.messager.alert('提示', errorMsg, 'info');
                                })
                            }
                        }, {
                            text: '取消',
                            handler: function () {
                                $("#ogroupid").val("0");
                                $('#editDialog').dialog('close');
                            }
                        }]
                });
            }
            function append() {
                $("#ogroupid").val("0")
                showDialog('Edit', '新增', 'POST', 'PutGroup');
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
                                    $("#ousernmae").val("");
                                    $('#editDialog').dialog('close');
                                    $('#groups_grid').datagrid('reload');
                                }).error(function (errorMsg) {
                                    $.messager.alert('提示', errorMsg, 'info');
                                })
                            }
                        }, {
                            text: '取消',
                            handler: function () {
                                $("#ousername").val("");
                                $('#editDialog').dialog('close');
                            }
                        }]
                });
            }
            function removeIt() {
                var node = $('#groups_grid').datagrid('getSelected');
                if (node) {
                    $.messager.confirm('Confirm', '确定删除此用户组?', function (r) {
                        if (r) {
                            $.ajax({
                                url: 'DeleteGroup?groupids=' + node.id,
                                type: 'POST',
                                dataType: 'json'
                            }).done(function (result) {
                                if (!result.result) {
                                    $.messager.alert('提示', result.info, 'info');
                                }
                                $('#groups_grid').datagrid('reload');
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
                var node = $('#groups_grid').datagrid('getSelected');
                if (node) {
                    $("#ogroupid").val(node.id);
                    showDialog('Edit', '编辑', 'POST', 'PatchGroup');
                } else
                {
                    $.messager.alert('提示', "至少选择一条数据!", 'info');
                }
            }
        </script>
    </body>
</html>

