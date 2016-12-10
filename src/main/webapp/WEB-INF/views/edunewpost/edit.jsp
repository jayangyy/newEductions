<%-- 
    Document   : edit
    Created on : 2016-9-30, 9:55:55
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
            .leftTd{width:85px;}
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
                $("#cbpxlb").combobox("select","新职");
                $("#cbpxxs").combobox("select","送外");
                var _id = GetQueryString("id");
                var _view = GetQueryString("view");
                if(_view!=null && _view!=""){
                    $("#optiontable").hide();
                    $("#contenttable").css("margin-top","0px");
                    $("input").attr("disabled","disabled");
                    _id = _view;
                }
                if (_id != null && _id != "") {
                    _isedit = true;
                    bindEditData(_id);
                }
            });
            function saveDataClick(){
                $('.datatable').find('input').trigger("blur");
                var numError = $('.datatable').find('.check-error').length;
                if (numError) {
                    $('.datatable').find('.check-error').first().find('input').first().focus().select();
                    return;
                }
                var _idcard = $("#txtPid").val(); 
                if(_idcard==""){showErrInfo($("#txtUserName"),"职工表中未找到此职工");return;}
                var _dzkscj_aq = $("#kscjaq").val()==""?"0":$("#kscjaq").val();
                var _dzkscj_ll = $("#kscjll").val()==""?"0":$("#kscjll").val();
                var _dzkscj_sz = $("#kscjsz").val()==""?"0":$("#kscjsz").val();
                if(_dzkscj_aq<90){showErrInfo($("#kscjaq"),"必须达到90分");return;}
                if(_dzkscj_ll<80){showErrInfo($("#kscjll"),"必须达到80分");return;}
                if(_dzkscj_sz<80){showErrInfo($("#kscjsz"),"必须达到80分");return;}
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
                var _idcard = $("#txtPid").val(); entityData.idcard = _idcard;
                var _dzkscj_aq = $("#kscjaq").val()==""?"0":$("#kscjaq").val(); entityData.dzkscj_aq = _dzkscj_aq;
                var _dzkscj_ll = $("#kscjll").val()==""?"0":$("#kscjll").val(); entityData.dzkscj_ll = _dzkscj_ll;
                var _dzkscj_sz = $("#kscjsz").val()==""?"0":$("#kscjsz").val(); entityData.dzkscj_sz = _dzkscj_sz;
                var _workshop = $("#txtcj").val(); entityData.workshop = _workshop;
                var _training_type = $("#cbpxlb").combobox("getValue"); entityData.training_type = _training_type;
                var _old_post = $("#txtyzm").val(); entityData.old_post = _old_post;
                var _new_post = $("#txtxxzm").val(); entityData.new_post = _new_post;
                var _study_date = $("#xxlrq").datebox('getValue'); entityData.study_date = _study_date;
                var _study_no = $("#xxllh").val(); entityData.study_no = _study_no;
                var _rljy_begindate = $("#aqjyqsrq").datebox('getValue'); entityData.rljy_begindate = _rljy_begindate;
                var _rljy_enddate = $("#aqjyjsrq").datebox('getValue'); entityData.rljy_enddate = _rljy_enddate;
                var _llpx_type = $("#cbpxxs").combobox("getValue"); entityData.llpx_type = _llpx_type;
                var _llpx_begindate = $("#llpxqsrq").datebox('getValue'); entityData.llpx_begindate = _llpx_begindate;
                var _llpx_enddate = $("#llpxjsrq").datebox('getValue'); entityData.llpx_enddate = _llpx_enddate;
                var _szpx_begindate = $("#szpxqsrq").datebox('getValue'); entityData.szpx_begindate = _szpx_begindate;
                var _szpx_enddate = $("#szpxjsrq").datebox('getValue'); entityData.szpx_enddate = _szpx_enddate;
                var _szpx_teacher = $("#txtsfxm").val(); entityData.szpx_teacher = _szpx_teacher;
                var _dzl_date = $("#dzlrq").datebox('getValue'); entityData.dzl_date = _dzl_date;
                var _dzl_no = $("#dzllh").val(); entityData.dzl_no = _dzl_no;
                var _crh = $("input[name=isgt]:checked").attr("value");entityData.crh = _crh;
                var _address1 = $("#txtdd1").val(); entityData.address1 = _address1;
                var _studyhour1 = $("#txtxs1").val()==""?"0":$("#txtxs1").val(); entityData.studyhour1 = _studyhour1;
                var _address2 = $("#txtdd2").val(); entityData.address2 = _address2;
                var _studyhour2 = $("#txtxs2").val()==""?"0":$("#txtxs2").val(); entityData.studyhour2 = _studyhour2;
                var _address3 = $("#txtdd3").val(); entityData.address3 = _address3;
                var _studyhour3 = $("#txtxs3").val()==""?"0":$("#txtxs3").val(); entityData.studyhour3 = _studyhour3;
                var _classno = $("#pxbbh").val(); entityData.classno = _classno;
                var _indenture = $("#sthtbh").val(); entityData.indenture = _indenture;
                var _cjaqcj = $("#txtcjaqcj").val()==""?"0":$("#txtcjaqcj").val(); entityData.cjaqcj = _cjaqcj;
                var _bzaqcj = $("#txtbzaqcj").val()==""?"0":$("#txtbzaqcj").val(); entityData.bzaqcj = _bzaqcj;
                var _lzfzr = $("#txtlzfzr").val(); entityData.lzfzr = _lzfzr;
                var _zjfzr = $("#txtzjfzr").val(); entityData.zjfzr = _zjfzr;
                var _cjpxr = $("#txtcjpxr").val(); entityData.cjpxr = _cjpxr;
                var _bzpxr = $("#txtbzpxr").val(); entityData.bzpxr = _bzpxr;
                var _fzdw = $("#txtfzdw").val(); entityData.fzdw = _fzdw;
                var _fzrq = $("#fzrq").datebox('getValue'); entityData.fzrq = _fzrq;
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
            function bindEditData(id){
                $.ajax({
                    type: 'get',
                    url: 'getDataById',
                    data: {id:id},
                    dataType: "json",
                    success: function (r) {
                        if (r.result) {
                            _editData = r.rows;
                            $("#txtPid").val(_editData.idcard);
                            $("#txtUserName").val(_editData.name);
                            $("#txtSex").val(_editData.sex);
                            $("#txtXl").val(_editData.xl);
                            $("#txtcj").val(_editData.workshop);
                            $("#cbpxlb").combobox("setValue",_editData.training_type);
                            $("#txtyzm").val(_editData.old_post);
                            $("#txtxxzm").val(_editData.new_post); 
                            $("#xxlrq").datebox('setValue',_editData.study_date);
                            $("#xxllh").val(_editData.study_no);
                            $("#aqjyqsrq").datebox('setValue',_editData.rljy_begindate);
                            $("#aqjyjsrq").datebox('setValue',_editData.rljy_enddate);
                            $("#cbpxxs").combobox("setValue",_editData.llpx_type);
                            $("#llpxqsrq").datebox('setValue',_editData.llpx_begindate);
                            $("#llpxjsrq").datebox('setValue',_editData.llpx_enddate);
                            $("#szpxqsrq").datebox('setValue',_editData.szpx_begindate);
                            $("#szpxjsrq").datebox('setValue',_editData.szpx_enddate);
                            $("#txtsfxm").val(_editData.szpx_teacher);
                            $("#kscjaq").val(_editData.dzkscj_aq);
                            $("#kscjll").val(_editData.dzkscj_ll);
                            $("#kscjsz").val(_editData.dzkscj_sz);
                            $("#dzlrq").datebox('setValue',_editData.dzl_date);
                            $("#dzllh").val(_editData.dzl_no);
                            $("#txtdd1").val(_editData.address1);
                            $("#txtxs1").val(_editData.studyhour1);
                            $("#txtdd2").val(_editData.address2);
                            $("#txtxs2").val(_editData.studyhour2);
                            $("#txtdd3").val(_editData.address3);
                            $("#txtxs3").val(_editData.studyhour3);
                            $("#pxbbh").val(_editData.classno);
                            $("#sthtbh").val(_editData.indenture);
                            $("#txtcjaqcj").val(_editData.cjaqcj);
                            $("#txtbzaqcj").val(_editData.bzaqcj);
                            $("#txtlzfzr").val(_editData.lzfzr);
                            $("#txtzjfzr").val(_editData.zjfzr);
                            $("#txtcjpxr").val(_editData.cjpxr);
                            $("#txtbzpxr").val(_editData.bzpxr);
                            $("#txtfzdw").val(_editData.fzdw);
                            $("#fzrq").datebox('setValue',_editData.fzrq);
                            $("input:radio[name=isgt][value=" + _editData.crh + "]").attr("checked", true);
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
            function showErrInfo(obj, msg) {
                $(obj).focus();
                $(obj).closest('.form-group').removeClass("check-success");
                $(obj).closest('.form-group').addClass("check-error");
                $(obj).closest('.field').append('<div class="input-help"><ul><li>' + msg + '</li></ul></div>');
            }
            function clearErrInfo(obj) {
                $(obj).closest('.form-group').removeClass("check-error");
                $(obj).parent().find(".input-help").remove();
                $(obj).closest('.form-group').addClass("check-success");
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
                        data: {name:_name,iszjcuser: _iszjcuser},
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
                //绑定成绩
                setCJ();
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
            function aqjyrqChange(){
                var _rljy_begindate = $("#aqjyqsrq").datebox('getValue');
                var _rljy_enddate = $("#aqjyjsrq").datebox('getValue');
                if(_rljy_begindate > _rljy_enddate) showErrInfo($("#aqjyjsrq"),"结束日期必须大于起始日期");
                else clearErrInfo($("#aqjyjsrq"));
            }
            function llpxrqChange(){
                var _llpx_begindate = $("#llpxqsrq").datebox('getValue');
                var _llpx_enddate = $("#llpxjsrq").datebox('getValue');
                if(_llpx_begindate > _llpx_enddate) showErrInfo($("#llpxjsrq"),"结束日期必须大于起始日期");
                else clearErrInfo($("#llpxjsrq"));
            }
            function szpxrqChange(){
                var _szpx_begindate = $("#szpxqsrq").datebox('getValue');
                var _szpx_enddate = $("#szpxjsrq").datebox('getValue');
                if(_szpx_begindate > _szpx_enddate) showErrInfo($("#szpxjsrq"),"结束日期必须大于起始日期");
                else clearErrInfo($("#szpxjsrq"));
            }
            function ckeckValues(obj){
                var e = $(obj);
                var id = e.attr("id");
                if(e.val()!="") clearErrInfo(e);
                switch(id){
                    case "txtyzm":
                        var lb = $("#cbpxlb").combobox("getValue");
                        if(lb!="新职" && e.val()=="" && e.parent().find(".input-help").length<=0) showErrInfo(e,"必填项");
                        break;
                    case "pxbbh":
                        var _llpx_type = $("#cbpxxs").combobox("getValue");
                        if(_llpx_type!="师带徒" && e.val()=="" && e.parent().find(".input-help").length<=0) showErrInfo(e,"必填项");
                        break;
                    case "sthtbh":
                        var _llpx_type = $("#cbpxxs").combobox("getValue");
                        if(_llpx_type=="师带徒" && e.val()=="" && e.parent().find(".input-help").length<=0) showErrInfo(e,"必填项");
                        break;
                    default:
                        break;
                        
                }
            }
            function pxxsChange(){
                clearErrInfo($("#pxbbh"));
                clearErrInfo($("#sthtbh"));
                var _llpx_type = $("#cbpxxs").combobox("getValue");
                if(_llpx_type=="师带徒"){$("#pxbbh").val("").attr("disabled","disabled");$("#sthtbh").removeAttr("disabled");}
                else{$("#pxbbh").val("").removeAttr("disabled");$("#sthtbh").attr("disabled","disabled");}
            }
            function pxlbChange(){
                clearErrInfo($("#txtyzm"));
                $("#txtyzm").val("");
            }
            function setCJ(){
                var _llpx_type = $("#cbpxxs").combobox("getValue");
                if(_llpx_type!="师带徒"){
                    var pid = $("#txtPid").val();
                    var classno = $("#pxbbh").val();
                    if(pid!="" && classno!=""){
                        $.ajax({
                            type: 'get',
                            url: 'getStudentsCom',
                            data: {pid:pid,classno:classno},
                            dataType: "json",
                            success: function (r) {
                                if(r.result && r.rows.length>0){
                                    var row = r.rows[0];
                                    $("#kscjaq").val(getpoints(row.stu_sec_points));
                                    $("#kscjll").val(getpoints(row.stu_phy_points));
                                    $("#kscjsz").val(getpoints(row.stu_prac_points));
                                }
                            },
                            error: function () {
                                $.messager.alert("提示", "调用后台接口出错！", "alert");
                            }
                        });
                    }
                }
            }
            function getpoints(points){
                if(points=="")  return "0";
                var result = "";
                var arr = points.split('+');
                result = parseFloat(arr[0]);
                if(arr.length>1)
                    result = result+parseFloat(arr[1]);
                result = isNaN(result)?"0":result;
                return result;
            }
            function chooseClass(){
                var d1 = myformatter(new Date());
                $('#choose-dialog').dialog('open');
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
                var _pxlb=$("#cbpxlb").combobox("getValue");
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
            function saveClick(){
                //绑定成绩
                var row = $("#tt").datagrid("getSelected");
                if(row){
                    $("#pxbbh").val(row.classno);
                    clearErrInfo($("#pxbbh"));
                    var bengindate = row.startdate==""?"":row.startdate.split(' ')[0];
                    var enddate = row.enddate==""?"":row.enddate.split(' ')[0];
                    $("#llpxqsrq").datebox('setValue',bengindate);
                    $("#llpxjsrq").datebox('setValue',enddate);
                }
                setCJ();
                $('#choose-dialog').dialog('close');
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
                <td class="leftTd">培训类别：</td>
                <td class="rightTd">
                    <input class="easyui-combobox" style='width:100px;' data-options="valueField:'code',textField:'name',onChange:pxlbChange,data:[{code:'新职',name:'新职'},{code:'转岗',name:'转岗'},{code:'晋升',name:'晋升'}]" id="cbpxlb">
                </td>
                <td class="leftTd">培训形式：</td>
                <td class="rightTd">
                    <input class="easyui-combobox" style='width:100px;' data-options="valueField:'code',textField:'name',onChange:pxxsChange,data:[{code:'送外',name:'送外'},{code:'局培',name:'局培'},{code:'段培',name:'段培'},{code:'师带徒',name:'师带徒'}]" id="cbpxxs">
                </td>
            </tr>
            <tr>
                <td class="leftTd">培训班编号：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input pointer" id="pxbbh" placeholder="培训班编号(点击选择)" data-validate="required:必填项" onblur="ckeckValues(this);" onclick="chooseClass()"/>
                        </div>
                    </div>
                </td>
                <td class="leftTd">师徒合同编号：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="sthtbh" placeholder="师徒合同编号" data-validate="required:必填项" onblur="ckeckValues(this);"/>
                        </div>
                    </div>
                </td>
            </tr>
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
                    <input type="text" class="input" id="txtSex" disabled="disabled" placeholder="性别（选取用户后自动读取）"/>
                </td>
                <td class="leftTd">学历：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtXl" disabled="disabled" placeholder="学历（选取用户后自动读取）"/>
                </td>
            </tr>
            <tr>
                <td class="leftTd">车间：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtcj" placeholder="车间"/>
                </td>
                <td class="leftTd">是否高铁：</td>
                <td class="rightTd">
                    <input class="pointer" name="isgt" value="1" id="isgt_1" type="radio" checked="checked"/><label class="pointer" for="isgt_1">是</label>
                    <input class="pointer" name="isgt" value="0" id="isgt_0" type="radio"/><label class="pointer" for="isgt_0">否</label>
                </td>
            </tr>
            <tr>
                <td class='rightTd' style='text-align: center;padding: 8px;' colspan="4">职名</td>
            </tr>
            <tr>
                <td class="leftTd">原职名：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="txtyzm" placeholder="原职名" onblur="ckeckValues(this);"/>
                        </div>
                    </div>
                </td>
                <td class="leftTd">学习职名：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="txtxxzm" placeholder="学习职名" data-validate="required:必填项" onblur="ckeckValue(this);"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class='rightTd' style='text-align: center;padding: 8px;' colspan="4">学习令（培训通知）</td>
            </tr>
            <tr>
                <td class="leftTd">日期：</td>
                <td class="rightTd">
                    <input class="easyui-datebox" data-options="prompt:'学习令日期'" style='width:100px;' id="xxlrq">
                </td>
                <td class="leftTd">令号：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="xxllh" placeholder="令号"/>
                </td>
            </tr>
            <tr>
                <td class='rightTd' style='text-align: center;padding: 8px;' colspan="4">安全（入路）教育</td>
            </tr>
            <tr>
                <td class="leftTd">起始日期：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-datebox" data-options="prompt:'起始日期',onChange:aqjyrqChange" style='width:100px;' id="aqjyqsrq">
                        </div>
                    </div>
                </td>
                <td class="leftTd">结束日期：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-datebox" data-options="prompt:'结束日期',onChange:aqjyrqChange" style='width:100px;' id="aqjyjsrq">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class='rightTd' style='text-align: center;padding: 8px;' colspan="4">理论培训</td>
            </tr>
            <tr>
                <td class="leftTd">起始日期：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-datebox" data-options="prompt:'起始日期',onChange:llpxrqChange" style='width:100px;' id="llpxqsrq">
                        </div>
                    </div>
                </td>
                <td class="leftTd">结束日期：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-datebox" data-options="prompt:'结束日期',onChange:llpxrqChange" style='width:100px;' id="llpxjsrq">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class='rightTd' style='text-align: center;padding: 8px;' colspan="4">实作培训</td>
            </tr>
            <tr>
                <td class="leftTd">起始日期：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-datebox" data-options="prompt:'起始日期',onChange:szpxrqChange" style='width:100px;' id="szpxqsrq">
                        </div>
                    </div>
                </td>
                <td class="leftTd">结束日期：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-datebox" data-options="prompt:'结束日期',onChange:szpxrqChange" style='width:100px;' id="szpxjsrq">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">师傅姓名：</td>
                <td class="rightTd" colspan="3">
                    <input type="text" class="input" id="txtsfxm" placeholder="师傅姓名"/>
                </td>
            </tr>
            <tr>
                <td class='rightTd' style='text-align: center;padding: 8px;' colspan="4">定职考试科目成绩</td>
            </tr>
            <tr>
                <td class="leftTd">安全：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="kscjaq" data-validate="double:只能输入数字" onblur="ckeckValue(this);" placeholder="安全成绩"/>
                        </div>
                    </div>
                </td>
                <td class="leftTd">理论：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="kscjll" data-validate="double:只能输入数字" onblur="ckeckValue(this);" placeholder="理论成绩"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">实作：</td>
                <td class="rightTd" colspan="3">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="kscjsz" data-validate="double:只能输入数字" onblur="ckeckValue(this);" placeholder="实作成绩"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class='rightTd' style='text-align: center;padding: 8px;' colspan="4">定职令</td>
            </tr>
            <tr>
                <td class="leftTd">日期：</td>
                <td class="rightTd">
                    <input class="easyui-datebox" data-options="prompt:'定职令日期'" style='width:100px;' id="dzlrq">
                </td>
                <td class="leftTd">令号：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="dzllh" placeholder="令号"/>
                </td>
            </tr>
            <tr>
                <td class="leftTd">车间安全成绩：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="txtcjaqcj" data-validate="double:只能输入数字" onblur="ckeckValue(this);" placeholder="理论成绩"/>
                        </div>
                    </div>
                </td>
                <td class="leftTd">班组安全成绩：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="txtbzaqcj" data-validate="double:只能输入数字" onblur="ckeckValue(this);" placeholder="班组安全成绩"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">劳资负责人：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtlzfzr" placeholder="劳资负责人"/>
                </td>
                <td class="leftTd">职教负责人：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtzjfzr" placeholder="职教负责人"/>
                </td>
            </tr>
            <tr>
                <td class="leftTd">车间培训人：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtcjpxr" placeholder="车间培训人"/>
                </td>
                <td class="leftTd">班组培训人：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtbzpxr" placeholder="班组培训人"/>
                </td>
            </tr>
            <tr>
                <td class="leftTd">发证单位：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtfzdw" placeholder="发证单位"/>
                </td>
                <td class="leftTd"> 发证日期：</td>
                <td class="rightTd">
                    <input class="easyui-datebox" data-options="prompt:'发证日期'" style='width:100px;' id="fzrq">
                </td>
            </tr>
            <tr>
                <td class="leftTd">地点1：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtdd1" placeholder="地点1"/>
                </td>
                <td class="leftTd">学时1：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtxs1" placeholder="学时1"/>
                </td>
            </tr>
            <tr>
                <td class="leftTd">地点2：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtdd2" placeholder="地点2"/>
                </td>
                <td class="leftTd">学时2：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtxs2" placeholder="学时2"/>
                </td>
            </tr>
            <tr>
                <td class="leftTd">地点3：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtdd3" placeholder="地点3"/>
                </td>
                <td class="leftTd">学时3：</td>
                <td class="rightTd">
                    <input type="text" class="input" id="txtxs3" placeholder="学时3"/>
                </td>
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
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveClick();">确认</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-no'" onclick="$('#choose-dialog').dialog('close');">关闭</a>
        </div>
        
    </body>
</html>
