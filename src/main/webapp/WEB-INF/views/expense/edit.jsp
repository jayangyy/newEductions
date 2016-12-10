<%-- 
    Document   : edit
    Created on : 2016-10-12, 16:00:06
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
        <style>
            .leftTd{width:120px;}
        </style>
        <script>
            var _isadmin = false;
            var _isedit = false;
            var _editData;
            $(function () {
                anticsrf();
                _isadmin = ${isadmin};
                if(!_isadmin){
                    $("#cbFirstType").combobox("disable");
                    $("#cbSecondType").combobox("disable");
                    $("#txtPostType").attr("disabled","disabled");
                    $("#txtTypecode").attr("disabled","disabled");
                }
                bindFisrtType();
                var _id = GetQueryString("id");
                if (_id != null && _id != "") {
                    _isedit = true;
                    bindEditData(_id);
                }
            });
            function bindFisrtType(){
                $.ajax({
                    type: 'get',
                    url: 'getDataByParentId',
                    data: {parentid:0},
                    dataType: "json",
                    async:true,
                    success: function (r) {
                        if(r.result && r.rows.length>0){
                            $("#cbFirstType").combobox("loadData", r.rows);
                            if(!_isedit)
                                $("#cbFirstType").combobox("setValue", r.rows[0].id);
                        }else{
                            $.messager.alert("提示", r.info, "error");
                        }
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "error");
                    }
                });
            }
            function bindSecondType(){
                var parentType = $("#cbFirstType").combobox("getValue");
                $.ajax({
                    type: 'get',
                    url: 'getDataByParentId',
                    data: {parentid:parentType,gp:"type"},
                    dataType: "json",
                    success: function (r) {
                        if(r.result && r.rows.length>0){
                            r.rows.unshift({"type": "--新增项目输入--"});
                            $("#cbSecondType").combobox("loadData", r.rows);
                            if(_isedit && parentType==_editData.parentid)
                                $("#cbSecondType").combobox("setValue", _editData.type);
                            else
                                $("#cbSecondType").combobox("setValue", r.rows[0].type);
                        }else{
                            $.messager.alert("提示", r.info, "error");
                        }
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "error");
                    }
                });
            }
            function bindEditData(id){
                $.ajax({
                    type: 'get',
                    url: 'getDataById',
                    data: {id:id},
                    dataType: "json",
                    success: function (r) {
                        if(r.result){
                            _editData = r.rows;
                            $("#cbFirstType").combobox("setValue",_editData.parentid);
                            $("#cbSecondType").combobox("setValue",_editData.type);
                            $("#txtPostType").val(_editData.posttype);
                            $("#txtTypecode").val(_editData.typecode);
                            $("#txtMemo").val(_editData.memo);
                            $("#txtUnit").val(_editData.unit);
                            $("#txtJnMin").val(_editData.jn_min_expense);
                            $("#txtJnMax").val(_editData.jn_max_expense);
                            $("#txtJwMin").val(_editData.jw_min_expense);
                            $("#txtJwMax").val(_editData.jw_max_expense);
                        }else{
                            $.messager.alert("提示", r.info, "error");
                        }
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "error");
                    }
                });
            }
            function saveDataClick(){
                $('.datatable').find('input').trigger("blur");
                var numError = $('.datatable').find('.check-error').length;
                if (numError) {
                    $('.datatable').find('.check-error').first().find('input').first().focus().select();
                    return;
                }
                var entityData={};
                var _parentid = $("#cbFirstType").combobox("getValue");entityData.parentid=_parentid;
                var _type = $("#cbSecondType").combobox("getValue");entityData.type=_type;
                if(entityData.type=="" || entityData.type=="--新增项目输入--"){
                    $.messager.alert("提示", "请选择或者输入新增项目！", "alert");
                    return;
                }
                var _posttype = $("#txtPostType").val();entityData.posttype=_posttype;
                var _typecode = $("#txtTypecode").val();entityData.typecode=_typecode;
                var _memo = $("#txtMemo").val();entityData.memo=_memo;
                var _unit = $("#txtUnit").val();entityData.unit=_unit;
                var _jn_min_expense = $("#txtJnMin").val();entityData.jn_min_expense=_jn_min_expense;
                var _jn_max_expense = $("#txtJnMax").val();entityData.jn_max_expense=_jn_max_expense;
                var _jw_min_expense = $("#txtJwMin").val();entityData.jw_min_expense=_jw_min_expense;
                var _jw_max_expense = $("#txtJwMax").val();entityData.jw_max_expense=_jw_max_expense;
                if(_isedit){
                    entityData.id = _editData.id;
                    $.ajax({
                        type: 'post',
                        url: 'upData',
                        data: entityData,
                        dataType: "json",
                        success: function (r) {
                            $.messager.alert("提示", r.info, "alert");
                            if (r.result) {
                                parent.bindData();
                                parent.$('#edit-window').window('close');
                            }
                        },
                        error: function () {
                            $.messager.alert("提示", "调用后台接口出错！", "alert");
                        }
                    });
                }else{
                    $.ajax({
                        type: 'post',
                        url: 'addData',
                        data: entityData,
                        dataType: "json",
                        success: function (r) {
                            $.messager.alert("提示", r.info, "alert");
                            if (r.result) {
                                parent.bindData();
                                parent.$('#edit-window').window('close');
                            }
                        },
                        error: function () {
                            $.messager.alert("提示", "调用后台接口出错！", "alert");
                        }
                    });
                }
            }
        </script>
    </head>
    <body>
        <table class="datatable" style="position:fixed;top:0px;left:0px;z-index:99999;background-color:#fff;">
            <tr>
                <td class="rightTd" colspan="2" style="text-align:left;">
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveDataClick()">确定</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-no'" onclick="parent.$('#edit-window').window('close')">关闭</a>
                </td>
            </tr>
        </table>
        <table class="datatable" style="margin-top:44px">
            <tr>
                <td class="leftTd">类别：</td>
                <td class="rightTd">
                    <input class="easyui-combobox" data-options="valueField:'id',textField:'type',editable:false,onChange:bindSecondType" style="width:130px;" id="cbFirstType">
                </td>
                <td class="leftTd">项目：</td>
                <td class="rightTd">
                    <input class="easyui-combobox" data-options="valueField:'type',textField:'type'" style="width:130px;" id="cbSecondType">
                </td>
            </tr>
            <tr>
                <td class="leftTd">工作事项：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="txtPostType" placeholder="工作事项" data-validate="required:请填写工作事项" onblur="ckeckValue(this);"/>
                        </div>
                    </div>
                </td>
                <td class="leftTd">工作事项代码：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="txtTypecode" placeholder="工作事项代码" data-validate="required:请填写工作事项代码" onblur="ckeckValue(this);"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">最低标准（局内）：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="txtJnMin" placeholder="最低标准（局内）" data-validate="double:只能输入数字" onblur="ckeckValue(this);"/>
                        </div>
                    </div>
                </td>
                <td class="leftTd">最高标准（局内）：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="txtJnMax" placeholder="最高标准（局内）" data-validate="double:只能输入数字" onblur="ckeckValue(this);"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">最低标准（局外）：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="txtJwMin" placeholder="最低标准（局外）" data-validate="double:只能输入数字" onblur="ckeckValue(this);"/>
                        </div>
                    </div>
                </td>
                <td class="leftTd">最高标准（局外）：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="txtJwMax" placeholder="最高标准（局外）" data-validate="double:只能输入数字" onblur="ckeckValue(this);"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">计量单位：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="txtUnit" placeholder="计量单位" data-validate="required:请填写计量单位" onblur="ckeckValue(this);"/>
                        </div>
                    </div>
                </td>
                <td class="leftTd">备注：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtMemo" onblur="ckeckValue(this);"/>
                </td>
            </tr>
        </table>
    </body>
</html>
