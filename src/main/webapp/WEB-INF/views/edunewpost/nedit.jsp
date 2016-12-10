<%-- 
    Document   : nedit
    Created on : 2016-10-18, 11:22:17
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
                $("#pxlb").combobox("select","新职");
                $("#pxxs").combobox("select","脱产");
                var _soon = GetQueryString("soon");
                if (_soon != null && _soon != "") {
                    bindEditData(_soon,true);
                }
                
                var _id = GetQueryString("id");
                if (_id != null && _id != "") {
                    _isedit = true;
                    bindEditData(_id,false);
                }
            });
            function bindEditData(id,issoon){
                $.ajax({
                    type: 'get',
                    url: 'getDataById',
                    data: {id:id},
                    dataType: "json",
                    success: function (r) {
                        if (r.result) {
                            _editData = r.rows;
                            if(!issoon){
                                $("#txtPid").val(_editData.userpid);
                                $("#txtUserName").val(_editData.username);
                                $("#txtSex").val(_editData.usersex);
                                $("#txtXl").val(_editData.usereduback);
                            }
                            $("#workshop").val(_editData.workshop);
                            $("#bz").val(_editData.bz);
                            $("#old_post").val(_editData.old_post);
                            $("#new_post").val(_editData.new_post);
                            $("#pxlb").combobox("setValue",_editData.pxlb);
                            $("#pxxs").combobox("setValue",_editData.pxxs);
                            $("#study_no").val(_editData.study_no);
                            $("#study_date").datebox('setValue',_editData.study_date);
                            $("#aq_begindate").datebox('setValue',_editData.aq_begindate);
                            $("#aq_enddate").datebox('setValue',_editData.aq_enddate);
                            $("#aq_classno").val(_editData.aq_classno);
                            $("#aq_address").val(_editData.aq_address);
                            $("#aq_study_hour").val(_editData.aq_study_hour);
                            $("#aq_cj").val(_editData.aq_cj);
                            $("#aq_khyj").val(_editData.aq_khyj);
                            $("#aq_fzr").val(_editData.aq_fzr);
                            $("#aq_sj_url").val(_editData.aq_sj_url);
                            $("#aq_cj_cj").val(_editData.aq_cj_cj);
                            $("#aq_cj_fzr").val(_editData.aq_cj_fzr);
                            $("#aq_cj_khyj").val(_editData.aq_cj_khyj);
                            $("#aq_bz_cj").val(_editData.aq_bz_cj);
                            $("#aq_bz_fzr").val(_editData.aq_bz_fzr);
                            $("#aq_bz_khyj").val(_editData.aq_bz_khyj);
                            $("#ll_begindate").datebox('setValue',_editData.ll_begindate);
                            $("#ll_enddate").datebox('setValue',_editData.ll_enddate);
                            $("#ll_classno").val(_editData.ll_classno);
                            $("#ll_address").val(_editData.ll_address);
                            $("#ll_study_hour").val(_editData.ll_study_hour);
                            $("#ll_cj").val(_editData.ll_cj);
                            $("#ll_sj_url").val(_editData.ll_sj_url);
                            $("#sz_pactno").val(_editData.sz_pactno);
                            $("#sz_begindate").datebox('setValue',_editData.sz_begindate);
                            $("#sz_enddate").datebox('setValue',_editData.sz_enddate);
                            $("#sz_teacher_name").val(_editData.sz_teacher_name);
                            $("#sz_address").val(_editData.sz_address);
                            $("#sz_study_hour").val(_editData.sz_study_hour);
                            $("#sz_cj").val(_editData.sz_cj);
                            $("#sz_sj_url").val(_editData.sz_sj_url);
                            $("#fzdw").val(_editData.fzdw);
                            $("#fzrq").datebox('setValue',_editData.fzrq);
                            $("#dzl_no").val(_editData.dzl_no);
                            $("#dzl_date").datebox('setValue',_editData.dzl_date);
                            $("input:radio[name=isgt][value=" + _editData.crh + "]").attr("checked", true);
                            if(!issoon){
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
                        }
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "alert");
                    }
                });
            }
            function saveDataClick(){
                var _ll_cj = $("#ll_cj").val();
                var _sz_cj = $("#sz_cj").val();
                var _aq_enddate = $("#aq_enddate").datebox('getValue');
                var _ll_begindate = $("#ll_begindate").datebox('getValue');
                var _ll_enddate = $("#ll_enddate").datebox('getValue');
                var _ll_study_hour = $("#ll_study_hour").val();
                var _sz_begindate = $("#sz_begindate").datebox('getValue');
                var _sz_enddate = $("#sz_enddate").datebox('getValue');
                var _sz_study_hour = $("#sz_study_hour").val();
                var _fzdw = $("#fzdw").val();
                var _fzrq = $("#fzrq").datebox('getValue');
                var _dzl_no = $("#dzl_no").val();
                var _dzl_date = $("#dzl_date").datebox('getValue');
                
                if(_ll_cj!="" || _fzdw!="" || _fzrq!="") { 
                    if(_ll_cj<80){showErrInfo($("#ll_cj"),"必须达到80分"); return; }
                    if(_ll_begindate==""){showErrInfo($("#ll_begindate"),"请选择开始日期"); return; }
                    if(_ll_enddate==""){showErrInfo($("#ll_enddate"),"请选择结束日期"); return; }
                    if(_ll_study_hour==""){showErrInfo($("#ll_study_hour"),"请输入学时"); return; }
                }else{
                    clearErrInfo($("#ll_begindate"));
                    clearErrInfo($("#ll_enddate"));
                    clearErrInfo($("#ll_study_hour"));
                    clearErrInfo($("#ll_cj"));
                }
                if(_sz_cj!="" || _fzdw!="" || _fzrq!="") { 
                    if(_sz_cj<80){showErrInfo($("#sz_cj"),"必须达到80分"); return; }
                    if(_sz_begindate==""){showErrInfo($("#sz_begindate"),"请选择开始日期"); return; }
                    if(_sz_enddate==""){showErrInfo($("#sz_enddate"),"请选择结束日期"); return; }
                    if(_sz_study_hour==""){showErrInfo($("#sz_study_hour"),"请输入学时"); return; }
                }else{
                    clearErrInfo($("#sz_begindate"));
                    clearErrInfo($("#sz_enddate"));
                    clearErrInfo($("#sz_study_hour"));
                    clearErrInfo($("#sz_cj"));
                }
                if(_fzdw!="" || _fzrq!="") { 
                    if(_fzdw==""){showErrInfo($("#fzdw"),"请输入发证单位"); return; }
                    else clearErrInfo($("#fzdw"));
                    if(_fzrq<_aq_enddate || _fzrq<_ll_enddate || _fzrq<_sz_enddate) { showErrInfo($("#fzrq"),"发证日期不能早于培训结束日期"); return; }
                    else clearErrInfo($("#fzrq"));
                }
                if(_dzl_no!="" || _dzl_date!="") { 
                    if(_dzl_no==""){showErrInfo($("#dzl_no"),"请输入定职令号"); return; }
                    else clearErrInfo($("#dzl_no"));
                    if(_dzl_date<_fzrq) { showErrInfo($("#dzl_date"),"下令日期不能早于发证日期"); return; }
                    else clearErrInfo($("#dzl_date"));
                }
                
                
                $('.datatable').find('input').trigger("blur");
                var numError = $('.datatable').find('.check-error').length;
                if (numError) {
                    $('.datatable').find('.check-error').first().find('input').first().focus().select();
                    return;
                }
              
                var _idcard = $("#txtPid").val(); 
                if(_idcard=="") { showErrInfo($("#txtUserName"),"职工表中未找到此职工"); return; }
                var _aq_cj = $("#aq_cj").val()==""?"0":$("#aq_cj").val();
                if(_aq_cj<90) { showErrInfo($("#aq_cj"),"必须达到90分"); return; }
                
//                var _aq_begindate = $("#aq_begindate").datebox('getValue');
//                var _aq_enddate = $("#aq_enddate").datebox('getValue');
//                var _ll_begindate = $("#ll_begindate").datebox('getValue');
//                var _ll_enddate = $("#ll_enddate").datebox('getValue');
//                var _sz_begindate = $("#sz_begindate").datebox('getValue');
//                var _sz_enddate = $("#sz_enddate").datebox('getValue');
//                var days = 0;
//                var d1 = new Date(_aq_begindate);
//                var d2 = new Date(_aq_enddate);
//                days += Math.abs(d2-d1)/1000/60/60/24;
//                d1 = new Date(_ll_begindate);
//                d2 = new Date(_ll_enddate);
//                days += Math.abs(d2-d1)/1000/60/60/24;
//                d1 = new Date(_sz_begindate);
//                d2 = new Date(_sz_enddate);
//                days += Math.abs(d2-d1)/1000/60/60/24;
//                if(days>360) { $.messager.alert("提示", "培训总天数不能大于360天！", "alert"); return; }
//                var _fzrq = $("#fzrq").datebox('getValue');
//                if(_fzrq<_aq_enddate || _fzrq<_ll_enddate || _fzrq<_sz_enddate) { showErrInfo($("#fzrq"),"发证日期不能早于培训结束日期"); return; }
//                var _dzl_date = $("#dzl_date").datebox('getValue');
//                if(_dzl_date<_fzrq) { showErrInfo($("#dzl_date"),"下令日期不能早于发证日期"); return; }
                
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
                var _username = $("#txtUserName").val(); entityData.username = _username;
                var _usersex = $("#txtSex").val(); entityData.usersex = _usersex;
                var _usereduback = $("#txtXl").val(); entityData.usereduback = _usereduback;
                var _userpid = $("#txtPid").val(); entityData.userpid = _userpid;
                var _workshop = $("#workshop").val(); entityData.workshop = _workshop;
                var _bz = $("#bz").val(); entityData.bz = _bz;
                var _old_post = $("#old_post").val(); entityData.old_post = _old_post;
                var _new_post = $("#new_post").val(); entityData.new_post = _new_post;
                var _pxlb = $("#pxlb").combobox("getValue"); entityData.pxlb = _pxlb;
                var _pxxs = $("#pxxs").combobox("getValue"); entityData.pxxs = _pxxs;
                var _crh = $("input[name=isgt]:checked").attr("value");entityData.crh = _crh;
                var _study_no = $("#study_no").val(); entityData.study_no = _study_no;
                var _study_date = $("#study_date").datebox('getValue'); entityData.study_date = _study_date;
                var _aq_begindate = $("#aq_begindate").datebox('getValue'); entityData.aq_begindate = _aq_begindate;
                var _aq_enddate = $("#aq_enddate").datebox('getValue'); entityData.aq_enddate = _aq_enddate;
                var _aq_classno = $("#aq_classno").val(); entityData.aq_classno = _aq_classno;
                var _aq_address = $("#aq_address").val(); entityData.aq_address = _aq_address;
                var _aq_study_hour = $("#aq_study_hour").val(); entityData.aq_study_hour = _aq_study_hour;
                var _aq_cj = $("#aq_cj").val(); entityData.aq_cj = _aq_cj;
                var _aq_khyj = $("#aq_khyj").val(); entityData.aq_khyj = _aq_khyj;
                var _aq_fzr = $("#aq_fzr").val(); entityData.aq_fzr = _aq_fzr;
                var _aq_sj_url = $("#aq_sj_url").val(); entityData.aq_sj_url = _aq_sj_url;
                var _aq_cj_cj = $("#aq_cj_cj").val(); entityData.aq_cj_cj = _aq_cj_cj;
                var _aq_cj_fzr = $("#aq_cj_fzr").val(); entityData.aq_cj_fzr = _aq_cj_fzr;
                var _aq_cj_khyj = $("#aq_cj_khyj").val(); entityData.aq_cj_khyj = _aq_cj_khyj;
                var _aq_bz_cj = $("#aq_bz_cj").val(); entityData.aq_bz_cj = _aq_bz_cj;
                var _aq_bz_fzr = $("#aq_bz_fzr").val(); entityData.aq_bz_fzr = _aq_bz_fzr;
                var _aq_bz_khyj = $("#aq_bz_khyj").val(); entityData.aq_bz_khyj = _aq_bz_khyj;
                var _ll_begindate = $("#ll_begindate").datebox('getValue'); entityData.ll_begindate = _ll_begindate;
                var _ll_enddate = $("#ll_enddate").datebox('getValue'); entityData.ll_enddate = _ll_enddate;
                var _ll_classno = $("#ll_classno").val(); entityData.ll_classno = _ll_classno;
                var _ll_address = $("#ll_address").val(); entityData.ll_address = _ll_address;
                var _ll_study_hour = $("#ll_study_hour").val(); entityData.ll_study_hour = _ll_study_hour;
                var _ll_cj = $("#ll_cj").val(); entityData.ll_cj = _ll_cj;
                var _ll_sj_url = $("#ll_sj_url").val(); entityData.ll_sj_url = _ll_sj_url;
                var _sz_pactno = $("#sz_pactno").val(); entityData.sz_pactno = _sz_pactno;
                var _sz_begindate = $("#sz_begindate").datebox('getValue'); entityData.sz_begindate = _sz_begindate;
                var _sz_enddate = $("#sz_enddate").datebox('getValue'); entityData.sz_enddate = _sz_enddate;
                var _sz_teacher_name = $("#sz_teacher_name").val(); entityData.sz_teacher_name = _sz_teacher_name;
                var _sz_address = $("#sz_address").val(); entityData.sz_address = _sz_address;
                var _sz_study_hour = $("#sz_study_hour").val(); entityData.sz_study_hour = _sz_study_hour;
                var _sz_cj = $("#sz_cj").val(); entityData.sz_cj = _sz_cj;
                var _sz_sj_url = $("#sz_sj_url").val(); entityData.sz_sj_url = _sz_sj_url;
                var _fzdw = $("#fzdw").val(); entityData.fzdw = _fzdw;
                var _fzrq = $("#fzrq").datebox('getValue'); entityData.fzrq = _fzrq;
                var _dzl_no = $("#dzl_no").val(); entityData.dzl_no = _dzl_no;
                var _dzl_date = $("#dzl_date").datebox('getValue'); entityData.dzl_date = _dzl_date;
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
                $("#txtSex").val("");
                $("#txtXl").val("");
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
                $("#txtSex").val($(obj).attr("usex"));
                $("#txtXl").val($(obj).attr("uxl"));
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
            var _eventClassType;
            function chooseClass(obj){
                _eventClassType = obj;
                var d1 = myformatter(new Date());
                $('#choose-dialog').dialog('open');
                $("#choose-dialog").panel("move",{top:$(document).scrollTop() + ($(window).height()-340) * 0.5});  
                $('#classqsrq').datebox('setValue',d1);
                var d2 = new Date(d1);
                d2.setMonth(d2.getMonth()+3);
                d2 = myformatter(d2);
                $('#classjsrq').datebox('setValue',d2);
                bindClass();
            }
            function myformatter(date){
                var y = date.getFullYear();  
                var m = date.getMonth()+1;  
                var d = date.getDate();  
                var str = y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);  
                return str;
            }
            function classrqChange(){
                var _begindate = $("#classqsrq").datebox('getValue');
                var _enddate = $("#classjsrq").datebox('getValue');
                if(_begindate > _enddate){
                    var d = new Date(_begindate);
                    d.setMonth(d.getMonth()+3);
                    d = myformatter(d);
                    $('#classjsrq').datebox('setValue',d);
                }
            }
            function bindClass(){
                var _pxlb=$("#pxlb").combobox("getValue");
                var _begindate = $("#classqsrq").datebox('getValue');
                var _enddate = $("#classjsrq").datebox('getValue');
                $.ajax({
                    type: 'get',
                    url: 'allClass',
                    data: {pxlb:_pxlb,begindate:_begindate,enddate:_enddate},
                    dataType: "json",
                    success: function (r) {
                        if(r.result){
                            $("#tt").datagrid("loadData", r);
                            if(r.rows && r.rows.length>0)
                                $("#tt").datagrid("selectRow", 0);
                        }
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "alert");
                    }
                });
            }
            function chooseClassClick(){
                var row = $("#tt").datagrid("getSelected");
                if(row){
                    clearErrInfo($("#"+_eventClassType+"_classno"));
                    $("#"+_eventClassType+"_classno").val(row.classno);
                    var bengindate = row.startdate==""?"":row.startdate.split(' ')[0];
                    var enddate = row.enddate==""?"":row.enddate.split(' ')[0];
                    $("#"+_eventClassType+"_begindate").datebox('setValue',bengindate);
                    $("#"+_eventClassType+"_enddate").datebox('setValue',enddate);
                }
                $('#choose-dialog').dialog('close');
            }
            function aqrqChange(){
                rqChange($("#aq_begindate"),$("#aq_enddate"));
            }
            function llrqChange(){
                rqChange($("#ll_begindate"),$("#ll_enddate"));
            }
            function szrqChange(){
                rqChange($("#sz_begindate"),$("#sz_enddate"));
            }
            function rqChange(beginObj,endObj){
                var _rljy_begindate = $(beginObj).datebox('getValue');
                if(_rljy_begindate!="") clearErrInfo($(beginObj));
                var _rljy_enddate = $(endObj).datebox('getValue');
                if(_rljy_enddate!="") clearErrInfo($(endObj));
                if(_rljy_begindate > _rljy_enddate) showErrInfo($(endObj),"结束日期必须大于起始日期");
                else clearErrInfo($(endObj));
            }
            function xxlrqChange(){
                clearErrInfo($("#study_date"));
            }
            function fzrqChange(){
                clearErrInfo($("#fzrq"));
            }
            function dzlrqChange(){
                clearErrInfo($("#dzl_date"));
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
                <td class="leftTd">性别：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtSex" placeholder="性别" />
                </td>
                <td class="leftTd">学历：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtXl" placeholder="学历" />
                </td>
            </tr>
            <tr>
                <td class="leftTd">车间：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="workshop" placeholder="车间" />
                </td>
                <td class="leftTd">班组：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="bz" placeholder="班组" />
                </td>
            </tr>
            <tr>
                <td class="leftTd">原职名：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="old_post" placeholder="原职名" />
                        </div>
                    </div>
                </td>
                <td class="leftTd">学习职名：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="new_post" placeholder="学习职名" data-validate="required:请填写学习职名" onblur="ckeckValue(this);" />
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">培训类别：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-combobox" style='width:100px;' data-options="valueField:'code',textField:'name',editable:false,data:[{code:'新职',name:'新职'},{code:'转岗',name:'转岗'},{code:'晋升',name:'晋升'}]" id="pxlb">
                        </div>
                    </div>
                </td>
                <td class="leftTd">培训形式：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-combobox" style='width:100px;' data-options="valueField:'code',textField:'name',editable:false,data:[{code:'脱产',name:'脱产'},{code:'半脱产',name:'半脱产'},{code:'师带徒',name:'师带徒'}]" id="pxxs">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">是否高铁：</td>
                <td class="rightTd" colspan="3">
                    <input class="pointer" name="isgt" value="1" id="isgt_1" type="radio" checked="checked"/><label class="pointer" for="isgt_1">是</label>
                    <input class="pointer" name="isgt" value="0" id="isgt_0" type="radio"/><label class="pointer" for="isgt_0">否</label>
                </td>
            </tr>
            <tr>
                <td class="leftTd">学习令号：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="study_no" placeholder="学习令号" data-validate="required:请填写学习令号"  onblur="ckeckValue(this);" />
                        </div>
                    </div>
                </td>
                <td class="leftTd">下令日期：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-datebox" data-options="prompt:'下令日期',onChange:xxlrqChange" style='width:100px;' id="study_date" data-validate="required:请选择下令日期" onblur="ckeckDateValue(this);">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class='rightTd' style='text-align: center;padding: 8px;' colspan="4">安全（入路）培训</td>
            </tr>
            <tr>
                <td class="leftTd">培训班号：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input pointer" id="aq_classno" placeholder="培训班编号(点击选择)" onclick="chooseClass('aq')"/>
                        </div>
                    </div>
                </td>
                <td class="leftTd">培训地点：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="aq_address" placeholder="培训地点"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">开始日期：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-datebox" data-options="prompt:'开始日期',onChange:aqrqChange" style='width:100px;' id="aq_begindate" data-validate="required:请选择开始日期" onblur="ckeckDateValue(this);">
                        </div>
                    </div>
                </td>
                <td class="leftTd">结束日期：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-datebox" data-options="prompt:'结束日期',onChange:aqrqChange" style='width:100px;' id="aq_enddate" data-validate="required:请选择结束日期" onblur="ckeckDateValue(this);">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">学时：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="aq_study_hour" data-validate="required:请填写学时,double:只能输入数字" onblur="ckeckValue(this);" placeholder="学时"/>
                        </div>
                    </div>
                </td>
                <td class="leftTd">成绩：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="aq_cj" data-validate="required:请填写成绩,double:只能输入数字" onblur="ckeckValue(this);" placeholder="成绩"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">考核意见：</td>
                <td class="rightTd" colspan="3">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="aq_khyj" data-validate="length#<=400:最多只能输入200个汉字或者400个非汉字" onblur="ckeckValue(this);" placeholder="考核意见"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">负责人：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="aq_fzr" placeholder="负责人"/>
                        </div>
                    </div>
                </td>
                <td class="leftTd">试卷URL：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="aq_sj_url" data-validate="url:输入格式不正确(http://*.*.*)" onblur="ckeckValue(this);" placeholder="试卷URL"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">车间成绩：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="aq_cj_cj" data-validate="double:只能输入数字" onblur="ckeckValue(this);" placeholder="车间成绩"/>
                        </div>
                    </div>
                </td>
                <td class="leftTd">负责人：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="aq_cj_fzr" placeholder="车间负责人"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">考核意见：</td>
                <td class="rightTd" colspan="3">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="aq_cj_khyj" data-validate="length#<=400:最多只能输入200个汉字或者400个非汉字" onblur="ckeckValue(this);" placeholder="车间考核意见"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">班组成绩：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="aq_bz_cj" data-validate="double:只能输入数字" onblur="ckeckValue(this);" placeholder="班组成绩"/>
                        </div>
                    </div>
                </td>
                <td class="leftTd">负责人：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="aq_bz_fzr" placeholder="班组负责人"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">考核意见：</td>
                <td class="rightTd" colspan="3">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="aq_bz_khyj" data-validate="length#<=400:最多只能输入200个汉字或者400个非汉字" onblur="ckeckValue(this);" placeholder="班组考核意见"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class='rightTd' style='text-align: center;padding: 8px;' colspan="4">理论培训</td>
            </tr>
            <tr>
                <td class="leftTd">培训班号：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input pointer" id="ll_classno" placeholder="培训班编号(点击选择)" onclick="chooseClass('ll')"/>
                        </div>
                    </div>
                </td>
                <td class="leftTd">培训地点：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="ll_address" placeholder="培训地点"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">开始日期：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-datebox" data-options="prompt:'开始日期',onChange:llrqChange" style='width:100px;' id="ll_begindate">
                        </div>
                    </div>
                </td>
                <td class="leftTd">结束日期：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-datebox" data-options="prompt:'结束日期',onChange:llrqChange" style='width:100px;' id="ll_enddate">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">学时：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="ll_study_hour" data-validate="double:只能输入数字" onblur="ckeckValue(this);" placeholder="学时"/>
                        </div>
                    </div>
                </td>
                <td class="leftTd">成绩：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="ll_cj" data-validate="double:只能输入数字" onblur="ckeckValue(this);" placeholder="成绩"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">试卷URL：</td>
                <td class="rightTd" colspan="3">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="ll_sj_url" data-validate="url:输入格式不正确(http://*.*.*)" onblur="ckeckValue(this);" placeholder="试卷URL"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class='rightTd' style='text-align: center;padding: 8px;' colspan="4">实作培训</td>
            </tr>
            <tr>
                <td class="leftTd">合同编号：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="sz_pactno" placeholder="合同编号"/>
                        </div>
                    </div>
                </td>
                <td class="leftTd">培训地点：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="sz_address" placeholder="培训地点"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">开始日期：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-datebox" data-options="prompt:'开始日期',onChange:szrqChange" style='width:100px;' id="sz_begindate">
                        </div>
                    </div>
                </td>
                <td class="leftTd">结束日期：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-datebox" data-options="prompt:'结束日期',onChange:szrqChange" style='width:100px;' id="sz_enddate">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">学时：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="sz_study_hour" data-validate="double:只能输入数字" onblur="ckeckValue(this);" placeholder="学时"/>
                        </div>
                    </div>
                </td>
                <td class="leftTd">成绩：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="sz_cj" data-validate="double:只能输入数字" onblur="ckeckValue(this);" placeholder="成绩"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">师傅姓名：</td>
                <td class="rightTd" colspan="3">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="sz_teacher_name" placeholder="师傅姓名"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">试卷URL：</td>
                <td class="rightTd" colspan="3">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="sz_sj_url" data-validate="url:输入格式不正确(http://*.*.*)" onblur="ckeckValue(this);" placeholder="试卷URL"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class='rightTd' style='text-align: center;padding: 8px;' colspan="4">发证与定职</td>
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
                            <input class="easyui-datebox" data-options="prompt:'发证日期',onChange:fzrqChange" style='width:100px;' id="fzrq">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">定职令号：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="dzl_no" placeholder="定职令号"/>
                        </div>
                    </div>
                </td>
                <td class="leftTd">下令日期：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-datebox" data-options="prompt:'下令日期',onChange:dzlrqChange" style='width:100px;' id="dzl_date">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class='rightTd' style='text-align: center;padding: 8px;' colspan="4">附件信息（新转晋审批程序表、三级安全教育、师徒合同、试卷等）[备注：多文件请打包上传]</td>
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
        
        
        <div id="choose-dialog" class="easyui-dialog" title="培训班选择(最多只读取20条数据)" data-options="closed:true,iconCls:'icon-save',buttons: '#choose-dlg-buttons'" style="width:620px;height:340px;">
            <table id="tt" class="easyui-datagrid" data-options="
                   rownumbers:true,
                   fit:true,
                   singleSelect:true,
                   idField:'id',
                   toolbar:'#menuTollbar'">
                <thead>
                    <tr>
                        <th data-options="field:'classno'">培训班编号</th>
                        <th data-options="field:'classname'">培训班名称</th>
                        <th data-options="field:'studentscope'">培训对象</th>
                        <th data-options="field:'classlevel'">培训等级</th>
                        <th data-options="field:'prof'">培训专业</th>
                        <th data-options="field:'startdate'">开始日期</th>
                        <th data-options="field:'enddate'">结束日期</th>
                    </tr>
                </thead>
            </table>
            <div id="menuTollbar" style="height: auto;">
                培训班开始时间范围赛选：
                <input class="easyui-datebox" data-options="onChange:classrqChange" style='width:100px;' id="classqsrq">
                --
                <input class="easyui-datebox" data-options="onChange:classrqChange" style='width:100px;' id="classjsrq">
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-s-search'" onclick="bindClass()">查询</a>
            </div>
        </div>
        <div id="choose-dlg-buttons">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="chooseClassClick();">确认</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-no'" onclick="$('#choose-dialog').dialog('close');">关闭</a>
        </div>
    </body>
</html>
