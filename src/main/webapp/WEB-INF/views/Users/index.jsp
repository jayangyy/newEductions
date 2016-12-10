<%-- 
    Document   : index
    Created on : 2016-8-4, 15:05:49
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="_csrf" content="${_csrf.token}" />
        <meta name="_csrf_header" content="${_csrf.headerName}" />
        <title>用户管理</title>
        <link href="../s/js/easyui/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css" />
        <link href="../s/js/easyui/themes/icon.css" rel="stylesheet" type="text/css">
        <script src="../s/js/easyui/jquery.min.js" type="text/javascript"></script>
        <script src="../s/js/easyui/jquery.easyui.min.js" type="text/javascript"></script>
        <script src="../s/js/json3/json3.js" type="text/javascript"></script>
        <script src="../s/js/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
        <script src="../s/js/common.js" type="text/javascript"></script>
    </head>
    <body>
        <table id="users_grid" class="easyui-datagrid" style="width:400px;height:250px"
               data-options="url:'GetUserPage',method:'get',fitColumns:true,fit:true,idField:'username',checkbox:true,toolbar:'#tb',pagination:true,pageNumber:1,pageSize:20,sortOrder:'DESC',sortName:'username',singleSelect:true">
            <thead>
                <tr>
                    <th data-options="field:'ck',checkbox:true"></th>
                    <th data-options="field:'workername',width:100,align:'center'">用户姓名</th>
                     <th data-options="field:'username',width:150">身份证号码</th>
                    <th data-options="field:'company',width:100,align:'center'">单位</th>
                    <th data-options="field:'department',width:100,align:'center'">部门</th>
                    <th data-options="field:'sex',width:100,align:'center'">性别</th>
                    <th data-options="field:'nation',width:100,align:'center'">民族</th>
                    <th data-options="field:'political',width:100,align:'center'">政治面貌</th>
                    <th data-options="field:'post',width:100,align:'center'">现任职务</th>
                    <th data-options="field:'title',width:100,align:'center'">职称</th>
                    <th data-options="field:'technicalgrade',width:100,align:'center'">技术等级</th>
                    <th data-options="field:'xxx',width:100,align:'center',formatter:rolesFormatter">角色选择</th>
                    <th data-options="field:'xx',width:100,align:'center',formatter:groupsFormatter">用户组选择</th>
                </tr>
            </thead>
        </table>
        <div id="editDialog">
        </div>
        <div id="tb">
            <form id="search_form">
                <!--<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="append()">添加用户</a>-->
                <!--<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="editIt()">修改用户</a>-->
                <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="removeIt()">删除用户</a>
                <input type="text" name="suser_name" id="suser_name" class="easyui-textbox" data-options="lable:'用户名'"/>
                <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchUsers()">搜索</a>
            </form>           
        </div>
        <input type="hidden" name="ousername" id="ousername" value=""/>         
        <script type="text/javascript">
            $(function () {
                anticsrf();
            })
            ///搜索
            function searchUsers()
            {
                $("#users_grid").datagrid('reload', {search:$("#suser_name").val()});
            }
            //下发角色选择
            function rolesFormatter(value, row, index) {
                if (row.username) {
                    return '<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:\'icon-add\'" onclick="rolesSelected(\'' + row.username + '\')">选择角色</a>'
                }
            }
            //授权
            function groupsFormatter(value, row, index) {
                if (row.username) {
                    return '<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:\'icon-add\'" onclick="groupsSelected(\'' + row.username + '\')">选择用户组</a>'
                }
            }
            function rolesSelected(usernmae) {
                $("#ousername").val(usernmae);
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
                                var selRoles = $("#editDialog").find('[name=userRoles]');
                                var resdons = [];
                                $.each(selRoles, function (index, item) {
                                    resdons.push($(item).val());
                                })
                                $.ajax({
                                    url: 'UpdateUseRoles',
                                    type: 'POST',
                                    data: {roleids: resdons.join(','), username: $("#username").val()},
                                    dataType: 'json'
                                }).done(function (result) {
                                    if (!result.result) {
                                        $.messager.alert('提示', result.info, 'info');
                                    }
                                    $("#ousername").val("");
                                    $('#editDialog').dialog('close');
                                     $.messager.show({
                                        title: '消息提示',
                                        msg: '修改成功',
                                        timeout: 2000,
                                        showType: 'slide'
                                    });
                                }).error(function (errorMsg) {
                                    $("#ousername").val("");
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
            function groupsSelected(username) {
                $("#ousername").val(username);
                $('#editDialog').dialog({
                    title: '选择用户组',
                    width: 500,
                    height: 300,
                    closed: false,
                    href: 'editGroup',
                    cache: false,
                    modal: true,
                    buttons: [{
                            text: '确定',
                            handler: function () {
                                if (!($("#editDialog").find('form').form('validate')))
                                {
                                    return false;
                                }
                                var selGroups = $("#editDialog").find('[name=userGroups]');
                                var resdons = [];
                                $.each(selGroups, function (index, item) {
                                    resdons.push($(item).val());
                                })
                                $.ajax({
                                    url: 'UpdateUseGroups',
                                    type: 'POST',
                                    data: {roleids: resdons.join(','), username: $("#username").val()},
                                    dataType: 'json'
                                }).done(function (result) {
                                    if (!result.result) {
                                        $.messager.alert('提示', result.info, 'info');
                                    }
                                    $("#ousername").val("");
                                    $('#editDialog').dialog('close');
                                     $.messager.show({
                                        title: '消息提示',
                                        msg: '修改成功',
                                        timeout: 2000,
                                        showType: 'slide'
                                    });
                                }).error(function (errorMsg) {
                                     $("#ousername").val("");
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
            function append() {
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
                                    $("#ousernmae").val("");
                                    $('#editDialog').dialog('close');
                                     $.messager.show({
                                        title: '消息提示',
                                        msg: '修改成功',
                                        timeout: 2000,
                                        showType: 'slide'
                                    });
                                    $('#users_grid').datagrid('reload');
                                    
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
                var node = $('#users_grid').datagrid('getSelected');
                if (node) {
                    $.messager.confirm('Confirm', '确定删除此菜单及其子菜单?', function (r) {
                        if (r) {
                            $.ajax({
                                url: 'DeleteUser?uids=' + node.username,
                                type: 'GET',
                                dataType: 'json'
                            }).done(function (result) {
                                if (!result.result) {
                                    $.messager.alert('提示', result.info, 'info');
                                }
                                $('#users_grid').datagrid('reload');
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
                var node = $('#users_grid').datagrid('getSelected');
                if (node) {
                    $("#ousername").val(node.username);
                    showDialog('Edit', '编辑', 'POST', 'PatchUser');
                } else
                {
                    $.messager.alert('提示', "至少选择一条数据!", 'info');
                }
            }
        </script>
    </body>
</html>
