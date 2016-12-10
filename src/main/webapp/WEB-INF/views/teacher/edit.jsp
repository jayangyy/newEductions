<%-- 
    Document   : edit
    Created on : 2016-8-11, 15:36:08
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
        <title>Book Edit</title>
        <%@include file="/WEB-INF/views/jspf/commonjs.jspf"%>
        <script>
            var _teacherType = [{"code": "兼职教师", "name": "兼职教师"}, {"code": "管理人员", "name": "管理人员"}, {"code": "专职教师", "name": "专职教师"}];
            var _isedit = false;
            var _editData;
            var _iszjcuser = false;
            $(function () {
                anticsrf();
                _iszjcuser = ${iszjcuser};
//                $("#cbTeacherType").combobox("select", _teacherType[0].code);
                var _pid = GetQueryString("pid");
                if (_pid != null && _pid != "") {
                    _isedit = true;
                    bindEditData(_pid);
                }
            });
            function bindEditData(_pid) {
                $.ajax({
                    type: 'get',
                    url: 'teacher/' + _pid,
                    data: {},
                    dataType: "json",
                    async: false,
                    success: function (r) {
                        if (r.result) {
                            _editData = r.rows;
                            $("#txtPid").val(_editData.pid);
                            $("#txtUserName").val(_editData.name);
                            $("#txtUserSex").val(_editData.sex);
                            $('#dtEduDate').datebox('setValue', _editData.edu_date);
//                            $("#cbTeacherType").combobox("setValue", _editData.type);
                            if(_editData.iszz==1) $("#iszz").prop("checked","checked");
                            if(_editData.isjpjz==1) $("#isjpjz").prop("checked","checked");
                            if(_editData.iszdjz==1) $("#iszdjz").prop("checked","checked");
                            $("#txtProf").val(_editData.prof);
                            $('#dtJxjyDate').datebox('setValue', _editData.jxjy_date);
                            $('#dtHireDate').datebox('setValue', _editData.hire_date);
                            $("#txtPhone").val(_editData.phone);
                            $("#txtMobel").val(_editData.mobile);
                            $("#txtMemo").val(_editData.memo);
                            $("#txtCert").val(_editData.cert);
                            $("#txtLl").val(_editData.ll);
                            $("#txtSz").val(_editData.sz);
                            $("#txtZjjl").val(_editData.zjjl);
                            $("#txtXh").val(_editData.xh);
                        } else
                            $.messager.alert("提示", r.info, "alert");
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "alert");
                    }
                });
            }
            function showErrInfo(obj, msg) {
                $(obj).closest('.form-group').removeClass("check-success");
                $(obj).closest('.form-group').addClass("check-error");
                $(obj).closest('.field').append('<div class="input-help"><ul><li>' + msg + '</li></ul></div>');
            }
            function clearErrInfo(obj) {
                $(obj).closest('.form-group').removeClass("check-error");
                $(obj).parent().find(".input-help").remove();
                $(obj).closest('.form-group').addClass("check-success");
            }
            function saveDataClick() {
                if($("input:checkbox[name='cbTeacherType']:checked").length<1){showErrInfo($("#iszdjz"), "教师类型至少选择一项");return;}
                else{clearErrInfo($("#iszdjz"));}
                $('.datatable').find('input').trigger("blur");
                var numError = $('.datatable').find('.check-error').length;
                if (numError) {
                    $('.datatable').find('.check-error').first().find('input').first().focus().select();
                    return;
                }
                var _pid = $("#txtPid").val();
                if(_pid==""){showErrInfo($("#txtUserName"), "职工表中未找到本单位此职工");return;}
                var _edu_date = $('#dtEduDate').datebox('getValue');
                var _type = "";
                var _iszz = $("#iszz").prop("checked")==true?1:0;
                var _isjpjz = $("#isjpjz").prop("checked")==true?1:0;
                var _iszdjz = $("#iszdjz").prop("checked")==true?1:0;
                var _phone = $("#txtPhone").val();
                var _mobile = $("#txtMobel").val();
                var _zjjl = $("#txtZjjl").val();
                var _ll = $("#txtLl").val();
                var _sz = $("#txtSz").val();
                var _subject = $("#txtLl").val();
                var _jxjy_date = $('#dtJxjyDate').datebox('getValue');
                var _hire_date = $('#dtHireDate').datebox('getValue');
                var _memo = $("#txtMemo").val();
                var _cert = $("#txtCert").val();
                var _prof = $("#txtProf").val();
                var _xh = $("#txtXh").val()==""?"0":$("#txtXh").val();
                var entity = {pid: _pid, edu_date: _edu_date, type: _type, subject: _subject, jxjy_date: _jxjy_date, hire_date: _hire_date, memo: _memo, cert: _cert, prof: _prof,iszz:_iszz,isjpjz:_isjpjz,iszdjz:_iszdjz,zjjl:_zjjl,ll:_ll,sz:_sz,phone:_phone,mobile:_mobile,xh:_xh};
                if (!_isedit) {//add
                    $.ajax({
                        type: 'post',
                        url: 'addTeacher',
                        data: entity,
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
                } else {//edit
                    $.ajax({
                        type: 'post',
                        url: 'editTeacher',
                        data: entity,
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
            function searchUserByName(obj){
                if(($(".autocompleteResult").css("display")=="block" && (event.keyCode==40 || event.keyCode==38)) || event.keyCode==13) return;
                $("#txtPid").val("");
                $("#txtUserSex").val("");
                var _prev = $(obj).attr("prev");
                $(obj).val($(obj).val().trim());
                var _name = $(obj).val();
                if(_name!=_prev && /^[\u4e00-\u9fa5]+$/.test(_name) && _name.length>=2){
                    $(obj).attr("prev",_name);
                    $.ajax({
                        type: 'get',
                        url: '../specialjob/getUser',
                        data: {name:_name,iszjcuser: _iszjcuser},
                        dataType: "json",
                        success: function (r) {
                            if(r.rows.length>0){
                                var _html="<ul>";
                                for (var i = 0; i < r.rows.length; i++) {
                                    _html+="<li onmouseover='setClass(this)' uid='"+r.rows[i].username+"' uname='"+r.rows[i].workername+"' usex='"+r.rows[i].sex+"' onclick='selectUser(this)'>[ "+r.rows[i].company+" ] "+r.rows[i].workername+" ( "+r.rows[i].username+" )"+"</li>";
                                }
                                _html+="</ul>";
                                $(".autocompleteResult").html(_html);
                                $(".autocompleteResult").show();
                            }
                        },
                        error: function () {
                            $.messager.alert("提示", "调用后台接口出错！", "alert");
                        }
                    });
                }
            }
            function setClass(obj){
                $(obj).siblings().removeClass("select");
                $(obj).addClass("select");
            }
            function selectUser(obj){
                $("#txtUserName").val($(obj).attr("uname"));
                $("#txtPid").val($(obj).attr("uid"));
                $("#txtUserSex").val($(obj).attr("usex"));
                $(".autocompleteResult").hide();
            }
            document.onkeydown=function(){
                if($(".autocompleteResult").css("display")=="block"){
                    if((event.keyCode==38 || event.keyCode==40)){
                        var selectLi;
                        if($(".autocompleteResult").find('.select').length==0){
                            if(event.keyCode==38) selectLi = $(".autocompleteResult li").last();
                            else if(event.keyCode==40) selectLi = $(".autocompleteResult li").first();
                        }
                        else{
                            if(event.keyCode==38) selectLi = $(".autocompleteResult").find('.select').prev();
                            else if(event.keyCode==40) selectLi = $(".autocompleteResult").find('.select').next();
                        }
                        setClass(selectLi)
                    }
                    else if(event.keyCode==13){
                        if($(".autocompleteResult").find('.select').length>0){
                            selectUser($(".autocompleteResult").find('.select'));
                        }
                    }
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
                <td class="leftTd">姓名：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" id="txtUserName" class="input" placeholder="姓名" data-validate="required:请填写职工姓名" onblur="ckeckValue(this);" onkeyup="searchUserByName(this)"/>
                            <div class="input autocompleteResult" style="display:none;">                                
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">身份证号：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtPid" disabled="disabled" placeholder="身份证号（选取用户后自动读取）"/>
                </td>
            </tr>
            <tr>
                <td class="leftTd">性别：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtUserSex" disabled="disabled" placeholder="性别（选取用户后自动读取）"/>
                </td>
            </tr>
            <tr>
                <td class="leftTd">办公电话：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtPhone"/>
                </td>
            </tr>
            <tr>
                <td class="leftTd">移动电话：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtMobel"/>
                </td>
            </tr>
            <tr>
                <td class="leftTd">继续教育日期：</td>
                <td class="rightTd">
                    <input class="easyui-datebox" id="dtJxjyDate">
                </td>
            </tr>
            <tr>
                <td class="leftTd">资格证书：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtCert"/>
                </td>
            </tr>
            <tr>
                <td class="leftTd">人员类型：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <!--<input class="easyui-combobox" data-options="valueField:'code',textField:'name',data:_teacherType" id="cbTeacherType">-->
                            <input type="checkbox" name="cbTeacherType" id="iszz" style="cursor:pointer;" /><label style="cursor:pointer;" for="iszz">职教专职人员</label>
                            <input type="checkbox" name="cbTeacherType" id="isjpjz" style="cursor:pointer;" /><label style="cursor:pointer;" for="isjpjz">局兼职教师</label>
                            <input type="checkbox" name="cbTeacherType" id="iszdjz" style="cursor:pointer;" /><label style="cursor:pointer;" for="iszdjz">站段兼职教师</label>
                        </div>
                    </div>
                </td>
            </tr>
<!--            <tr>
                <td class="leftTd">课程类型：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="txtSubject" placeholder="课程类型" data-validate="required:请填写课程类型" onblur="ckeckValue(this);"/>
                        </div>
                    </div>
                </td>
            </tr>-->
            <tr>
                <td class="leftTd">专职人员从教日期：</td>
                <td class="rightTd">
                    <input class="easyui-datebox" id="dtEduDate">
                </td>
            </tr>
            <tr>
                <td class="leftTd">兼职教师聘用日期：</td>
                <td class="rightTd">
                    <input class="easyui-datebox" id="dtHireDate">
                </td>
            </tr>
            <tr>
                <td class="leftTd">专业：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtProf"/>
                </td>
            </tr>
            <tr>
                <td class="leftTd">理论：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtLl"/>
                </td>
            </tr>
            <tr>
                <td class="leftTd">实作：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtSz"/>
                </td>
            </tr>
            <tr>
                <td class="leftTd">执教经历：</td>
                <td class="rightTd">
                    <textarea class="input" id="txtZjjl" style="height: 50px;"></textarea>
                </td>
            </tr>
            <tr>
                <td class="leftTd">备注：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtMemo"/>
                </td>
            </tr>
            <tr>
                <td class="leftTd">序号：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtXh"/>
                </td>
            </tr>
        </table>
    </body>
</html>
