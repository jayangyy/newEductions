<%-- 
    Document   : edit
    Created on : 2016-8-1, 16:51:24
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
            var _iszjcuser=false;
            $(function () {
                anticsrf();
                _iszjcuser = ${iszjcuser};
                var  _pid = GetQueryString("pid");
                if (_pid != null && _pid != "")
                    _isedit = true;
                if (_isedit) {
                    bindEditData(_pid);
                }
            });
            
            function bindEditData(_pid) {
                $.ajax({
                    type: 'get',
                    url: 'card/' + _pid,
                    data: {},
                    dataType: "json",
                    async: false,
                    success: function (r) {
                        if (r.result) {
                            _editData = r.rows;
                            $("#txtUserName").attr("disabled","disabled");
                            $("#txtPid").val(_editData.pid);
                            $("#txtUserName").val(_editData.name);
                            $("#txtUserSex").val(_editData.sex);
                            $("#txtCardNo").val(_editData.card_no);
                            $("#txtArchivesNo").val(_editData.archives_no);
                            $("#txtAwardUnit").val(_editData.award_unit);
                        } else
                            $.messager.alert("提示", r.info, "alert");
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "alert");
                    }
                });
            }
            function saveCardClick() {
                $('.datatable').find('input').trigger("blur");
                var numError = $('.datatable').find('.check-error').length;
                if (numError) {
                    $('.datatable').find('.check-error').first().find('input').first().focus().select();
                    return;
                }
                var _pidno = $("#txtPid").val();
                if(_pidno==""){showPidErrInfo();return;}
                var _name = $("#txtUserName").val();
                var _sex = $("#txtUserSex").val();
                var _cardno = $("#txtCardNo").val();
                var _archives_no = $("#txtArchivesNo").val();
                var _award_unit = $("#txtAwardUnit").val();
                var cardEntity = {pid:_pidno,name:_name,sex:_sex,card_no:_cardno,archives_no:_archives_no,award_unit:_award_unit};
                if(!_isedit){//add
                    $.ajax({
                        type: 'post',
                        url: 'addCard',
                        data: cardEntity,
                        dataType: "json",
                        success: function (r) {
                            $.messager.alert("提示", r.info, "alert");
                            if (r.result) {
                                parent.bindData();
                                parent.$('#card-window').window('close');
                            }
                        },
                        error: function () {
                            $.messager.alert("提示", "调用后台接口出错！", "alert");
                        }
                    });
                }else{//edit
                    $.ajax({
                        type: 'post',
                        url: 'card',
                        data: cardEntity,
                        dataType: "json",
                        success: function (r) {
                            $.messager.alert("提示", r.info, "alert");
                            if (r.result) {
                                parent.bindData();
                                parent.$('#card-window').window('close');
                            }
                        },
                        error: function () {
                            $.messager.alert("提示", "调用后台接口出错！", "alert");
                        }
                    });
                }
            }
            function showPidErrInfo(){
                $("#txtUserName").closest('.form-group').removeClass("check-success");
                $("#txtUserName").closest('.form-group').addClass("check-error");
                $("#txtUserName").closest('.field').append('<div class="input-help"><ul><li>职工表中未找到本单位此职工</li></ul></div>');
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
                        async: false,
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
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveCardClick()">确定</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-no'" onclick="parent.$('#card-window').window('close')">关闭</a>
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
                <td class="leftTd">证件编号：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="txtCardNo" placeholder="证件编号" data-validate="required:请填写证件编号" onblur="ckeckValue(this);"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">档案编号：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="txtArchivesNo" placeholder="档案编号" data-validate="required:请填写档案编号" onblur="ckeckValue(this);"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">发证机关：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="txtAwardUnit" placeholder="发证机关" data-validate="required:请填写发证机关" onblur="ckeckValue(this);"/>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </body>
</html>
