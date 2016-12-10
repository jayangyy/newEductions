<%-- 
    Document   : index
    Created on : 2016-8-25, 14:55:48
    Author     : Jayang
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="_csrf" content="${_csrf.token}" />
        <meta name="_csrf_header" content="${_csrf.headerName}" />
        <link href="../s/js/easyui/themes/bootstrap/easyui.css" rel="stylesheet" type="text/css" />
        <link href="../s/js/easyui/themes/icon.css" rel="stylesheet" type="text/css">
        <title>经费详细预算管理</title>
    </head>
    <body>        
        <table id="plans_grid"  class="easyui-datagrid" style="width:400px;height:250px"
               data-options="url:'getfReviews',method:'get',fitColumns:false,fit:true,idField:'plan_code',checkbox:true,toolbar:'#tb',pagination:true,pageNumber:1,pageSize:20,sortOrder:'DESC',sortName:'plan_sdate',singleSelect:true">
            <thead data-options="frozen:true">
                <tr>
                    <th data-options="field:'ck',checkbox:true"></th>
                    <th data-options="field:'xx',width:150,align:'center',formatter:reviewsFormatter">审核</th>
                    <th data-options="field:'xxx',width:100,align:'center',formatter:detailsFormatter">查看</th>
                </tr>
            </thead>
            <thead>
                <tr>
                    <th data-options="field:'ck',checkbox:true"></th>
                    <th data-options="field:'plan_code',width:100,align:'center',hidden:true">ID</th>
                    <th data-options="field:'transfer_code',width:100,align:'center',hidden:true">ID</th>
                    <th data-options="field:'cost_id',width:100,align:'center',hidden:true">培训类别</th>
                    <th data-options="field:'is_year_plan',width:100,align:'center'">是否年度计划</th>
                    <th data-options="field:'cost_name',width:100,align:'center'">专业系统</th>
                    <th data-options="field:'cost_user',width:250,align:'center'">联系人</th>
                    <th data-options="field:'cost_tell',width:70">联系电话</th>
                    <th data-options="field:'cost_address',width:70,align:'center'">培训地点</th>
                    <th data-options="field:'cost_persons',width:155,align:'center'">培训人数</th>
                    <th data-options="field:'cost_status_cmt',width:155,align:'center'">培训状态</th>
                </tr>
            </thead>
        </table>
        <div id="editDialog">
        </div>
        <div id="tb">
            <form id="search_form">
                <input type='hidden' name='reviewstatus' id="reviewstatus">
                <label for="plan_mainid">主办单位：</lable><input id="plan_mainid" class="easyui-combobox" name="plan_mainid" style="width:150px;"
                                                             data-options="valueField:'name',textField:'name',onSelect:searchPlans,url:'getUnits?searchType=0&uid=&uname=',method:'get',editable:false">
                    <label for="plan_execid">承办单位：</lable><input id="plan_execid" class="easyui-combobox" name="plan_execid" style="width:150px;"
                                                                 data-options="valueField:'name',textField:'name',onSelect:searchPlans,url:'getUnits?searchType=1&uid=&uname=',method:'get',editable:false">
                        <label for="planname">培训班名：</lable><input type="text" name="planname" id="planname" class="easyui-textbox" data-options="lable:'计划名称'"/>
                            <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchPlans()">搜索</a>
                            </form>           
                            </div>
                            <%@include file="/WEB-INF/views/jspf/commonjs.jspf"%>
                            <input type="hidden" name="oplancode" id="oplancode" value=""/> 
                            <script type="text/javascript">
                                $(function () {
                                    anticsrf();
                                })
                                ///搜索
                                function searchPlans()
                                {
                                    var formdata = $("#search_form").serializeArray();
                                    var obj = {};
                                    $.each(formdata, function (index, item) {
                                        obj[item.name] = item.value;
                                    })
                                    $("#plans_grid").datagrid('reload', obj);
                                }
                                //审核
                                function reviewsFormatter(value, row, index) {
                                    var authStatus = '${statusEnum}';
                                    if (authStatus.indexOf(row.plan_status) >= 0) {
                                        return '<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:\'icon-add\'" onclick="authSelected(\'' + row.plan_code + '\')">审核</a>'
                                    } else
                                    {
                                        return "";
                                    }
                                }
                                function authSelected(plancode) {
                                    $("#oplancode").val(plancode);
                                    showDialog("authfReview", "审核", 'POST', 'putReview');
                                }                                //查看计划审核详细
                                function detailsFormatter(value, row, index) {
                                    if (row.plan_code) {
                                        return '<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:\'icon-add\'" onclick="plansSelected(\'' + row.plan_code + '\')">进度查询</a>'
                                    }
                                }
                                function plansSelected(plancode) {
                                    $("#oplancode").val(plancode);
                                    var href = "planView?id=" + plancode;
                                    $('#editDialog').window({
                                        title: '计划详细',
                                        width: 1000,
                                        maximized: true,
                                        maximizable: true,
                                        closed: false,
                                        content: '<iframe src="' + href + '" style="width:100%;height:760px;margin:0px;border:0px;overflow:auto"></iframe>',
                                        cache: false,
                                        modal: true,
                                        buttons: [{
                                                text: '关闭',
                                                handler: function () {
                                                    $("#oplancode").val("");
                                                    $('#editDialog').dialog('close');
                                                }
                                            }]
                                    });
                                }
                                function showDialog(url, title, type, saveUrl) {
                                    $('#editDialog').dialog({
                                        title: title,
                                        width: 600,
                                        height: 300,
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
                                                        } else
                                                        {
                                                            $("#ousernmae").val("");
                                                            $('#editDialog').dialog('close');
                                                            $.messager.show({
                                                                title: '消息提示',
                                                                msg: '执行成功',
                                                                timeout: 2000,
                                                                showType: 'slide'
                                                            });
                                                            $('#plans_grid').datagrid('reload');
                                                        }
                                                    }).error(function (errorMsg) {
                                                        $.messager.alert('提示', errorMsg, 'info');
                                                    })
                                                }
                                            }, {
                                                text: '取消',
                                                handler: function () {
                                                    $("#oplancode").val("");
                                                    $('#editDialog').dialog('close');
                                                }
                                            }]
                                    });
                                }
                                function removeIt() {
                                    var node = $('#plans_grid').datagrid('getSelected');
                                    if (node) {
                                        $.messager.confirm('Confirm', '确定删除此计划?', function (r) {
                                            if (r) {
                                                $.ajax({
                                                    url: 'deltePlan?id=' + node.plan_code,
                                                    type: 'POST',
                                                    dataType: 'json'
                                                }).done(function (result) {
                                                    if (!result.result) {
                                                        $.messager.alert('提示', result.info, 'info');
                                                    }
                                                    $('#plans_grid').datagrid('reload');
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
                                    var node = $('#plans_grid').datagrid('getSelected');
                                    if (node) {
                                        $("#oplancode").val(node.plan_code);
                                        showDialog('edit', '编辑', 'POST', 'patchPlan');
                                    } else
                                    {
                                        $.messager.alert('提示', "至少选择一条数据!", 'info');
                                    }
                                }
                            </script>      
                            </body>
                            </html>
