<%-- 
    Document   : editexam
    Created on : 2016-8-3, 10:48:50
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
            var _isedit = false;
            var _editData;
            var _pid = "";
            var _isvalidcode = true;
            $(function () {
                anticsrf();
		var d1 = myformatter(new Date());
		var d2 = new Date(d1);
                d2.setFullYear(d2.getFullYear()+4);
                d2 = myformatter(d2);
                $('#dtValidBeginDate').datebox('setValue',d1);
                $('#dtValidEndDate').datebox('setValue',d2);
                var  _id = GetQueryString("id");
                if (_id != null && _id != ""){
                    _isedit = true;
                    bindEditData(_id);
                }else{
                    _pid = GetQueryString("pid");
                }
            });
            function myformatter(date){
                var y = date.getFullYear();  
                var m = date.getMonth()+1;  
                var d = date.getDate();  
                var str = y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);  
                return str;
            }
            function bindEditData(_id) {
                $.ajax({
                    type: 'get',
                    url: 'exam/' + _id,
                    data: {},
                    dataType: "json",
                    async: false,
                    success: function (r) {
                        if (r.result) {
                            _editData = r.rows;
                            _pid = _editData.pid;
                            $("#txtEquipmentCode").val(_editData.equipment_code);
                            $('#dtValidBeginDate').datebox('setValue', _editData.valid_begin_date);
                            $('#dtValidEndDate').datebox('setValue', _editData.valid_end_date);
                            $("#txtHandUesr").val(_editData.hand_uesr);
                        } else
                            $.messager.alert("提示", r.info, "alert");
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "alert");
                    }
                });
            }
            function saveExamClick() {
                $("#txtEquipmentCode").focus();
                $('.datatable').find('input').trigger("blur");
                var numError = $('.datatable').find('.check-error').length;
                if (numError) {
                    $('.datatable').find('.check-error').first().find('input').first().focus().select();
                    return;
                }
                if(!_isvalidcode){
                    showErrInfo();
                    return;
                }
                var _equipment_code = $("#txtEquipmentCode").val();
                var _valid_begin_date = $('#dtValidBeginDate').datebox('getValue');
                var _valid_end_date = $('#dtValidEndDate').datebox('getValue');
                var _hand_uesr = $("#txtHandUesr").val();
                var entity = {pid:_pid,equipment_code:_equipment_code,valid_begin_date:_valid_begin_date,valid_end_date:_valid_end_date,hand_uesr:_hand_uesr};
                if(!_isedit){//add
                    $.ajax({
                        type: 'post',
                        url: 'addExam',
                        data: entity,
                        dataType: "json",
                        success: function (r) {
                            $.messager.alert("提示", r.info, "alert");
                            if (r.result) {
                                parent.bindData2();
                                parent.$('#card-window').window('close');
                            }
                        },
                        error: function () {
                            $.messager.alert("提示", "调用后台接口出错！", "alert");
                        }
                    });
                }else{//edit
                    entity.id=_editData.id;
                    $.ajax({
                        type: 'post',
                        url: 'editExam',
                        data: entity,
                        dataType: "json",
                        success: function (r) {
                            $.messager.alert("提示", r.info, "alert");
                            if (r.result) {
                                parent.bindData2();
                                parent.$('#card-window').window('close');
                            }
                        },
                        error: function () {
                            $.messager.alert("提示", "调用后台接口出错！", "alert");
                        }
                    });
                }
            }
            function checkCode(obj){
                var _code = $(obj).val();
                if(_code!=""){
                    $.ajax({
                        type: 'get',
                        url: 'validcode',
                        data: {code: _code},
                        dataType: "json",
                        success: function (r) {
                            if(r.result && r.rows){
                                $("#txtEquipmentName").val(r.rows.objname);
                                _isvalidcode = true;
                            }else{
                                showErrInfo();
                                $("#txtEquipmentName").val("");
                                _isvalidcode = false;
                            }
                        },
                        error: function () {
                            $.messager.alert("提示", "调用后台接口出错！", "alert");
                        }
                    });
                }
            }
            function showErrInfo(){
                $("#txtEquipmentCode").closest('.form-group').removeClass("check-success");
                $("#txtEquipmentCode").closest('.form-group').addClass("check-error");
                $("#txtEquipmentCode").closest('.field').append('<div class="input-help"><ul><li>字典表中未找到输入代号匹配的作业项目</li></ul></div>');
            }
        </script>
    </head>
    <body>
        <table class="datatable">
            <tr>
                <td class="leftTd">作业项目代号：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="txtEquipmentCode" placeholder="作业项目代号" data-validate="required:请填写作业项目代号" onblur="ckeckValue(this);checkCode(this);"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">作业项目名称：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtEquipmentName" disabled="disabled" placeholder="作业项目名称（匹配作业项目代号后自动读取）"/>
                </td>
            </tr>
            <tr>
                <td class="leftTd">批准日期：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-datebox" id="dtValidBeginDate">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">有效日期：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-datebox" id="dtValidEndDate">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">经办人：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtHandUesr" placeholder="经办人"/>
                </td>
            </tr>
            <tr>
                <td class="rightTd" colspan="2" style="text-align:right;">
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveExamClick()">确定</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-no'" onclick="parent.$('#card-window').window('close')">关闭</a>
                </td>
            </tr>
        </table>
    </body>
</html>
