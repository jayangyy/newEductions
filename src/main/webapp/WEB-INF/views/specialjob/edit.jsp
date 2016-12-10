<%-- 
    Document   : edit
    Created on : 2016-7-4, 11:09:27
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
		var d1 = myformatter(new Date());
//		var d2 = new Date(d1);
//                d2.setFullYear(d2.getFullYear()+6);
//                d2 = myformatter(d2);
                $('#dtFirstDate').datebox('setValue',d1);
                $('#dtValidBeginDate').datebox('setValue',d1);
//                $('#dtValidEndDate').datebox('setValue',d2);
                $("#dtValidEndDate").datebox("disable");
                bindZylb();
                var cardno = GetQueryString("cardno");
                if (cardno != null && cardno != "")
                    _isedit = true;
                if (_isedit) {
                    bindEditData(cardno);
                }
            });
            
            function myformatter(date){
                var y = date.getFullYear();  
                var m = date.getMonth()+1;  
                var d = date.getDate();  
//                var h = date.getHours();  
//                var min = date.getMinutes();  
//                var sec = date.getSeconds();  
                // var str = y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d)+' '+(h<10?('0'+h):h)+':'+(min<10?('0'+min):min)+':'+(sec<10?('0'+sec):sec);  
                var str = y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);  
                return str;
            }
            function bindEditData(cardno) {
                $.ajax({
                    type: 'get',
                    url: 'card/' + cardno,
                    data: {},
                    dataType: "json",
                    async: false,
                    success: function (r) {
                        if (r.result) {
                            _editData = r.rows;
                            $("#txtCardNo").attr("oldcardno",_editData.card_no);
                            $("#txtCardNo").val(_editData.card_no);
                            $("#txtPid").val(_editData.pid);
                            $("#txtUserName").val(_editData.name);
                            $("#txtUserSex").val(_editData.sex);
                            $("#cbZylb").combobox("setValue", _editData.lbcode);
                            $("#cbZcxm").combobox("setValue", _editData.xmcode);
                            $('#dtFirstDate').datebox('setValue', _editData.firstdate);
                            $('#dtValidBeginDate').datebox('setValue', _editData.valid_begin_date);
                            $('#dtValidEndDate').datebox('setValue', _editData.valid_end_date);
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
                var _cardno = $("#txtCardNo").val();
                var _certno = "T"+_pidno;
                var _name = $("#txtUserName").val();
                var _sex = $("#txtUserSex").val();
                var _lbcode = $("#cbZylb").combobox("getValue");
                var _zylb = $("#cbZylb").combobox("getText");
                var _xmcode = $("#cbZcxm").combobox("getValue");
                var _zcxm = $("#cbZcxm").combobox("getText");
                var _firstdate = $("#dtFirstDate").datebox('getValue');
                var _validbegindate = $("#dtValidBeginDate").datebox('getValue');
                var _validenddate = $("#dtValidEndDate").datebox('getValue');
                var _reviewdate = new Date(_firstdate);
                _reviewdate.setFullYear(_reviewdate.getFullYear()+3);
                _reviewdate = myformatter(_reviewdate);
                var cardEntity = {card_no:_cardno,cert_no:_certno,pid:_pidno,name:_name,sex:_sex,lbcode:_lbcode,zylb:_zylb,xmcode:_xmcode,zcxm:_zcxm,firstdate:_firstdate,valid_begin_date:_validbegindate,valid_end_date:_validenddate,reviewdate:_reviewdate};
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
                    var _oldcardno = $("#txtCardNo").attr("oldcardno");
                    $.ajax({
                        type: 'post',
                        url: 'card/'+_oldcardno,
                        data: cardEntity,
                        dataType: "json",
                        success: function (r) {
                            $.messager.alert("提示", r.info, "alert");
                            if (r.result) {
                                parent.$("#tt").datagrid("unselectAll");
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
            function bindZylb(){
                bindSpecialJobType($("#cbZylb"),"0");
            }
            function bindZcxm(){
                var zylb = $("#cbZylb").combobox("getValue");
                bindSpecialJobType($("#cbZcxm"),zylb);
            }
            function bindSpecialJobType(obj,fcode){
                $(obj).combobox("loadData", []);
                $.ajax({
                    type: 'get',
                    url: 'sjtype',
                    data: {fcode:fcode},
                    dataType: "json",
                    async: false,
                    success: function (r) {
                        if (r.result) {
                            $(obj).combobox("loadData", r.rows);
                            $(obj).combobox("select", r.rows[0].code);
                        } else
                            $.messager.alert("提示", r.info, "alert");
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "alert");
                    }
                });
            }
            function validDateChange(){
		var d1 = myformatter(new Date($("#dtValidBeginDate").datebox('getValue')));
		var d2 = new Date(d1);
                d2.setFullYear(d2.getFullYear()+6);
                d2 = myformatter(d2);
                $('#dtValidEndDate').datebox('setValue',d2);
            }
            function firstDateChange(newDate){
		var d1 = myformatter(new Date(newDate));
                $('#dtValidBeginDate').datebox('setValue',d1);
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
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveCardClick()">确定</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-no'" onclick="parent.$('#card-window').window('close')">关闭</a>
                </td>
            </tr>
        </table>
        <table class="datatable" style="margin-top:44px">
            <tr>
                <td class="leftTd">卡号：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="txtCardNo" placeholder="卡号" data-validate="required:请填写卡号" onblur="ckeckValue(this);"/>
                        </div>
                    </div>
                </td>
            </tr>
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
                <td class="leftTd">作业类别：</td>
                <td class="rightTd">
                    <input class="easyui-combobox" data-options="valueField:'code',textField:'name',onChange:bindZcxm" style="width:200px;" id="cbZylb">
                </td>
            </tr>
            <tr>
                <td class="leftTd">准操项目：</td>
                <td class="rightTd">
                    <input class="easyui-combobox" data-options="valueField:'code',textField:'name'" style="width:200px;" id="cbZcxm">
                </td>
            </tr>
            <tr>
                <td class="leftTd">初领日期：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-datebox" id="dtFirstDate" data-options="formatter:myformatter,onChange:firstDateChange">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">有效日期：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-datebox" id="dtValidBeginDate" data-options="onChange:validDateChange">
                            至
                            <input class="easyui-datebox" id="dtValidEndDate">
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </body>
</html>
