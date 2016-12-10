<%-- 
    Document   : edit
    Created on : 2016-11-4, 14:59:17
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
            .pointer {
                cursor: pointer;
            }
            table.datatable td {
                padding: 0px;
            }
            .input{border:none;}
        </style>
        <script>
            var _iszjcuser = true;
            var _isedit = false;
            var _editData;
            var oldfilepath="";
            $(function(){
                anticsrf();
                _iszjcuser = ${iszjcuser};
                var token = $("meta[name='_csrf']").attr("content");
                var header = $("meta[name='_csrf_header']").attr("content");
                $('#upload').uploadify({
                    swf: '../s/js/uploadify/uploadify.swf',
                    uploader: 'UploadFile?_csrf=' + token + '&_csrf_header=' + header,
                    queueID: 'filelist',
                    buttonText: '选择文件',
                    queueSizeLimit:1,
                    auto: false,
                    fileTypeExts:'*.pdf',
                    multi: false,
                    onUploadSuccess: function (file, data, response) {
                        var r = eval("[" + data + "]")[0];
                        $(".messager-icon").hide();
                        if (r.result) {
                            saveDataInfo(r.info);
                        }else{
                            $.messager.alert("提示", r.info, "info");
                        }
                    },
                    onSelectError: function (file, errorCode, errorMsg) { 
                        if(errorCode==-100)
                            this.queueData.errorMsg='只能添加一個文件';
                    }
                });
                var _id = GetQueryString("id");
                if (_id != null && _id != "") {
                    _isedit = true;
                    $("#txtUserName").attr("disabled","disabled");
                    bindEditData(_id,false);
                }
            });
            function bindEditData(id){
                $.ajax({
                    type: 'get',
                    url: 'getDataById',
                    data: {id:id},
                    dataType: "json",
                    success: function (r) {
                        if (r.result) {
                            _editData = r.rows;
                            $("#txtPid").val(_editData.userpid);
                            $("#txtUserName").val(_editData.username);
                            $("#begindate").datebox('setValue',_editData.begindate);
                            $("#enddate").datebox('setValue',_editData.enddate);
                            $("#memo").val(_editData.memo);
                            $("#classno").val(_editData.classno);
                            $("#address").val(_editData.address);
                            $("#study_hour").val(_editData.study_hour);
                            $("#cj").val(_editData.cj);
                            $("#fzdw").val(_editData.fzdw);
                            $("#fzdate").datebox('setValue',_editData.fzdate);
                            $("#dzlh").val(_editData.dzlh);
                            $("#dzldate").datebox('setValue',_editData.dzldate);
                            $("#sjurl").val(_editData.sjurl);
                            if(_editData.filepath!=""){
                                oldfilepath = _editData.filepath;
                                var html = '<div class="uploadify-queue-item"><a href="@url">@filename</a></div>';
                                html = html.replace(/@url/g,_editData.filepath);
                                var strFileName=_editData.filepath.substring(_editData.filepath.lastIndexOf("/")+1);
                                html = html.replace(/@filename/g,strFileName);
                                $("#upfilelist").html(html);
                                $(".editElem").show();
                            }else{
                                $(".editElem").hide();
                            }
                        }
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "alert");
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
              
                var _idcard = $("#txtPid").val(); 
                if(_idcard=="") { showErrInfo($("#txtUserName"),"职工表中未找到此职工"); return; }
                var _cj = $("#cj").val()==""?"0":$("#cj").val();
                if(_cj<80) { showErrInfo($("#cj"),"必须达到80分"); return; }
                
                if ($("#filelist").children().length > 0) {
                    var path = Guid.NewGuid().ToString();
                    var has=false;
                    if(_isedit && oldfilepath!=""){
                        path=oldfilepath;
                        has = true;
                    }
                    $('#upload').uploadify("settings", "formData", {filepath: path,isedit:has});
                    $('#upload').uploadify("upload", "*");
                } else {//未选择文件上传
                    saveDataInfo("");
                }
            }
            function saveDataInfo(filepath){
                var entityData={};
                var _userpid = $("#txtPid").val(); entityData.userpid = _userpid;
                var _begindate = $("#begindate").datebox('getValue'); entityData.begindate = _begindate;
                var _enddate = $("#enddate").datebox('getValue'); entityData.enddate = _enddate;
                var _memo = $("#memo").val(); entityData.memo = _memo;
                var _classno = $("#classno").val(); entityData.classno = _classno;
                var _address = $("#address").val(); entityData.address = _address;
                var _study_hour = $("#study_hour").val(); entityData.study_hour = _study_hour;
                var _cj = $("#cj").val(); entityData.cj = _cj;
                var _sjurl = $("#sjurl").val(); entityData.sjurl = _sjurl;
                var _fzdw = $("#fzdw").val(); entityData.fzdw = _fzdw;
                var _fzdate = $("#fzdate").datebox('getValue'); entityData.fzdate = _fzdate;
                var _dzlh = $("#dzlh").val(); entityData.dzlh = _dzlh;
                var _dzldate = $("#dzldate").datebox('getValue'); entityData.dzldate = _dzldate;
                if(_isedit && filepath==""){
                    entityData.filepath=oldfilepath;
                }else{
                    entityData.filepath=filepath;
                }
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
            function searchUserByName(obj){
                if(($(".autocompleteResult").css("display")=="block" && (event.keyCode==40 || event.keyCode==38)) || event.keyCode==13) return;
                $("#txtPid").val("");
                var _prev = $(obj).attr("prev");
                $(obj).val($(obj).val().trim());
                var _name = $(obj).val();
                if(_name!=_prev && /^[\u4e00-\u9fa5]+$/.test(_name) && _name.length>=2){
                    $(obj).attr("prev",_name);
                    $.ajax({
                        type: 'get',
                        url: '../specialjob/getUser',
                        data: {name:_name,iszjcuser: false},
                        dataType: "json",
                        success: function (r) {
                            if(r.rows.length>0){
                                var _html="<ul>";
                                for (var i = 0; i < r.rows.length; i++) {
                                    _html+="<li onmouseover='setClass(this)' uxl='"+r.rows[i].xl+"' uid='"+r.rows[i].username+"' uname='"+r.rows[i].workername+"' usex='"+r.rows[i].sex+"' onclick='selectUser(this)'>[ "+r.rows[i].company+" ] "+r.rows[i].workername+" ( "+r.rows[i].username+" )"+"</li>";
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
            function ckeckDateValue(obj){
                var e = $(obj);
                if (e.attr("data-validate")) {
                    e.closest('.field').find(".input-help").remove();
                    var $checkdata = e.attr("data-validate").split(',');
                    var $checkvalue = e.datebox('getValue');
                    var $checkstate = true;
                    var $checktext = "";
                    if (e.attr("placeholder") == $checkvalue) {
                        $checkvalue = "";
                    }
                    if ($checkvalue != "" || e.attr("data-validate").indexOf("required") >= 0) {
                        for (var i = 0; i < $checkdata.length; i++) {
                            var $checktype = $checkdata[i].split(':');
                            if (!$pintuercheck(e, $checktype[0], $checkvalue)) {
                                $checkstate = false;
                                $checktext = $checktext + "<li>" + $checktype[1] + "</li>";
                            }
                        }
                    }
                    if ($checkstate) {
                        e.closest('.form-group').removeClass("check-error");
                        e.parent().find(".input-help").remove();
                        e.closest('.form-group').addClass("check-success");
                    } else {
                        e.closest('.form-group').removeClass("check-success");
                        e.closest('.form-group').addClass("check-error");
                        e.closest('.field').append('<div class="input-help"><ul>' + $checktext + '</ul></div>');
                    }
                }
            }
            function pxrqChange(){
                rqChange($("#begindate"),$("#enddate"));
            }
            function rqChange(beginObj,endObj){
                var _rljy_begindate = $(beginObj).datebox('getValue');
                if(_rljy_begindate!="") clearErrInfo($(beginObj));
                var _rljy_enddate = $(endObj).datebox('getValue');
                if(_rljy_enddate!="") clearErrInfo($(endObj));
                if(_rljy_begindate > _rljy_enddate) showErrInfo($(endObj),"结束日期必须大于起始日期");
                else clearErrInfo($(endObj));
            }
        </script>
    </head>
    <body>
        <table class="datatable" id="optiontable" style="position:fixed;top:0px;left:0px;z-index:99999;background-color:#fff;">
            <tr>
                <td class="rightTd" style="text-align:left;">
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveDataClick()">确定</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-no'" onclick="parent.$('#edit-window').window('close')">关闭</a>
                </td>
            </tr>
        </table>
        <table class="datatable" id="contenttable" style="margin-top:27px">
            <tr>
                <td class="leftTd">姓名：</td>
                <td class="rightTd" colspan="3">
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
                <td class="rightTd" colspan="3">
                    <input type="text" class="input" id="txtPid" disabled="disabled" placeholder="身份证号（选取用户后自动读取）"/>
                </td>
            </tr>
            <tr>
                <td class="leftTd">培训班号：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="classno" placeholder="培训班编号"/>
                        </div>
                    </div>
                </td>
                <td class="leftTd">培训地点：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="address" placeholder="培训地点"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">开始日期：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-datebox" data-options="prompt:'开始日期',onChange:pxrqChange" style='width:100px;' id="begindate" data-validate="required:请选择开始日期" onblur="ckeckDateValue(this);">
                        </div>
                    </div>
                </td>
                <td class="leftTd">结束日期：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-datebox" data-options="prompt:'结束日期',onChange:pxrqChange" style='width:100px;' id="enddate" data-validate="required:请选择结束日期" onblur="ckeckDateValue(this);">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">学时：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="study_hour" data-validate="required:请填写学时,double:只能输入数字" onblur="ckeckValue(this);" placeholder="学时"/>
                        </div>
                    </div>
                </td>
                <td class="leftTd">成绩：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="cj" data-validate="required:请填写成绩,double:只能输入数字" onblur="ckeckValue(this);" placeholder="成绩"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">发证单位：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="fzdw" placeholder="发证单位"/>
                        </div>
                    </div>
                </td>
                <td class="leftTd">发证日期：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-datebox" data-options="prompt:'发证日期'" style='width:100px;' id="fzdate">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">定职令号：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="dzlh" placeholder="定职令号"/>
                        </div>
                    </div>
                </td>
                <td class="leftTd">下令日期：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-datebox" data-options="prompt:'下令日期'" style='width:100px;' id="dzldate">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">试卷URL：</td>
                <td class="rightTd" colspan="3">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="sjurl" data-validate="url:输入格式不正确(http://*.*.*)" onblur="ckeckValue(this);" placeholder="试卷URL"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">备注：</td>
                <td class="rightTd" colspan="3">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="memo" placeholder="备注"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class='rightTd' style='text-align: center;padding: 8px;' colspan="4">附件信息[备注：多文件请打包上传]</td>
            </tr>
            <tr>
                <td class="leftTd">附件：</td>
                <td class="rightTd" colspan="3">
                    <input id="upload" />
                    <div id="filelist"></div>
                </td>
            </tr>
            <tr class="editElem" style="display:none;">
                <td class="leftTd">已上传附件：</td>
                <td class="rightTd" colspan="3">
                    <div id="upfilelist">
                        
                    </div>
                    <div>备注：已经上传了附件，再次上传将会覆盖现有文件！！！</div>
                </td>
            </tr>
        </table>
    </body>
</html>
