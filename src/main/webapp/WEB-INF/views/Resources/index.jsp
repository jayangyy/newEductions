<%--
    Document   : index
    Created on : 2016-8-1, 9:09:54
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="_csrf" content="${_csrf.token}" />
        <meta name="_csrf_header" content="${_csrf.headerName}" />
        <title>菜单管理</title>
        <link href="../s/js/easyui/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css" />
        <link href="../s/js/easyui/themes/icon.css" rel="stylesheet" type="text/css">
        <script src="../s/js/easyui/jquery.min.js" type="text/javascript"></script>
        <script src="../s/js/easyui/jquery.easyui.min.js" type="text/javascript"></script>
        <script src="../s/js/json3/json3.js" type="text/javascript"></script>
        <script src="../s/js/easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
        <script src="../s/js/common.js" type="text/javascript"></script>
        <script type="text/javascript">
            function onContextMenu(e, row) {
                if (row) {
                    e.preventDefault();
                    $(this).treegrid('select', row.id);
                    $('#mm').menu('show', {
                        left: e.pageX,
                        top: e.pageY
                    });
                }
            }
        </script>

    </head>
    <body>
        <table id="res_grid" class="easyui-treegrid" style="width:600px;height:400px"
               data-options="url:'GetRess',idField:'id',treeField:'res_name',toolbar:'#tb',checkbox: false,animate: true,collapsible: true,method: 'get',onContextMenu:onContextMenu,rownumbers:true,singleSelect:true,sortName:'id',sortOrder:'ASC',fit:true,fitColumns:false,striped:true,title:'菜单管理',checkOnSelect:true, selectOncheck:true,onClickRow:onClickRow,onBeforeSelect:onBeforeSelect">          
            <thead frozen="true">
                <tr>
                    <th data-options="field:'res_name',width:180,halign:'center',">菜单名称</th>
                </tr>
            </thead>
            <thead>
                <tr>
                    <th data-options="field:'id',width:180,hidden:true">名称</th>
                    <th data-options="field:'res_pid',width:180,hidden:true">名称</th>
                    <th data-options="field:'res_url',width:180,align:'center'">菜单地址</th>
                    <th data-options="field:'res_enable',width:180,align:'center',formatter:formatenable">是否启用</th>
                </tr>
            </thead>
        </table>
        <div id="editDialog">
        </div>
        <div id="tb">
            <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="appendnew()">添加菜单</a>
            <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="editIt()">修改菜单</a>
            <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="removeIt()">删除菜单</a>
        </div>
        <div id="mm" class="easyui-menu" style="width:120px;">
            <div onclick="append()" data-options="iconCls:'icon-add'">增加</div>
            <div onclick="removeIt()" data-options="iconCls:'icon-remove'">删除</div>
            <div onclick="editIt()" data-options="iconCls:'icon-edit'">编辑</div>
            <div class="menu-sep"></div>
            <div onclick="collapse()">收缩</div>
            <div onclick="expand()">展开</div>
        </div>
        <input type="hidden" name="pid" id="pid" value="0"/>
        <input type="hidden" name="oid" id="oid" value="0"/>         
        <script type="text/javascript">
            $(function () {
                anticsrf();
            })
            var IsCheckFlag = 0;
            function onClickRow(row) {
                if (IsCheckFlag != 0) {
                    //第一次单击选中,第二次单击取消选中
                    $(this).treegrid('unselect', row.id);
                    IsCheckFlag = 0;
                } else {
                    IsCheckFlag = 1;
                }
            }
            function onBeforeSelect(row) {
                var node = $('#res_grid').treegrid('getSelected');
                if (node) {
                    if (node.id != row.id) {
                        if ($(this).treegrid('find', node.id) != null)
                        {
                            $(this).treegrid('unselect', node.id);
                        }
                        IsCheckFlag = 0;
                    }
                }
            }
            function formatenable(value, row, index) {
                if (row.res_enable) {
                    return "是";
                } else {
                    return "否";
                }
            }
            function append() {
                var node = $('#res_grid').treegrid('getSelected');
                if (node) {
                    $("#pid").val(node.id)
                    showDialog('Edit', '新增', 'POST', 'PutRes');
                } else {
                    showDialog('Edit', '新增', 'POST', 'PutRes');
                }
            }
            function appendnew()
            {
                showDialog('Edit', '新增', 'POST', 'PutRes');
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
                                    $("#pid").val("0");
                                    $("#oid").val("0");
                                    $('#editDialog').dialog('close');
                                    $('#res_grid').treegrid('reload');
                                }).error(function (errorMsg) {
                                    $.messager.alert('提示', errorMsg, 'info');
                                })
                            }
                        }, {
                            text: '取消',
                            handler: function () {
                                $("#pid").val("0");
                                $("#oid").val("0");
                                $('#editDialog').dialog('close');
                            }
                        }]
                });
            }
            function removeIt() {
                var node = $('#res_grid').treegrid('getSelected');
                if (node) {
                    $.messager.confirm('Confirm', '确定删除此菜单及其子菜单?', function (r) {
                        if (r) {
                            $.ajax({
                                url: 'DeleteRes?resId=' + node.id,
                                type: 'GET',
                                dataType: 'json'
                            }).done(function (result) {
                                if (!result.result) {
                                    $.messager.alert('提示', result.info, 'info');
                                }
                                $('#res_grid').treegrid('reload');
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
                var node = $('#res_grid').treegrid('getSelected');
                if (node) {
                    $("#oid").val(node.id);
                    showDialog('Edit', '编辑', 'POST', 'PatchRes');
                } else
                {
                    $.messager.alert('提示', "至少选择一条数据!", 'info');
                }
            }
            function collapse() {
                var node = $('#res_grid').treegrid('getSelected');
                if (node) {
                    $('#res_grid').treegrid('collapse', node.id);
                }
            }
            function expand() {
                var node = $('#res_grid').treegrid('getSelected');
                if (node) {
                    $('#res_grid').treegrid('expand', node.id);
                }
            }
        </script>
    </body>
</html>
