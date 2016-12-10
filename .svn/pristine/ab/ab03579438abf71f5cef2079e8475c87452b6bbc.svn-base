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
        <link href="../s/js/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
        <script src="../s/js/umeditor/umeditor.config.js" type="text/javascript" charset="utf-8"></script>
        <script src="../s/js/umeditor/umeditor.min.js" type="text/javascript" charset="utf-8"></script>
        <script src="../s/js/umeditor/lang/zh-cn/zh-cn.js" type="text/javascript" charset="utf-8"></script>
        <script type="text/javascript" src="../s/js/Generation_Guid.js"></script>
        <script>
var _filepath = "";
var _type = "";
var _bigtype = "";
var _smalltype = "";
var _guid = "";
var _filenames = "";
var _isedit = false;
var _queueSizeLimit = 1;
var _bookType=[];
var _editData;
var _deleteFileName="";
var _fileTypeExts="*.*";
var _errfilenames="";
$(function () {
    anticsrf();
    bindBookType();
    bindBigType();
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $('#upload').uploadify({
        'swf': '../s/js/uploadify/uploadify.swf',
        'uploader': 'Upload?_csrf='+token+'&_csrf_header='+header,
        'queueID': 'filelist',
        'buttonText': '选择上传文件',
        'fileTypeExts':_fileTypeExts,
        'auto': false,
        'onUploadSuccess': function (file, data, response) {//每一个文件上传成功后执行
            var r = eval("[" + data + "]")[0];
            if (r.result) {
                _filenames += _type + "/" + _smalltype + "/" + file.name + ",";
            }else{
                _errfilenames += file.name + ",";
            }
        },
        'onQueueComplete': function (queueData) {  //所有文件上传后执行
//                        alert(queueData.uploadsSuccessful + ' 上传成功！ ');
//                        alert(queueData.uploadsErrored + ' 上传失败！ ');
            if (queueData.uploadsErrored > 0 || _errfilenames !="") {
                var errcount = queueData.uploadsErrored + (_errfilenames.split(",").length-1);
                $.messager.alert("提示", "有" + errcount + "个文件上传失败，保存数据失败！", "alert");
                if(_errfilenames.split(",").length>0){
                    _errfilenames = _errfilenames.substring(0,_errfilenames.length-1);
                    $.messager.alert("提示", _errfilenames+"的格式不正确，请使用格式工厂将视频格式转换为AVC(H.264)！", "alert");
                }
                //delete temp Folder
                $.ajax({
                    type: 'post',
                    url: 'delFolder',
                    data: {folderPath: "/temp/" + _guid},
                    dataType: "text",
                    success: function () {
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "alert");
                    }
                });
            } else {
                saveBookInfo();
//                move temp File
                $.ajax({
                    type: 'post',
                    url: 'moveFolder',
                    data: {oldPath: "/temp/" + _guid, newPath: ""},
                    dataType: "text",
                    success: function () {
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "alert");
                    }
                });
            }
        },
        'onUploadStart': function (file) {
//                        this.addPostParam("filename", encodeURI(file.name));    //支持中文文件名
        },
        'onSelectError': function (file, errorCode, errorMsg) {  //选择文件后向队列中添加每个上传任务时如果失败都会触发
            if(errorCode==-130)
                this.queueData.errorMsg='选择文件类型错误，请重新选择';
//                        if(errorCode == -100)
//                            this.queueData.errorMsg='选择文件个数超出限制';
        },
        'onUploadError': function (file, errorCode, errorMsg, errorString) {
//                        if(errorCode == "-280") alert(file.name+' 取消上传！');
//                        else alert(file.name+' 上传失败！');
        }
    });
    var bookid = GetQueryString("bookid");
    if (bookid != null && bookid != "")
        _isedit = true;
    if (_isedit) {
        $(".editElem").show();
        bindEditData(bookid);
    }
});
function bindEditData(bookid) {
    $.ajax({
        type: 'get',
        url: 'book/' + bookid,
        data: {},
        dataType: "json",
        async: false,
        success: function (r) {
            if (r.result) {
                _editData = r.rows;
                $("#cbType1").combobox("setValue", _editData.type2Id);
                $("#cbType3").combobox("setText", _editData.type4);
                for (var i = 0; i < _bookType.length; i++) {
                    if(_editData.type4 == _bookType[i].type){
                        $("#cbType3").combobox("setValue", _bookType[i].code);
                        break;
                    }
                }
//                $("#cbType3").combobox("disable");
                var bookType = $("#cbType3").combobox("getValue");
                $("#txtTitle").val(_editData.title);
                $("#txtAuthor").val(_editData.author);
                $("#txtPress").val(_editData.press);
                UM.getEditor('edAbstr').setContent(_editData.abstr);
                $('#dtTdate').datebox('setValue', _editData.tdate);
                var html = '<div class="uploadify-queue-item"><div class="cancel"><a href="#" onclick="deleteFile(this,\'@filename\')">X</a></div><span class="fileName">@filename</span></div>';
                if (bookType === "Video" || bookType === "Audio") {
                    _queueSizeLimit = 5;
                    if(_editData.fileurl1!=null && _editData.fileurl1!=""){
                        $("#upfilelist").html($("#upfilelist").html()+html.replace(/@filename/g,_editData.fileurl1));
                    }
                    if(_editData.fileurl2!=null && _editData.fileurl2!=""){
                        $("#upfilelist").html($("#upfilelist").html()+html.replace(/@filename/g,_editData.fileurl2));
                    }
                    if(_editData.fileurl3!=null && _editData.fileurl3!=""){
                        $("#upfilelist").html($("#upfilelist").html()+html.replace(/@filename/g,_editData.fileurl3));
                    }
                    if(_editData.fileurl4!=null && _editData.fileurl4!=""){
                        $("#upfilelist").html($("#upfilelist").html()+html.replace(/@filename/g,_editData.fileurl4));
                    }
                    if(_editData.fileurl5!=null && _editData.fileurl5!=""){
                        $("#upfilelist").html($("#upfilelist").html()+html.replace(/@filename/g,_editData.fileurl5));
                    }
                } else {
                    _queueSizeLimit = 1;
                    if (_editData.fileurl6 != null && _editData.fileurl6 != "") {
                        $("#upfilelist").html(html.replace(/@filename/g,_editData.fileurl6));
                    }
                }
            } else
                $.messager.alert("提示", r.info, "alert");
        },
        error: function () {
            $.messager.alert("提示", "调用后台接口出错！", "alert");
        }
    });
}
function deleteFile(obj,filename){
    $.messager.confirm("提示", "确定删除资料【"+filename+"】？", function (r) {
        if (r){
            _deleteFileName += filename + ",";
            $(obj).parent().parent().remove();
        }
    });
}
function saveBookClick() {
    $('.datatable').find('input').trigger("blur");
    var numError = $('.datatable').find('.check-error').length;
    if (numError) {
        $('.datatable').find('.check-error').first().find('input').first().focus().select();
        return;
    }
    _guid = Guid.NewGuid().ToString();
    _type = $("#cbType3").combobox('getValue');
    _smalltype = $("#cbType2").combobox('getValue');
    _filepath = "/temp/" + _guid + "/" + _type + "/" + _smalltype;
    var fileLimit = $("#filelist").children().length + $("#upfilelist").children().length;
    if (fileLimit > _queueSizeLimit) {
        $.messager.alert("提示", "[" + $("#cbType3").combobox("getText") + "类型] 只能允许上传" + _queueSizeLimit + "个资料！", "alert");
        return;
    }
    _filenames="";
    _errfilenames="";
    if ($("#filelist").children().length > 0) {
        $('#upload').uploadify("settings", "formData", {filepath: _filepath});
        $('#upload').uploadify("upload", "*");
    } else {//未选择文件上传
        saveBookInfo();
    }
}
function saveBookInfo() {
    var _title = $("#txtTitle").val();
    var _author = $("#txtAuthor").val();
    var _press = $("#txtPress").val();
    var _tdate = $('#dtTdate').datebox('getValue');
    var _type2 = $("#cbType1").combobox("getText");
    var _type2Id = $("#cbType1").combobox("getValue");
    var _type1 = $("#cbType2").combobox("getValue");
    var _type3 = $("#cbType2").combobox("getText");
    var _type4 = $("#cbType3").combobox("getText");
    var _type4Code = $("#cbType3").combobox("getValue");
    var _abstr = UM.getEditor('edAbstr').getContent();
    var _fileurl1 = "";
    var _fileurl2 = "";
    var _fileurl3 = "";
    var _fileurl4 = "";
    var _fileurl5 = "";
    var _fileurl6 = "";
    if (_isedit) {
        //已经存在的文件
        var upfiles = $("#upfilelist").children();
        for (var i = 0; i < upfiles.length; i++) {
            _filenames += $(upfiles[i]).find("span").text()+",";
        }
    }
    if (_type4Code === "Video" || _type4Code === "Audio") {
        //循环上传文件设置url1-5
        if (_filenames !== "") {
            var files = _filenames.split(',');//新上传的文件
            for (var i = 0; i < files.length; i++) {
                var filename = files[i];
                if (filename !== ""){
                    switch (i) {
                        case 0:
                            _fileurl1 = filename;
                            break;
                        case 1:
                            _fileurl2 = filename;
                            break;
                        case 2:
                            _fileurl3 = filename;
                            break;
                        case 3:
                            _fileurl4 = filename;
                            break;
                        case 4:
                            _fileurl5 = filename;
                            break;
                    }
                }
            }
        }
    } else {
        if (_filenames !== "") {
            var files = _filenames.split(',');
            _fileurl6 = files[0];
        }
    }
    var bookEntity = {title: _title, author: _author, press: _press, tdate: _tdate, type2: _type2, type2Id: _type2Id, type1: _type1, type3: _type3, type4: _type4, abstr: _abstr, fileurl1: _fileurl1, fileurl2: _fileurl2, fileurl3: _fileurl3, fileurl4: _fileurl4, fileurl5: _fileurl5, fileurl6: _fileurl6};
    if (!_isedit) {
        $.ajax({
            type: 'post',
            url: 'addBook',
            data: bookEntity,
            dataType: "json",
            success: function (r) {
                $.messager.alert("提示", r.info, "alert");
                if (r.result) {
                    parent.bindData();
                    parent.$('#view-window').window('close');
                }
            },
            error: function () {
                $.messager.alert("提示", "调用后台接口出错！", "alert");
            }
        });
    }else{
        var _id=_editData.id;
        bookEntity.id=_id;
        bookEntity.publishUserId = _editData.publishUserId;
        bookEntity.publishUserUnitId = _editData.publishUserUnitId;
        $.ajax({
            type: 'post',
            url: 'book',
            data: bookEntity,
            dataType: "json",
            success: function (r) {
                $.messager.alert("提示", r.info, "alert");
                if (r.result) {
                    if(_deleteFileName!=""){
                        var files = _deleteFileName.split(',');
                        //删除文件
                        for (var i = 0; i < files.length; i++) {
                            if(files[i]!=""){
                                $.ajax({
                                    type: 'post',
                                    url: 'delFile',
                                    data: {filePath: "/" + files[i]},
                                    dataType: "text",
                                    success: function () {
                                    },
                                    error: function () {
                                        $.messager.alert("提示", "调用后台接口出错！", "alert");
                                    }
                                });
                            }
                        }
                    }
                    parent.bindData();
                    parent.$('#view-window').window('close');
                }
            },
            error: function () {
                $.messager.alert("提示", "调用后台接口出错！", "alert");
            }
        });
    }
}
function bookTypeChange() {
    var bookType = $("#cbType3").combobox("getValue");
    _queueSizeLimit = 1;
    _fileTypeExts = "*.pdf";
    try{
        $('#upload').uploadify('cancel','*');
    }catch(e){}
    if (bookType === "Video" || bookType === "Audio") {
        _queueSizeLimit = 5;
        _fileTypeExts = "*.mp4; *.flv";
    }
    else if(bookType === "PPT"){
        _fileTypeExts = "*.ppt";
    }
    try{
        $('#upload').uploadify('settings','fileTypeExts',_fileTypeExts);
    }catch(e){}
}
function bindBookType() {
    $.ajax({
        type: 'get',
        url: 'bookType',
        data: {},
        dataType: "json",
        async: false,
        success: function (r) {
            if (r.result) {
                _bookType = r.rows;
                $("#cbType3").combobox("loadData", r.rows);
                $("#cbType3").combobox("setValue", r.rows[0].code);
            } else
                $.messager.alert("提示", r.info, "alert");
        },
        error: function () {
            $.messager.alert("提示", "调用后台接口出错！", "alert");
        }
    });
}
function bindBigType() {
    $.ajax({
        type: 'get',
        url: 'bigType',
        data: {},
        dataType: "json",
        async: false,
        success: function (r) {
            if (r.result) {
                $("#cbType1").combobox("loadData", r.rows);
                $("#cbType1").combobox("select", r.rows[0].code);
            } else
                $.messager.alert("提示", r.info, "alert");
        },
        error: function () {
            $.messager.alert("提示", "调用后台接口出错！", "alert");
        }
    });
}
function bindSmallType() {
    var bigTypeCode = $("#cbType1").combobox("getValue");
    $.ajax({
        type: 'get',
        url: 'smallType',
        data: {code: bigTypeCode},
        dataType: "json",
        async: false,
        success: function (r) {
            if (r.result) {
                $("#cbType2").combobox("loadData", r.rows);
                if(_isedit)
                    $("#cbType2").combobox("setValue", _editData.type1);
                else
                    $("#cbType2").combobox("select", r.rows[0].code);
            } else
                $.messager.alert("提示", r.info, "alert");
        },
        error: function () {
            $.messager.alert("提示", "调用后台接口出错！", "alert");
        }
    });
}
        </script>
    </head>
    <body>
        <table class="datatable" style="position:fixed;top:0px;left:0px;z-index:99999;background-color:#fff;">
            <tr>
                <td class="rightTd" colspan="4" style="text-align:left;">
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveBookClick()">确定</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-no'" onclick="parent.$('#view-window').window('close')">关闭</a>
                </td>
            </tr>
            </table>
        <table class="datatable" style="margin-top:44px">
            <tr>
                <td class="leftTd">大类：</td>
                <td class="rightTd">
                    <input class="easyui-combobox" data-options="valueField:'code',textField:'type',onChange:bindSmallType" style="width:200px;" id="cbType1">
                </td>
                <td class="leftTd">小类：</td>
                <td class="rightTd">
                    <input class="easyui-combobox" data-options="valueField:'code',textField:'type'" style="width:200px;" id="cbType2">
                </td>
            </tr>
            <tr>
                <td class="leftTd">类型：</td>
                <td class="rightTd" colspan="3">
                    <input class="easyui-combobox" data-options="valueField:'code',textField:'type',onChange:bookTypeChange" style="width:200px;" id="cbType3">
                </td>
            </tr>
            <tr>
                <td class="leftTd">标题：</td>
                <td class="rightTd" colspan="3">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="txtTitle" placeholder="资料标题" data-validate="required:请填写资料标题" onblur="ckeckValue(this);"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">作者：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="txtAuthor" placeholder="资料作者" data-validate="required:请填写资料作者" onblur="ckeckValue(this);"/>
                        </div>
                    </div>
                </td>
                <td class="leftTd">出版社：</td>
                <td class="rightTd">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input" id="txtPress" placeholder="资料出版社"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">出版日期：</td>
                <td class="rightTd" colspan="3">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input class="easyui-datebox" id="dtTdate">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">描述：</td>
                <td class="rightTd" colspan="3">
                    <script id="edAbstr" type="text/plain" style="width:100%;height:100px;"></script>
                </td>
            </tr>
            <tr>
                <td class="leftTd">资料上传：</td>
                <td class="rightTd" colspan="3">
                    <input id="upload" />
                    <div id="filelist"></div>
                </td>
            </tr>
            <tr class="editElem" style="display:none;">
                <td class="leftTd">已上传资料：</td>
                <td class="rightTd" colspan="3">
                    <div id="upfilelist"></div>
                </td>
            </tr>
            <tr>
                <td class="leftTd">视频格式转换：</td>
                <td class="rightTd" colspan="3">
                    <span>下载<a href="http://10.194.3.33/格式工厂3.8.exe">格式工厂</a>，将视频转换为MP4 AVC(H.264)格式（输出配置选AVC 720p）</span>
                </td>
            </tr>
        </table>
        <script>
            var um = UM.getEditor('edAbstr');
        </script>
    </body>
</html>
