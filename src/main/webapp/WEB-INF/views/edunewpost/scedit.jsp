<%-- 
    Document   : scedit
    Created on : 2016-10-26, 10:31:43
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
        <script type="text/javascript" src="../s/js/Generation_Guid.js"></script>
        <style>
            table.datatable td {
                padding: 0px;
            }
            .input{border:none;}
        </style>
        <script>
            var _enpid;
            var _isedit = false;
            var _editData;
            var _studyType = [{"code": "安全Ⅰ", "name": "安全Ⅰ"}, {"code": "安全Ⅱ", "name": "安全Ⅱ"}, {"code": "安全Ⅲ", "name": "安全Ⅲ"}, {"code": "理论知识", "name": "理论知识"}, {"code": "实作技能", "name": "实作技能"}];
            $(function(){
                anticsrf();
                $("#study_type").combobox("select", _studyType[0].code);
                _enpid = GetQueryString("newpostid");
                var _id = GetQueryString("id");
                if (_id != null && _id != "") {
                    _isedit = true;
                    bindEditData(_id);
                }
            });
            function bindEditData(_id) {
                m.ajax('get','getStudyContentById',{id:_id},function(r){
                    if (r.result) {
                        _editData = r.rows;
                        $("#orderno").val(_editData.orderno);
                        $("#study_type").combobox("select", _editData.study_type);
                        $("#study_content").val(_editData.study_content);
                        $("#teacher").val(_editData.teacher);
                        $("#study_hours").val(_editData.study_hours);
                        $("#memo").val(_editData.memo);
                    } else
                        $.messager.alert("提示", r.info, "alert");
                });
            }
            function saveDataClick() {
                $('.datatable').find('input').trigger("blur");
                var numError = $('.datatable').find('.check-error').length;
                if (numError) {
                    $('.datatable').find('.check-error').first().find('input').first().focus().select();
                    return;
                }
                var entity = {};
                var _orderno = $("#orderno").val(); entity.orderno = _orderno;
                var _study_type = $("#study_type").combobox("getValue"); entity.study_type = _study_type;
                var _study_content = $("#study_content").val(); entity.study_content = _study_content;
                var _teacher = $("#teacher").val(); entity.teacher = _teacher;
                var _study_hours = $("#study_hours").val(); entity.study_hours = _study_hours;
                var _memo = $("#memo").val(); entity.memo = _memo;
                var _url = "addStudyContentData";
                if (!_isedit) {
                    entity.newpostid = _enpid;
                } else {
                    entity.id=_editData.id;
                    _url = "upStudyContentData";
                }
                m.ajax('post',_url,entity,function(r){
                    if (r.result) {
                        parent.bindData2();
                        parent.$('#edit-window').window('close');
                    } else
                        $.messager.alert("提示", r.info, "alert");
                });
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
        <table class="datatable" style="margin-top:27px">
            <tr>
                <td class="leftTd">排序号：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" id="orderno" class="input" placeholder="排序号" data-validate="required:请填写排序号" value="0" onblur="ckeckValue(this);"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">学习类别：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-combobox" style='width:100%;' data-options="valueField:'code',textField:'name',editable:false,data:_studyType" id="study_type">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">学习内容：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <!--<input type="text" id="study_content" class="input" placeholder="学习内容" data-validate="required:请填写学习内容" onblur="ckeckValue(this);"/>-->
                            <textarea id="study_content" class="input" style="width:98%;height:50px;" placeholder="学习内容" data-validate="required:请填写学习内容" onblur="ckeckValue(this);"></textarea>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">主讲人：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" id="teacher" class="input" placeholder="主讲人"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">学时：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="study_hours" data-validate="required:请填写学时,double:只能输入数字" onblur="ckeckValue(this);" placeholder="学时"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">成绩或备注：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" id="memo" class="input" placeholder="成绩或备注"/>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </body>
</html>
