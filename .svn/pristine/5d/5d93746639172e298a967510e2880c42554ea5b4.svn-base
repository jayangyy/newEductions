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
        <title>待办审批</title>
    </head>
    <body>
        <div class="easyui-tabs" style="width:100%;height:700px" data-options="fit:true">
            <div title="待办计划" style="padding:10px">
                <table id="review_grid" class="easyui-datagrid" 
                       data-options="url:'getpReviews?isAuth=1',method:'get',fitColumns:false,fit:true,idField:'plan_code',checkbox:true,toolbar:'#tb',pagination:true,pageNumber:1,pageSize:20,sortOrder:'DESC',sortName:'plan_sdate',singleSelect:true">
                    <thead>
                        <tr>
                            <th data-options="field:'ck',checkbox:true"></th>
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
                            <th data-options="field:'plan_status_cmt',width:100,align:'center'">审核状态</th>
                            <th data-options="field:'xxx1',width:100,align:'center',formatter:plansFormatter1">进度查询</th>
                            <th data-options="field:'xxx2',width:100,align:'center',formatter:planeditFormatter">编辑</th>
                        </tr>
                    </thead>
                </table>
                <div id="editDialog" style="overflow: hidden">
                </div>
                <div id="tb">
                   <form id="search_form">       
                    <input type='hidden' name='reviewstatus' id="reviewstatus">
<!--                    <label for="plan_mainid">主办单位：</lable><input id="plan_mainid" class="easyui-combobox" name="plan_mainid" style="width:150px;"
                                                             data-options="valueField:'name',textField:'name',onSelect:searchPlans,url:'getUnits?searchType=0&uid=&uname=',method:'get',editable:true,onLoadSuccess:unitLoadSuccess">
                    <label for="plan_execid">承办单位：</lable><input id="plan_execid" class="easyui-combobox" name="plan_execid" style="width:150px;"
                                                                 data-options="valueField:'name',textField:'name',onSelect:searchPlans,url:'getUnits?searchType=1&uid=&uname=',method:'get',editable:true">-->
                    <label for="planname">培训班名：</lable><input type="text" name="planname" id="planname" class="easyui-textbox" data-options="lable:'计划名称'"/>
                    <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchPlans()">搜索</a>                    
                   </form>           
                </div>
            </div>
            <div title="经办计划">
                <table id="review_grid1" class="easyui-datagrid"
                       data-options="url:'getpReviews?isAuth=2',method:'get',fitColumns:false,fit:true,idField:'plan_code',checkbox:true,toolbar:'#tb1',pagination:true,pageNumber:1,pageSize:20,sortOrder:'DESC',sortName:'plan_sdate',singleSelect:true">
                    <thead>
                        <tr>
                            <th data-options="field:'ck',checkbox:true"></th>
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
                            <th data-options="field:'plan_status_cmt',width:100,align:'center'">审核状态</th>
                            <th data-options="field:'xxx',width:100,align:'center',formatter:plansFormatter">进度查询</th>
                        </tr>
                    </thead>
                </table>
                <div id="tb1">
                   <form id="search_form1">
                    <input type='hidden' name='reviewstatus' id="reviewstatus">
<!--                    <label for="plan_mainid">主办单位：</lable><input id="plan_mainid" class="easyui-combobox" name="plan_mainid" style="width:150px;"
                                                             data-options="valueField:'name',textField:'name',onSelect:searchPlans1,url:'getUnits?searchType=0&uid=&uname=',method:'get',editable:true,onLoadSuccess:unitLoadSuccess">
                    <label for="plan_execid">承办单位：</lable><input id="plan_execid" class="easyui-combobox" name="plan_execid" style="width:150px;"
                                                                 data-options="valueField:'name',textField:'name',onSelect:searchPlans1,url:'getUnits?searchType=1&uid=&uname=',method:'get',editable:true">-->
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
                                
//                if(item.name=="plan_mainid")
//                {
//                    if(item.value=="全部单位"){
//                      item.value="";
//                    }
//                }
//              if(item.name=="plan_execid")
//                {
//                    if(item.value=="全部单位"){
//                      item.value="";
//                    }
//                }
                obj[item.name] = item.value;
            })
            $("#review_grid").datagrid('reload', obj);
        }
        function searchPlans1() {
            var formdata = $("#search_form1").serializeArray();
            var obj = {};
            $.each(formdata, function (index, item) {
                                
//                if(item.name=="plan_mainid")
//                {
//                    if(item.value=="全部单位"){
//                      item.value="";
//                    }
//                }
//              if(item.name=="plan_execid")
//                {
//                    if(item.value=="全部单位"){
//                      item.value="";
//                    }
//                }
                obj[item.name] = item.value;
            })
            $("#review_grid1").datagrid('reload', obj);
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
        function planeditFormatter(value,row,index){
            if (row.plan_code) {
                return '<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:\'icon-add\'" onclick="planseditSelected(\'' + row.plan_code + '\',\''+row.transfer_code+'\')">审批</a>'
            }
        }
        function plansSelected(plancode) {
            $("#oplancode").val(plancode);
            var window1 = $('<div/>')
            var href = "planView?id=" + plancode;
            window1.window({
                title: '计划详细',
                width: 1000,
                maximized: false,
                maximizable: false,
                height:600,
                closed: false,
                content: '<iframe src="' + href + '" style="width:100%;height:530px;margin:0px;border:0px;overflow:hidden"></iframe>',
                cache: false,
                modal: true,
                buttons: [{
                    text: '关闭',
                    handler: function () {
                        $("#oplancode").val("");
                         $("#otransfercode").val("");
                        window1.dialog('clear');
                        window1.dialog('close');
                    }
                }]
            });
        }
                function unitLoadSuccess(obj){
       $(this).combobox('select','全部单位');
        }
        function planseditSelected(plancode,transcode) {
                $("#oplancode").val(plancode);
                $("#otransfercode").val(transcode);
                showDialog('authReview', '审批', 'POST', 'patchPlan');
        }
        function showDialog(url, title, type, saveUrl) {
            $('#editDialog').dialog({
                title: title,
                width: 1120,
                height: 450,
                closed: false,
                maximized: true,
                maximizable: true,resizable:true,inline:false,	
                cache: false,
                href: url,
                modal: true,
                buttons: [{
                    text: '取消',
                    handler: function () {
                        $("#oplancode").val("");
                        $('#editDialog').dialog('clear');
                        $('#editDialog').dialog('close');
                    }
                }]
            });
        }
    </script>
    </body>
</html>
