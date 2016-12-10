<%-- 
    Document   : newindex
    Created on : 2016-8-30, 16:24:15
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
    </head>
    <body>
        <!--url:'getPlansPage?isAuth=1',-->
        <div class="easyui-tabs" style="width:100%;height:700px" data-options="fit:true">
            <div title="待办计划" style="padding:10px">
                <table id="plans_grid" class="easyui-datagrid" 
                       data-options="url:'getPlansPage?isAuth=1&if_union=3',method:'get',fitColumns:false,fit:true,idField:'plan_code',checkbox:true,toolbar:'#tb',pagination:true,pageNumber:1,pageSize:20,sortOrder:'DESC',sortName:'plan_sdate',singleSelect:true">
                    <thead data-options="frozen:true">
                        <tr>
                            <th data-options="field:'ck',checkbox:true"></th>
                            <th data-options="field:'plan_status_cmt',width:200,align:'center'">审核状态</th>
                            <th data-options="field:'xxx2',width:100,align:'center',formatter:planeditFormatter">操作</th>
                        </tr>
                    </thead>
                    <thead>
                        <tr>

                            <th data-options="field:'transfer_code',width:100,align:'center',hidden:true">移送代码</th>
                            <th data-options="field:'plan_code',width:100,align:'center',hidden:true">ID</th>
                            <th data-options="field:'plan_class',width:100,align:'center'">培训类别</th>                            
                            <th data-options="field:'plan_prof',width:100,align:'center'">专业系统</th>
                            <th data-options="field:'plan_name',width:250,align:'center'">培训班名</th>
                            <th data-options="field:'plan_num',width:70">培训人数</th>
                            <th data-options="field:'plan_periods',width:70,align:'center'">培训期数</th>
                            <th data-options="field:'plan_sdate',width:155,align:'center'">培训开始时间</th>
                            <th data-options="field:'plan_edate',width:155,align:'center'">培训结束时间</th>
                            <th data-options="field:'plan_object',width:100,align:'center'">培训对象</th>
                            <th data-options="field:'plan_cmt',width:200,align:'center'">培训内容</th>
                            <th data-options="field:'plan_type',width:100,align:'center'">培训方式</th>
                            <th data-options="field:'plan_executeunit',width:150,align:'center'">承办单位</th>
                            <th data-options="field:'plan_unit',width:150,align:'center'">主办单位</th>
                            <th data-options="field:'plan_situation',width:100,align:'center'">落实情况</th>
                            <th data-options="field:'plan_other_cmt',width:100,align:'center'">备注</th>
                            <th data-options="field:'plan_execunitid',width:100,align:'center',hidden:true">职称</th>
                            <th data-options="field:'plan_unitid',width:100,align:'center',hidden:true">职称</th>
                            <th data-options="field:'plan_profid',width:100,align:'center',hidden:true">职称</th>

                            <!--                            <th data-options="field:'xxx1',width:100,align:'center',formatter:plansFormatter1">进度查询</th>-->

                        </tr>
                    </thead>
                </table>
                <div id="editDialog">
                </div>
                <div id="tb">
                    <form id="search_form">
                        <div id="grud_div">
                            <a id="btn" href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-add'" onclick="append()">添加计划</a>
                            <a id="btn" href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-edit'" onclick="editIt()">修改计划</a>
                            <a id="btn" href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-del'" onclick="removeIt()">删除计划</a>
                        </div>    
                        <div>
                            <a id="btn" href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-edit'" onclick="transferBatch()">处室移送</a>
                            <a id="btn" href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-edit'" onclick="transComBatch()">单位移送</a>
                            <!--                        <a id="btn" href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-edit'" onclick="transferBatch()">财务单位移送</a>-->
                            <a id="btn" href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-edit'" onclick="authpassedBatch()">审核通过</a>
                            <a id="btn" href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-edit'" onclick="authTopsBatch()">返拟稿人</a>
                            <a id="btn" href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-del'" onclick="authUsersBatch()">返上一级</a>
                            <a id="btn" href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-del'" onclick="throwPlansBatch()">废弃</a>
                            <a id="btn" href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-del'" onclick="overPlansBatch()">完结</a>
                        </div>
                        <input type='hidden' name='reviewstatus' id="reviewstatus">
                        <label for="plan_mainid">主办单位：</lable><input id="plan_mainid" class="easyui-combobox" name="plan_mainid" style="width:150px;"
                                                                     data-options="valueField:'name',textField:'name',onSelect:searchPlans,url:'getUnitPlans?searchType=0&uid=&uname=',method:'get',editable:true,onLoadSuccess:unitLoadSuccess">
                            <label for="plan_execid">承办单位：</lable><input id="plan_execid" class="easyui-combobox" name="plan_execid" style="width:150px;"
                                                                         data-options="valueField:'name',textField:'name',onSelect:searchPlans,url:'getUnitPlans?searchType=1&uid=&uname=',method:'get',editable:true">
                                <label for="planname">培训班名：</lable><input type="text" name="planname" id="planname" class="easyui-textbox" data-options="lable:'计划名称'"/>
                                    <a id="btn" href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-search'" onclick="searchPlans()">搜索</a>                    
                                    </form>           
                                    </div>
                                    </div>
                                    <div title="经办计划">
                                        <table id="plans_grid1" class="easyui-datagrid"
                                               data-options="url:'getPlansPage?isAuth=2&if_union=3',method:'get',fitColumns:false,fit:true,idField:'plan_code',checkbox:true,toolbar:'#tb1',pagination:true,pageNumber:1,pageSize:20,sortOrder:'DESC',sortName:'plan_sdate',singleSelect:true">
                                            <thead data-options="frozen:true">
                                                <tr>
                                                    <th data-options="field:'ck',checkbox:true"></th>
                                                    <th data-options="field:'plan_status_cmt',width:200,align:'center'">审核状态</th>
                                                    <th data-options="field:'xxx',width:100,align:'center',formatter:plansFormatter">进度查询</th>
                                                </tr>
                                            </thead>
                                            <thead>
                                                <tr>

                                                    <th data-options="field:'plan_code',width:100,align:'center',hidden:true">ID</th>
                                                    <th data-options="field:'plan_code',width:100,align:'center',hidden:true">ID</th>                           
                                                    <th data-options="field:'plan_class',width:100,align:'center'">培训类别</th>
                                                    <th data-options="field:'plan_prof',width:100,align:'center'">专业系统</th>
                                                    <th data-options="field:'plan_name',width:250,align:'center'">培训班名</th>
                                                    <th data-options="field:'plan_num',width:70">培训人数</th>
                                                    <th data-options="field:'plan_periods',width:70,align:'center'">培训期数</th>
                                                    <th data-options="field:'plan_sdate',width:155,align:'center'">培训开始时间</th>
                                                    <th data-options="field:'plan_edate',width:155,align:'center'">培训结束时间</th>
                                                    <th data-options="field:'plan_object',width:100,align:'center'">培训对象</th>
                                                    <th data-options="field:'plan_cmt',width:200,align:'center'">培训内容</th>
                                                    <th data-options="field:'plan_type',width:100,align:'center'">培训方式</th>
                                                    <th data-options="field:'plan_executeunit',width:150,align:'center'">承办单位</th>
                                                    <th data-options="field:'plan_unit',width:150,align:'center'">主办单位</th>
                                                    <th data-options="field:'plan_situation',width:100,align:'center'">落实情况</th>
                                                    <th data-options="field:'plan_execunitid',width:100,align:'center',hidden:true">职称</th>
                                                    <th data-options="field:'plan_unitid',width:100,align:'center',hidden:true">职称</th>
                                                    <th data-options="field:'plan_profid',width:100,align:'center',hidden:true">职称</th>


                                                </tr>
                                            </thead>
                                        </table>
                                        <div id="tb1">
                                            <form id="search_form1">
                                                <input type='hidden' name='reviewstatus' id="reviewstatus">
                                                <label for="plan_mainid">主办单位：</lable><input id="plan_mainid" class="easyui-combobox" name="plan_mainid" style="width:150px;"
                                                                                             data-options="valueField:'name',textField:'name',onSelect:searchPlans1,url:'getUnitPlans?searchType=0&uid=&uname=',method:'get',editable:true,onLoadSuccess:unitLoadSuccess">
                                                    <label for="plan_execid">承办单位：</lable><input id="plan_execid" class="easyui-combobox" name="plan_execid" style="width:150px;"
                                                                                                 data-options="valueField:'name',textField:'name',onSelect:searchPlans1,url:'getUnitPlans?searchType=1&uid=&uname=',method:'get',editable:true">
                                                        <label for="planname">培训班名：</lable><input type="text" name="planname" id="planname" class="easyui-textbox" data-options="lable:'计划名称'"/>
                                                            <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchPlans1()">搜索</a>                    
                                                            </form>           
                                                            </div>
                                                            </div>
                                                            </div>
                                                            <%@include file="/WEB-INF/views/jspf/commonjs.jspf"%>
                                                            <link rel="stylesheet" href="../s/js/stepCommon/kfgl.css" />
                                                            <link rel="stylesheet" href="../s/js/stepCommon/uploadify.css" />
                                                            <!--<script type="text/javascript" src="../s/js/stepCommon/all-easyui.js"></script>-->
                                                            <link rel="stylesheet" href="../s/js/stepCommon/common.css" />
                                                            <link rel="stylesheet" href="../s/js/stepCommon/color.css" />
                                                            <input type="hidden" name="oplancode" id="oplancode" value=""/> 
                                                            <input type="hidden" name="otransfercode" id="otransfercode" value=""/> 
                                                            <script type="text/javascript">

                                                                $(function () {
                                                                    anticsrf();
                                                                })
                                                                ///搜索
                                                                function searchPlans() {
                                                                    var formdata = $("#search_form").serializeArray();
                                                                    var obj = {};
                                                                    $.each(formdata, function (index, item) {

                                                                        if (item.name == "plan_mainid")
                                                                        {
                                                                            if (item.value == "全部单位") {
                                                                                item.value = "";
                                                                            }
                                                                        }
                                                                        if (item.name == "plan_execid")
                                                                        {
                                                                            if (item.value == "全部单位") {
                                                                                item.value = "";
                                                                            }
                                                                        }

                                                                        obj[item.name] = item.value;
                                                                    })

                                                                    $("#plans_grid").datagrid('reload', obj);
                                                                }
                                                                function searchPlans1() {
                                                                    var formdata = $("#search_form1").serializeArray();
                                                                    var obj = {};
                                                                    $.each(formdata, function (index, item) {
                                                                        if (item.name == "plan_mainid")
                                                                        {
                                                                            if (item.value == "全部单位") {
                                                                                item.value = "";
                                                                            }
                                                                        }
                                                                        if (item.name == "plan_execid")
                                                                        {
                                                                            if (item.value == "全部单位") {
                                                                                item.value = "";
                                                                            }
                                                                        }
                                                                        obj[item.name] = item.value;
                                                                    })
                                                                    $("#plans_grid1").datagrid('reload', obj);
                                                                }
                                                                function unitLoadSuccess(obj) {
                                                                    $(this).combobox('select', '全部单位');
                                                                }
                                                                //查看计划审核详细
                                                                function plansFormatter(value, row, index) {
                                                                    if (row.plan_code) {
                                                                        return '<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:\'icon-add\'" onclick="plansSelected(\'' + row.plan_code + '\')">进度查询</a>'
                                                                    }
                                                                }
                                                                function plansFormatter1(value, row, index) {
                                                                    if (row.plan_code) {
                                                                        return '<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:\'icon-add\'" onclick="plansSelected(\'' + row.plan_code + '\')">进度查询</a>'
                                                                    }
                                                                }
                                                                function planeditFormatter(value, row, index) {
                                                                    if (row.plan_code) {
                                                                        return '<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:\'icon-add\'" onclick="planseditSelected(\'' + row.plan_code + '\',\'' + row.transfer_code + '\')">操作</a>'
                                                                    }
                                                                }
                                                                function plansSelected(plancode) {
                                                                    $("#oplancode").val(plancode);
                                                                    var window1 = $('<div/>')
                                                                    var href = "planView?id=" + plancode;
                                                                    window1.window({
                                                                        title: '计划详细',
                                                                        width: 1000,
                                                                        height: 590,
                                                                        maximized: false,
                                                                        maximizable: false,
                                                                        closed: false,
                                                                        content: '<iframe src="' + href + '" style="width:100%;height:530px;margin:0px;border:0px;overflow:hidden"></iframe>',
                                                                        cache: false,
                                                                        modal: true,
                                                                        buttons: [{
                                                                                text: '关闭',
                                                                                handler: function () {
                                                                                    $("#oplancode").val("");
                                                                                    window1.dialog('clear');
                                                                                    window1.dialog('close');
                                                                                }
                                                                            }]
                                                                    });
                                                                }
                                                                function planseditSelected(plancode, transfercode) {
                                                                    $("#oplancode").val("").val(plancode);
                                                                    $("#otransfercode").val("").val(transfercode);
                                                                    if ($("#otransfercode").val() != "" && $("#otransfercode").val() != "undefined")
                                                                    {
                                                                        showDialog('authReview', '查看', 'POST', '', false);
                                                                    } else
                                                                    {
                                                                        showDialog('personsedit', '编辑', 'POST', 'patchPlan', true);
                                                                    }
                                                                }
                                                                function append() {
                                                                    $("#oplancode").val("");
                                                                    $("#otransfercode").val("");
                                                                    showDialog('personsedit', '新增', 'POST', 'putPlan', true);
                                                                }
                                                                function showDialog(url, title, type, saveUrl, isuser) {
                                                                    var buttons = [];
                                                                    if (isuser)
                                                                    {
                                                                        buttons = [{
                                                                                text: '确定',
                                                                                handler: function () {
                                                                                    if (!($("#editDialog").find('form').form('validate'))) {
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
                                                                                        } else {
                                                                                            $("#ousernmae").val("");
                                                                                            $('#editDialog').dialog('clear');
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
                                                                                    $("#otransfercode").val("");
                                                                                    $('#editDialog').dialog('clear');
                                                                                    $('#editDialog').dialog('close');
                                                                                }
                                                                            }]
                                                                    } else
                                                                    {
                                                                        buttons = [{
                                                                                text: '取消',
                                                                                handler: function () {
                                                                                    $("#oplancode").val("");
                                                                                    $("#otransfercode").val("");
                                                                                    $('#editDialog').dialog('clear');
                                                                                    $('#editDialog').dialog('close');
                                                                                }
                                                                            }]
                                                                    }
                                                                    $('#editDialog').dialog({
                                                                        title: title,
                                                                        width: 1020,
                                                                        height: 500,
                                                                        closed: false,
                                                                        maximized: false,
                                                                        maximizable: true,
                                                                        cache: false,
                                                                        href: url,
                                                                        modal: true,
                                                                        buttons: buttons
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
                                                                        if (node.transfer_code.length > 0)
                                                                        {
                                                                            $.messager.alert('提示', "不能修改此计划!", 'info');
                                                                        } else
                                                                        {
                                                                            $("#oplancode").val(node.plan_code);
                                                                            showDialog('personsedit', '编辑', 'POST', 'patchPlan', true);
                                                                        }
                                                                    } else {
                                                                        $.messager.alert('提示', "至少选择一条数据!", 'info');
                                                                    }
                                                                }
                                                                function transFinFormatter(value, row, index)
                                                                {
                                                                    if (row.plan_code)
                                                                    {
                                                                        return '<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:\'icon-add\'" onclick="planseditSelected(\'' + row.plan_code + '\',\'' + row.transfer_code + '\')">操作</a>'
                                                                    }
                                                                }
                                                                function transFin(plancode, transcode)
                                                                {
                                                                    if (transcode)
                                                                    {

                                                                    } else
                                                                    {
                                                                        $("#otransfercode").val(transcode);
                                                                        $("#oplancode").val(plancode);

                                                                    }
                                                                }
                                                                        //批量处室移送计划
        function transferBatch() {
            var window1 = $('<div/>')
            window1.dialog({
                title: '移送',
                width: 820,
                height: 450,
                closed: false,
                maximizable: true,
                cache: false,
                href: 'selectUsers',
                modal: true,
                onClose: function () {
                    window1.dialog('clear');
                },
                buttons: [{
                    text: '确定',
                    handler: function () {
                        var plans = $("#plan_users_grid").datagrid('getSelections');
                        var users = $("#selectUsersGrid").datagrid('getSelections');
                        var formData = $("#search_users_form").serializeArray();
                        if (users.length == 0 || plans.length == 0) {
                            $.messager.alert('提示！', '至少选择一条计划！', 'info');
                            return;
                        }
                        formData.push({ name: 'transferStr', value: JSON.stringify(plans) });
                        formData.push({ name: 'reviewStr', value: JSON.stringify(users) });
                        $.ajax({
                            url: 'transBatch',
                            type: 'POST',
                            data: formData,
                            dataType: 'json'
                        }).done(function (result) {
                            if (!result.result) {
                                $.messager.alert('提示', result.info, 'info');
                            } else {
                                window1.dialog('clear');
                                window1.dialog('close');
                                $.messager.show({
                                    title: '消息提示',
                                    msg: '执行成功',
                                    timeout: 2000,
                                    showType: 'slide'
                                });
                                window1.dialog('clear');
                                window1.dialog('close');
                                searchPlans();
                                searchPlans1();
                            }
                        }).error(function (errorMsg) {
                            $.messager.alert('提示', errorMsg, 'info');
                        })
                    }
                }, {
                    text: '取消',
                    handler: function () {
                        window1.dialog('clear');
                        window1.dialog('close');
                    }
                }]
            });
        }
        //批量审核通过计划
        function authpassedBatch() {
            var window1 = $('<div/>')
            window1.dialog({
                title: '返拟稿人',
                width: 820,
                height: 450,
                closed: false,
                maximizable: true,
                cache: false,
                href: 'backTopsView',
                modal: true,
                onClose: function () {
                    window1.dialog('clear');
                },
                buttons: [{
                    text: '确定',
                    handler: function () {
                        var users = $("#plans_topusers_grid").datagrid('getSelections');
                        var formData = $("#authbackTopForm").serializeArray();
                        if (users.length == 0) {
                            $.messager.alert('提示！', '至少选择一条计划！', 'info');
                            return;
                        }
                        formData.push({ name: 'costStr', value: '[]' });
                        formData.push({ name: 'isEdu', value: '3' });
                        formData.push({ name: 'plansStr', value: JSON.stringify(users) });
                        $.ajax({
                            url: 'backToTops',
                            type: 'POST',
                            data: formData,
                            dataType: 'json'
                        }).done(function (result) {
                            if (!result.result) {
                                $.messager.alert('提示', result.info, 'info');
                            } else {
                                window1.dialog('clear');
                                window1.dialog('close');
                                $.messager.show({
                                    title: '消息提示',
                                    msg: '执行成功',
                                    timeout: 2000,
                                    showType: 'slide'
                                });
                                window1.dialog('clear');
                                window1.dialog('close');
                                searchPlans();
                                searchPlans1();
                            }
                        }).error(function (errorMsg) {
                            $.messager.alert('提示', errorMsg, 'info');
                        })
                    }
                }, {
                    text: '取消',
                    handler: function () {
                        window1.dialog('clear');
                        window1.dialog('close');
                    }
                }]
            });

        }
        //返回拟稿人批量
        function authTopsBatch() {
            var window1 = $('<div/>')
            window1.dialog({
                title: '批量审核',
                width: 820,
                height: 450,
                closed: false,
                maximizable: true,
                cache: false,
                href: 'authPassedsView',
                modal: true,
                onClose: function () {
                    window1.dialog('clear');
                },
                buttons: [{
                    text: '确定',
                    handler: function () {
                        var users = $("#plans_passed_grid").datagrid('getSelections');
                        var formData = $("#authPassedForm").serializeArray();
                        if (users.length == 0) {
                            $.messager.alert('提示！', '至少选择一条计划！', 'info');
                            return;
                        }
                        formData.push({ name: 'costStr', value: '[]' });
                        formData.push({ name: 'isEdu', value: '3' });
                        formData.push({ name: 'plansStr', value: JSON.stringify(users) });
                        $.ajax({
                            url: 'authrisePlans',
                            type: 'POST',
                            data: formData,
                            dataType: 'json'
                        }).done(function (result) {
                            if (!result.result) {
                                $.messager.alert('提示', result.info, 'info');
                            } else {
                                window1.dialog('clear');
                                window1.dialog('close');
                                $.messager.show({
                                    title: '消息提示',
                                    msg: '执行成功',
                                    timeout: 2000,
                                    showType: 'slide'
                                });
                                window1.dialog('clear');
                                window1.dialog('close');
                                searchPlans();
                                searchPlans1();
                            }
                        }).error(function (errorMsg) {
                            $.messager.alert('提示', errorMsg, 'info');
                        })
                    }
                }, {
                    text: '取消',
                    handler: function () {
                        window1.dialog('clear');
                        window1.dialog('close');
                    }
                }]
            });
        }
        //返回上一级用户批量
        function authUsersBatch() {
            var window1 = $('<div/>')
            window1.dialog({
                title: '批量审核',
                width: 820,
                height: 450,
                closed: false,
                maximizable: true,
                cache: false,
                href: 'backUsers',
                modal: true,
                onClose: function () {
                    window1.dialog('clear');
                },
                buttons: [{
                    text: '确定',
                    handler: function () {
                        var users = $("#plans_backusers_grid").datagrid('getSelections');
                        var formData = $("#backusersForm").serializeArray();
                        if (users.length == 0) {
                            $.messager.alert('提示！', '至少选择一条计划！', 'info');
                            return;
                        }
                        formData.push({ name: 'costStr', value: '[]' });
                        formData.push({ name: 'isEdu', value: '3' });
                        formData.push({ name: 'plansStr', value: JSON.stringify(users) });
                        $.ajax({
                            url: 'bactToUsers',
                            type: 'POST',
                            data: formData,
                            dataType: 'json'
                        }).done(function (result) {
                            if (!result.result) {
                                $.messager.alert('提示', result.info, 'info');
                            } else {
                                window1.dialog('clear');
                                window1.dialog('close');
                                $.messager.show({
                                    title: '消息提示',
                                    msg: '执行成功',
                                    timeout: 2000,
                                    showType: 'slide'
                                });
                                window1.dialog('clear');
                                window1.dialog('close');
                                searchPlans();
                                searchPlans1();
                            }
                        }).error(function (errorMsg) {
                            $.messager.alert('提示', errorMsg, 'info');
                        })
                    }
                }, {
                    text: '取消',
                    handler: function () {
                        window1.dialog('clear');
                        window1.dialog('close');
                    }
                }]
            });
        }
        //批量完结计划
        function overPlansBatch() {
            var window1 = $('<div/>')
            window1.dialog({
                title: '批量审核',
                width: 820,
                height: 450,
                closed: false,
                maximizable: true,
                cache: false,
                href: 'overPlansView',
                modal: true,
                onClose: function () {
                    window1.dialog('clear');
                },
                buttons: [{
                    text: '确定',
                    handler: function () {
                        var users = $("#plan_overs_grid").datagrid('getSelections');
                        var formData = $("#overforms").serializeArray();
                        if (users.length == 0) {
                            $.messager.alert('提示！', '至少选择一条计划！', 'info');
                            return;
                        }
                        formData.push({ name: 'plansStr', value: JSON.stringify(users) });
                        $.ajax({
                            url: 'overPlans',
                            type: 'POST',
                            data: formData,
                            dataType: 'json'
                        }).done(function (result) {
                            if (!result.result) {
                                $.messager.alert('提示', result.info, 'info');
                            } else {
                                window1.dialog('clear');
                                window1.dialog('close');
                                $.messager.show({
                                    title: '消息提示',
                                    msg: '执行成功',
                                    timeout: 2000,
                                    showType: 'slide'
                                });
                                window1.dialog('clear');
                                window1.dialog('close');
                                searchPlans();
                                searchPlans1();
                            }
                        }).error(function (errorMsg) {
                            $.messager.alert('提示', errorMsg, 'info');
                        })
                    }
                }, {
                    text: '取消',
                    handler: function () {
                        window1.dialog('clear');
                        window1.dialog('close');
                    }
                }]
            });
        }
        //废弃计划批量
        function throwPlansBatch() {
            var window1 = $('<div/>')
            window1.dialog({
                title: '批量审核',
                width: 820,
                height: 450,
                closed: false,
                maximizable: true,
                cache: false,
                href: 'throwsPlansView',
                modal: true,
                onClose: function () {
                    window1.dialog('clear');
                },
                buttons: [{
                    text: '确定',
                    handler: function () {
                        var users = $("#plan_throws_grid").datagrid('getSelections');
                        var formData = $("#trhowsforms").serializeArray();
                        if (users.length == 0) {
                            $.messager.alert('提示！', '至少选择一条计划！', 'info');
                            return;
                        }
                        formData.push({ name: 'plansStr', value: JSON.stringify(users) });
                        $.ajax({
                            url: 'throwsPlans',
                            type: 'POST',
                            data: formData,
                            dataType: 'json'
                        }).done(function (result) {
                            if (!result.result) {
                                $.messager.alert('提示', result.info, 'info');
                            } else {
                                window1.dialog('clear');
                                window1.dialog('close');
                                $.messager.show({
                                    title: '消息提示',
                                    msg: '执行成功',
                                    timeout: 2000,
                                    showType: 'slide'
                                });
                                window1.dialog('clear');
                                window1.dialog('close');
                                searchPlans();
                                searchPlans1();
                            }
                        }).error(function (errorMsg) {
                            $.messager.alert('提示', errorMsg, 'info');
                        })
                    }
                }, {
                    text: '取消',
                    handler: function () {
                        window1.dialog('clear');
                        window1.dialog('close');
                    }
                }]
            });
        }
        ///单位批量移送
        function transComBatch() {
            var window1 = $('<div/>')
            window1.dialog({
                title: '单位移送',
                width: 820,
                height: 450,
                closed: false,
                maximizable: true,
                cache: false,
                href: 'authTranfersView',
                modal: true,
                onClose: function () {
                    window1.dialog('clear');
                },
                buttons: [{
                    text: '确定',
                    handler: function () {
                        var plans = $("#plan_cusers_grid").datagrid('getSelections');
                        var users = $("#selectcUsersGrid").datagrid('getSelections');
                        var formData = $("#trhowsforms").serializeArray();
                        if (users.length == 0 || plans.length == 0) {
                            $.messager.alert('提示！', '至少选择一条计划！', 'info');
                            return;
                        }
                        formData.push({ name: 'transferStr', value: JSON.stringify(plans) });
                        formData.push({ name: 'reviewStr', value: JSON.stringify(users) });
                        $.ajax({
                            url: 'unitsTransBatch',
                            type: 'POST',
                            data: formData,
                            dataType: 'json'
                        }).done(function (result) {
                            if (!result.result) {
                                $.messager.alert('提示', result.info, 'info');
                            } else {
                                window1.dialog('clear');
                                window1.dialog('close');
                                $.messager.show({
                                    title: '消息提示',
                                    msg: '执行成功',
                                    timeout: 2000,
                                    showType: 'slide'
                                });
                                window1.dialog('clear');
                                window1.dialog('close');
                                searchPlans();
                                searchPlans1();
                            }
                        }).error(function (errorMsg) {
                            $.messager.alert('提示', errorMsg, 'info');
                        })
                    }
                }, {
                    text: '取消',
                    handler: function () {
                        window1.dialog('clear');
                        window1.dialog('close');
                    }
                }]
            });
        }
                                                            </script>
                                                            </body>
                                                            </html>
