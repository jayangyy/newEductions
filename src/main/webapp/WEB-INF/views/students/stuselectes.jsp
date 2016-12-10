<%-- 
    Document   : stuselectes
    Created on : 2016-9-29, 15:17:39
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="easyui-layout" style="width:880px;height:490px;">
    <div id="p" data-options="region:'west'" title="已选择考生" style="width:50%;padding:10px">
        <table id="stu_selected_grid" class="easyui-datagrid" style="width:50%;height:250px"
               data-options="method:'get',fitColumns:true,fit:true,idField:'stu_idcard',titile:'已选考生',checkbox:true,toolbar:'#selected_tb',pagination:true,pageNumber:1,pageSize:20,sortOrder:'DESC',sortName:'stu_name',singleSelect:false">
            <thead>
                <tr>
                    <th data-options="field:'stu_idcard',width:100,align:'center',hidden:true">编号</th>
                    <th data-options="field:'stu_oldjob',width:100,align:'center',hidden:true">编号</th>
                    <th data-options="field:'stu_curjob',width:100,align:'center',hidden:true">编号</th>
                    <th data-options="field:'class_no',width:100,align:'center',hidden:true">编号</th>
                    <th data-options="field:'ck',checkbox:true"></th>
                    <th data-options="field:'stu_name',width:100,align:'center'">姓名</th>
                    <th data-options="field:'stu_sex',width:100,align:'center'">性别</th>
                    <th data-options="field:'stu_unit',width:100,align:'center'">单位</th>
                    <th data-options="field:'stu_dep',width:100,align:'center'">部门</th>
                </tr>
            </thead>
        </table>
    </div>
    <div data-options="region:'center'" title="未选择考生">
        <table id="stu_unselect_grid" class="easyui-datagrid" style="width:50%;height:250px;margin-right: 10px;"
               data-options="method:'get',fitColumns:false,fit:true,idField:'stu_idcard',checkbox:true,toolbar:'#unselect_tb',pagination:true,pageNumber:1,pageSize:20,sortOrder:'DESC',sortName:'stu_name',singleSelect:false">
            <thead>
                <tr>
                    <th data-options="field:'stu_idcard',width:100,align:'center',hidden:true">编号</th>
                    <th data-options="field:'stu_oldjob',width:100,align:'center',hidden:true">编号</th>
                    <th data-options="field:'stu_curjob',width:100,align:'center',hidden:true">编号</th>
                    <th data-options="field:'class_no',width:100,align:'center',hidden:true">编号</th>
                    <th data-options="field:'ck',checkbox:true"></th>
                    <th data-options="field:'stu_name',width:100,align:'center'">姓名</th>
                    <th data-options="field:'stu_sex',width:100,align:'center'">性别</th>
                    <th data-options="field:'stu_unit',width:100,align:'center'">单位</th>
                    <th data-options="field:'stu_dep',width:100,align:'center'">部门</th>
                </tr>
            </thead>
        </table>
    </div>
</div>
<div id="stu_selectets_div">
    <div id="selected_tb">
        <form id="stu_search_form1">             
            <label for="stu_sname">姓名：</lable><input type="text" name="stu_sname" id="stu_sname" class="easyui-textbox" data-options="lable:'姓名'"/>
                <a id="selected_btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'"  onclick="selectedsearch()">搜索</a>
                <a id="stu_unselect_btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'"  onclick="removeStus()">移除人员</a>
        </form>           
    </div>
    <div id="unselect_tb">
        <form id="stu_search_form2">
            <label for="stu_sname">姓名：</lable><input type="text" name="stu_sname" id="stu_sname" class="easyui-textbox" data-options="lable:'姓名'"/>
                <a id="stu_unselect_btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'"  onclick="unselectedsearch()">搜索</a>   
                <a id="stu_unselect_btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'"  onclick="selectedsaved()">添加人员</a>
        </form>           
    </div>
</div>
<script type="text/javascript">
    $(function () {
        var unurl = 'getStus?is_inputs=true&classno=' + planViewModel.stu_class_oid() + '&stu_sunit=' + planViewModel.unit();
        var url = 'getStus?is_inputs=false&classno=' + planViewModel.stu_class_oid() + '&stu_sunit=' + planViewModel.unit();
        $("#stu_unselect_grid").datagrid({url: unurl})
        $("#stu_selected_grid").datagrid({url: url})
        selectStudentsModel = {
            init: function () {

            },
            savedSelected: function () {


            }
        };
        selectStudentsModel.init();
    })
    function unselectedsearch() {
        selectstusSearch("stu_search_form2", "stu_unselect_grid");
    }
    function selectedsearch() {
        selectstusSearch("stu_search_form1", "stu_selected_grid");
    }
    function selectstusSearch(fromid, gridid)
    {
        var formdata = $('#' + fromid + '').serializeArray();
        var obj = {};
        $.each(formdata, function (index, item) {
            obj[item.name] = item.value;
        })
        if (obj.offic_unit == '全部单位')
        {
            obj.offic_unit = '';
        }
        $('#' + gridid + '').datagrid('reload', obj);
    }
    function selectedsaved()
    {
        var users = $("#stu_unselect_grid").datagrid('getSelections');
        if (users.length == 0 || planViewModel.stu_class_oid().length == 0)
        {
            return;
        }
        $.each(users, function (index, item) {
            item.class_no = planViewModel.stu_class_oid();
            item.stu_curjob = planViewModel.newjob();
        })
        $.ajax({
            url: 'putStus',
            type: 'POST',
            data: {stus: JSON.stringify(users), classno: planViewModel.stu_class_oid(), unit: planViewModel.unit()},
            dataType: 'json'
        }).done(function (result) {
            if (!result.result) {
                $.messager.alert('提示', result.info, 'info');
            } else {
                $.messager.show({
                    title: '消息提示',
                    msg: '执行成功',
                    timeout: 2000,
                    showType: 'slide'
                });
                $("#stu_unselect_grid").datagrid('clearSelections');
                unselectedsearch();
                selectedsearch();
            }
        }).error(function (errorMsg) {
            $.messager.alert('提示', errorMsg, 'info');
        })
    }
    function removeStus()
    {
        var users = $("#stu_selected_grid").datagrid('getSelections');
        if (users.length == 0 || planViewModel.stu_class_oid().length == 0)
        {
            return;
        }
        var idarray = [];
        $.each(users, function (index, item) {
            idarray.push(item.stu_idcard);
        })
        $.ajax({
            url: 'removeStu',
            type: 'POST',
            data: {ids: idarray.join("','"), classno: planViewModel.stu_class_oid()},
            dataType: 'json'
        }).done(function (result) {
            if (!result.result) {
                $.messager.alert('提示', result.info, 'info');
            } else {
                $.messager.show({
                    title: '消息提示',
                    msg: '执行成功',
                    timeout: 2000,
                    showType: 'slide'
                });

                $("#stu_selected_grid").datagrid('clearSelections');
                unselectedsearch();
                selectedsearch();
            }
        }).error(function (errorMsg) {
            $.messager.alert('提示', errorMsg, 'info');
        })
    }
</script>
