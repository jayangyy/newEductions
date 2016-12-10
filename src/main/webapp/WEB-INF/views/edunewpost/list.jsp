<%-- 
    Document   : list
    Created on : 2016-9-30, 9:42:25
    Author     : milord
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="_csrf" content="${_csrf.token}"/>
        <meta name="_csrf_header" content="${_csrf.headerName}"/>
        <title>JSP Page</title>
        <%@include file="/WEB-INF/views/jspf/commonjs.jspf"%>
        <script>
            var _iseduuser = false;
            var _iszjcuser = false;
            var _usercompanyid = "";
            $(function () {
                anticsrf();
                _iseduuser = ${iseduuser};
                _iszjcuser = ${iszjcuser};
                _usercompanyid = "${usercompanyid}";
                $("#btnAdd").linkbutton("disable");
                $("#btnEdit").linkbutton("disable");
                $("#btnDele").linkbutton("disable");
                if (_iseduuser || _iszjcuser) {
                    $("#btnAdd").linkbutton("enable");
                }
                bindData();
                $("#tt").datagrid('getPager').pagination({
                    onSelectPage: function () {
                        bindData();
                    }
                });
            });
            function bindData() {
                var index = layer.msg('加载数据中，请稍后...', {icon: 16, time: 10000, shade: [0.5, '#EAEAEA'], maxWidth: 230});
                var pageNumber = $("#tt").datagrid('getPager').data("pagination").options.pageNumber;
                pageNumber = pageNumber === 0 ? 1 : pageNumber;
                var pageSize = $("#tt").datagrid('getPager').data("pagination").options.pageSize;

                var _filterRules = [];
                var filterRuleStr = "";
                if (_filterRules.length > 0)
                    filterRuleStr = JSON.stringify(_filterRules);
                var _sort = $("#tt").datagrid('options').sortName;
                var _order = $("#tt").datagrid('options').sortOrder;
                if (_sort == null || _sort == "")
                    _order = "asc";
                $.ajax({
                    type: 'get',
                    url: 'allDatas',
                    data: {page: pageNumber, rows: pageSize, filterRules: filterRuleStr, sort: _sort, order: _order},
                    dataType: "json",
                    success: function (r) {
                        if (r.result) {
                            $("#tt").datagrid("loadData", r);
                            if (r.rows && r.rows.length > 0)
                                $("#tt").datagrid("selectRow", 0);
                        } else
                            $.messager.alert("提示", r.info, "info");
                        layer.close(index);
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "error");
                        layer.close(index);
                    }
                });
            }
            function addData(){
                var con = '<iframe src="edit" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                $("#edit-window").html(con);
                $("#edit-window").window({title: '新职、转岗、晋升人员培训情况登记'})
                $("#edit-window").window("open");
            }
            function editData(){
                var row = $("#tt").datagrid("getSelected");
                if (row) {
                    var con = '<iframe src="edit?id=' + row.id + '" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                    $("#edit-window").html(con);
                    $("#edit-window").window({title: '新职、转岗、晋升人员培训情况编辑[ ' + row.name + ' ]'})
                    $("#edit-window").window("open");
                } else
                    $.messager.alert("提示", "请选择要编辑的数据！", "warning");
            }
            function viewData(id,name){
                var con = '<iframe src="edit?view='+id+'" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                $("#edit-window").html(con);
                $("#edit-window").window({title: '新职、转岗、晋升人员培训情况查看['+name+']'})
                $("#edit-window").window("open");
            }
            function delData(){
                var row = $("#tt").datagrid("getSelected");
                if (row) {
                    if(row.fzdw=="" || row.fzrq==""){
                        $.messager.alert("提示", "已经发证的数据不允许删除！", "error");
                        return;
                    }
                    $.messager.confirm("提示", "确定要删除[ " + row.name + " ]的信息？", function (r) {
                        if (r)
                        {
                            $.ajax({
                                type: 'post',
                                url: 'delDataById',
                                data: {id:row.id},
                                dataType: "json",
                                success: function (r) {
                                    $.messager.alert("提示", r.info, "info");
                                    if (r.result) {
                                        bindData();
                                    }
                                },
                                error: function () {
                                    $.messager.alert("提示", "调用后台接口出错！", "error");
                                }
                            });
                        }
                    });
                } else
                    $.messager.alert("提示", "请选择要删除的数据！", "warning");
            }
            function formatView(value,row,index){
                return "<a href='#' onclick='viewData("+row.id+",\""+row.name+"\")'>点击查看</a>";
            }
            function datagridSelectRow(index, row){
                if(_usercompanyid==row.companyid && (_iseduuser || _iszjcuser)){
                    $("#btnEdit").linkbutton("enable");
                    $("#btnDele").linkbutton("enable");
                }
                else{
                    $("#btnEdit").linkbutton("disable");
                    $("#btnDele").linkbutton("disable");
                }
            }
        </script>
    </head>
    <body>
        <table id="tt" title="新、转、晋人员列表" class="easyui-datagrid" data-options="
               rownumbers:true,
               fit:true,
               singleSelect:true,
               pagination:true,
               pageSize:20,
               idField:'id',
               onSelect:datagridSelectRow,
               toolbar:'#menuTollbar'">
            <thead>
                <tr>
                    <th data-options="field:'name',width:80,align:'center',halign:'center'" rowspan="2">姓名</th>
                    <th data-options="field:'sex',width:40,align:'center',halign:'center'" rowspan="2">性别</th>
                    <th data-options="field:'workshop',width:80,align:'center',halign:'center'" rowspan="2">车间</th>
                    <th data-options="field:'training_type',width:40,align:'center',halign:'center'" rowspan="2">培训<br>类别</th>
                    <th data-options="field:'classno',width:80,align:'center',halign:'center'" rowspan="2">培训班编号</th>
                    <th data-options="field:'indenture',width:80,align:'center',halign:'center'" rowspan="2">师徒合同编号</th>
                    <th data-options="field:'zm',align:'center',halign:'center'" colspan="2">职名</th>
                    <th data-options="field:'xxl',align:'center',halign:'center'" colspan="2">学习令（培训通知）</th>
                    <th data-options="field:'aqjy',align:'center',halign:'center'" colspan="2">安全（入路）教育</th>
                    <th data-options="field:'view',align:'center',halign:'center',formatter:formatView" rowspan="2">查看明细</th>
                </tr>
                <tr>
                    <th data-options="field:'old_post',width:100,align:'center',halign:'center'">原职名</th>
                    <th data-options="field:'new_post',width:100,align:'center',halign:'center'">学习职名</th>
                    <th data-options="field:'study_date',width:80,align:'center',halign:'center'">日期</th>
                    <th data-options="field:'study_no',width:80,align:'center',halign:'center'">令号</th>
                    <th data-options="field:'rljy_begindate',width:80,align:'center',halign:'center'">起始日期</th>
                    <th data-options="field:'rljy_enddate',width:80,align:'center',halign:'center'">结束日期</th>
                </tr>
            </thead>
        </table>
        <div id="menuTollbar" style="height: auto;">
            <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-reload'" onclick="bindData();">刷新</a>
            <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-add'" id="btnAdd" onclick="addData();">添加</a>
            <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-edit'" id="btnEdit" onclick="editData();">编辑</a>
            <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-del'" id="btnDele" onclick="delData();">删除</a>
        </div>
        
        <div id="edit-window" class="easyui-window" title="" data-options="modal:true,closed:true,iconCls:'icon-save',minimizable:false,collapsible:false" style="width:700px;height:440px;overflow:hidden;">

        </div>
    </body>
</html>
