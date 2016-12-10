<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="_csrf" content="${_csrf.token}"/>
        <meta name="_csrf_header" content="${_csrf.headerName}"/>
        <title>资料信息列表页</title>
        <%@include file="/WEB-INF/views/jspf/commonjs.jspf"%>
        <style>
            #bindPost_dlg p{border-bottom: #575765 dashed 1px;padding-bottom:2px;text-indent:1em;cursor:pointer;}
            #bindPost_dlg p.selected{border-bottom: #575765 dashed 1px;padding-bottom:2px;text-indent:1em;cursor:pointer;color:red;}
        </style>
        <script type="text/javascript">
            var _iszjcuser = false;
            var _currentUserPid="";
            var _currentUserCompanyId="";
            var _currentUserSystem = "";
            var _iseduuser = false;
            var _statusData=[{"code":"","name":"--所有--"},{"code":"1","name":"本单位"},{"code":"2","name":"本人"}];
            $(document).ready(function () {
                //alert("${user.roles}");//rolename//ROLE_EDU
                _iseduuser = ${iseduuser};
                _iszjcuser = ${iszjcuser};//
                _currentUserPid = "${user.username}".toLowerCase();//
                _currentUserCompanyId = "${user.companyId}";//
                _currentUserSystem = "${user.system}";
                anticsrf();
                if(!_iseduuser && !_iszjcuser)
                    $("#btnAdd").linkbutton("disable");
                $("#btnSh").hide();
                $("#btnEdit").linkbutton("disable");
                $("#btnDele").linkbutton("disable");
                $("#cbStatus").combobox("loadData",_statusData);
                bindBigType();
                bindBindedPost();
                bindAllPost();
                bindData();
                $("#tt").datagrid('getPager').pagination({
                    onSelectPage: function () {
                        bindData();
                    }
                });
            });
            function bindData() {
                var index = layer.msg('加载列表数据中，请稍后...',{icon:16,time:10000,shade:[0.5,'#EAEAEA'],maxWidth:230});
                var pageNumber = $("#tt").datagrid('getPager').data("pagination").options.pageNumber;
                pageNumber = pageNumber === 0 ? 1 : pageNumber;
                var pageSize = $("#tt").datagrid('getPager').data("pagination").options.pageSize;
                var bigTypeCode = $("#cbBigType").combobox("getValue");
                var smallTypeCode = $("#cbSmallType").combobox("getValue");
                var _status = $("#cbStatus").combobox("getValue");
//                var bookCode = $("#cbType3").combobox("getValue");
//                var bookValue = $("#cbType3").combobox("getText");
                var post = $("#cbPost").combobox("getValue");
                var _filterRules = [];
                if ($("#tbTitle").val())
                    _filterRules.push({"field": "title", "op": "contains", "value": $("#tbTitle").val()});
                if (bigTypeCode !== "" && bigTypeCode !== "-1")
                    _filterRules.push({"field": "type2id", "op": "equals", "value": bigTypeCode});
                if (smallTypeCode !== "" && smallTypeCode !== "-1")
                    _filterRules.push({"field": "type1", "op": "equals", "value": smallTypeCode});
//                if (bookCode !== "" && bookCode !== "-1")
//                    _filterRules.push({"field": "type4", "op": "equals", "value": bookValue});
                if (post !== "" && post !== "--所有--")
                    _filterRules.push({"field": "post", "op": "custom", "value": post});
                if(_status!=""){
                    if(_status=="1")//本单位
                        _filterRules.push({"field": "publishUserUnitId", "op": "equals", "value": _currentUserCompanyId});
                    else if(_status=="2")//个人
                        _filterRules.push({"field": "publishUserId", "op": "equals", "value": _currentUserPid});
                }
                var filterRuleStr = "";
                if (_filterRules.length > 0)
                    filterRuleStr = JSON.stringify(_filterRules);
                var _sort = $("#tt").datagrid('options').sortName;
                var _order = $("#tt").datagrid('options').sortOrder;
                if (_sort == null || _sort == "")
                    _order = "desc";
                $.ajax({
                    type: 'get',
                    url: 'allBooks',
                    data: {page: pageNumber, rows: pageSize, filterRules: filterRuleStr, sort: _sort, order: _order},
                    dataType: "json",
                    success: function (r) {
                        if (r.result){
                            $("#tt").datagrid("loadData", r);
                            if(r.rows && r.rows.length>0)
                                $("#tt").datagrid("selectRow", 0);
                        }
                        else
                            $.messager.alert("提示", r.info, "alert");
                        layer.close(index);
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "alert");
                        layer.close(index);
                    }
                });
            }
            function formatDate(value) {
                if (value)
                    return value.split(' ')[0];
                else
                    return "";
            }
            function formatOptions(value, row) {
                return "<a href=# onclick=openView('" + row.id + "')>查阅</a>";
            }
            function formatShStatus(value,row){
                return value=="1"? "<span>"+row.shUser+"</span>":"<待审>";
            }
            function openView(bookid) {
//                $("#view-window").load("view",{"bookid":bookid});
                var url = "view?bookid=" + bookid + "&tip=1";
                var con = '<iframe src="' + url + '" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                $('#view-window').html(con);
                $('#view-window').window({title: '资料查阅', width: '660px', height: '660px'});
                $('#view-window').window('open');
            }
            function bindBookType() {
                $.ajax({
                    type: 'get',
                    url: 'bookType',
                    data: {},
                    dataType: "json",
                    success: function (r) {
                        if (r.result) {
                            r.rows.unshift({"code": "-1", "type": "--所有--"});
                            $("#cbType3").combobox("loadData", r.rows);
                            $("#cbType3").combobox("select", r.rows[0].code);
                        } else
                            $.messager.alert("提示", r.info, "alert");
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "alert");
                    }
                });
            }
            function bindBigType() {
                var index = layer.msg('加载大类中，请稍后...',{icon:16,time:10000,shade:[0.5,'#EAEAEA'],maxWidth:230});
                $.ajax({
                    type: 'get',
                    url: 'bigType',
                    data: {},
                    dataType: "json",
                    success: function (r) {
                        if (r.result) {
                            r.rows.unshift({"code": "-1", "type": "--所有--"});
                            $("#cbBigType").combobox("loadData", r.rows);
                            $("#cbBigType").combobox("select", r.rows[0].code);
                        } else
                            $.messager.alert("提示", r.info, "alert");
                        layer.close(index);
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "alert");
                        layer.close(index);
                    }
                });
            }
            function bindSmallType() {
                var index = layer.msg('加载小类中，请稍后...',{icon:16,time:10000,shade:[0.5,'#EAEAEA'],maxWidth:230});
                $("#cbSmallType").combobox("loadData", []);
                var bigTypeCode = $("#cbBigType").combobox("getValue");
                $.ajax({
                    type: 'get',
                    url: 'smallType',
                    data: {code: bigTypeCode},
                    dataType: "json",
                    success: function (r) {
                        if (r.result) {
                            r.rows.unshift({"code": "-1", "type": "--所有--"});
                            $("#cbSmallType").combobox("loadData", r.rows);
                            $("#cbSmallType").combobox("select", r.rows[0].code);
                        } else
                            $.messager.alert("提示", r.info, "alert");
                        layer.close(index);
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "alert");
                        layer.close(index);
                    }
                });
            }
            function bindBindedPost() {
                var index = layer.msg('加载已绑定工种数据中，请稍后...',{icon:16,time:10000,shade:[0.5,'#EAEAEA'],maxWidth:230});
                $("#cbPost").combobox("loadData", []);
                $.ajax({
                    type: 'get',
                    url: 'bindedPost',
                    data: {},
                    dataType: "json",
                    success: function (r) {
                        if (r.result) {
                            r.rows.unshift({"post": "--未绑定资料--"});
                            r.rows.unshift({"post": "--所有--"});
                            $("#cbPost").combobox("loadData", r.rows);
                            $("#cbPost").combobox("select", r.rows[0].post);
                        } else
                            $.messager.alert("提示", r.info, "alert");
                        layer.close(index);
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "alert");
                        layer.close(index);
                    }
                });
            }
            function bindAllPost() {
                $.ajax({
                    type: 'get',
                    url: 'allPost',
                    data: {system:_currentUserSystem},
                    dataType: "json",
                    success: function (r) {
                        var items = r.rows;
                        for (var i = 0; i < items.length; i++) {
                            var professional = items[i].professional;
                            var childrens = items[i].children;
                            var contentHtml = "";
                            for (var j = 0; j < childrens.length; j++) {
                                contentHtml += "<p ck='0' onclick='choosePost(this)' value='" + childrens[j].post + "'>" + childrens[j].post + "</p>";
                            }
                            $('#aa').accordion('add', {
                                title: professional,
                                content: contentHtml
                            });
                        }
                        $('#aa').accordion('select', 0);
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "alert");
                    }
                });
            }
            function choosePost(obj) {
                if ($(obj).attr("ck") === "0")
                    $(obj).attr("ck", "1").addClass("selected");
                else
                    $(obj).attr("ck", "0").removeClass("selected");
            }
            function openBindPostDialog() {
                $("#selectBookDiv").html("");
                var selectRows = $("#tt").datagrid("getChecked");
                if (selectRows.length > 0) {
                    var bindedPost = [];
                    var _contains = true;
                    for (var i = 0; i < selectRows.length; i++) {
                        var a = /^([\d])/.test(selectRows[i].type2);
                        if (!a) {
                            $.messager.alert("提示", "所选资料中有不能关联工种的资料[" + selectRows[i].title + "]！", "alert");
                            return;
                        }
                        $("#selectBookDiv").html($("#selectBookDiv").html() + "<p>" + selectRows[i].title + "</p>");
                        $.ajax({
                            type: 'get',
                            url: 'bookPost',
                            data: {bookid: selectRows[i].id},
                            dataType: "json",
                            async: false,
                            success: function (r) {
                                if (r.result) {
                                    var items = r.rows;
                                    var temp = [];
                                    for (var j = 0; j < items.length; j++) {
                                        temp.push(items[j][0]);
                                    }
                                    bindedPost.push(temp);
                                } else
                                    $.messager.alert("提示", r.info, "alert");
                            },
                            error: function () {
                                $.messager.alert("提示", "调用后台接口出错！", "alert");
                            }
                        });
                    }
                    for (var i = 0; i < bindedPost.length - 1; i++) {
                        _contains = bindedPost[i].toString() === bindedPost[i + 1].toString();
                        if (!_contains)
                            break;
                    }
                    $("#postDiv p").attr("ck", "0").removeClass("selected");
                    for (var i = 0; i < bindedPost.length; i++) {
                        for (var j = 0; j < bindedPost[i].length; j++) {
                            var post = bindedPost[i][j];
                            $("#postDiv p[value='" + post + "']").attr("ck", "1").addClass("selected");
                        }
                    }
                    if (_contains)
                        $("#bindPost_dlg").dialog("open");
                    else {
                        $.messager.confirm("提示", "所选资料分别绑定有不同的工种，是否要重新绑定？", function (r) {
                            if (r)
                                $("#bindPost_dlg").dialog("open");
                        });
                    }
                } else {
                    $.messager.alert("提示", "请至少选择一条数据！", "alert");
                }
            }
            Array.prototype.contains = function (item) {
                for (i = 0; i < this.length; i++) {
                    if (this[i] === item) {
                        return true;
                    }
                }
                return false;
            };
            function saveBookeBindPost() {
                var choosePost = $("#postDiv p[ck='1']");
                if (choosePost.length > 0) {
                    var selectBooks = $("#tt").datagrid("getSelections");
                    var _bookids = "";
                    var _posts = "";
                    for (var i = 0; i < selectBooks.length; i++) {
                        var bookid = selectBooks[i].id;
                        _bookids += bookid + ',';
                    }
                    for (var i = 0; i < choosePost.length; i++) {
                        var post = $(choosePost[i]).text();
                        _posts += post + ',';
                    }
                    _bookids = _bookids.substring(0, _bookids.length - 1);
                    _posts = _posts.substring(0, _posts.length - 1);
                    $.ajax({
                        type: 'post',
                        url: 'bookBindPost',
                        data: {bookids: _bookids, posts: _posts},
                        dataType: "json",
                        success: function (r) {
                            if (r.result) {
                                $.messager.alert("提示", "操作成功！", "alert");
                                bindBindedPost();
                                bindData();
                                var row = $("#tt").datagrid("getSelections")[0];
                                var rowIndex = $("#tt").datagrid("getRowIndex", row);
                                datagridRowCheck(rowIndex, row);
                                $('#bindPost_dlg').dialog('close');
                            } else
                                $.messager.alert("提示", r.info, "alert");
                        },
                        error: function () {
                            $.messager.alert("提示", "调用后台接口出错！", "alert");
                        }
                    });
                } else {
                    $.messager.alert("提示", "请至少选择一个工种！", "alert");
                }
            }
            function datagridRowClick(index, row) {
                $("#tt").datagrid("unselectAll");
                $("#tt").datagrid("selectRow", index);
//                var checkLength = $("#tt").datagrid("getChecked").length;
//                if(checkLength==0)
//                $("#tt").datagrid("uncheckAll");
//                $("#tt").datagrid("checkRow",index);
                showHidePost(row);
            }
            function datagridRowCheck(index, row) {
                showHidePost(row);
            }
            function showHidePost(row) {
                if(_iszjcuser){
                    $("#btnSh").show();
                    $("#btnSh").linkbutton("enable");
                    if(row.sh=="1"){
                        $("#btnSh .l-btn-text").attr("ty","0").html("取消审核");
                        if(row.shUserId && row.shUserId.toLowerCase()==_currentUserPid){
                            $("#btnSh").linkbutton("enable");
                        }
                        else
                            $("#btnSh").linkbutton("disable");
                    }else{
                        $("#btnSh .l-btn-text").attr("ty","1").html("审核");
                    }
                }else{
                    $("#btnSh").hide();
                }
                if(row.sh=="1" || (!_iszjcuser && _currentUserPid!=row.publishUserId.toLowerCase() && !_iseduuser)){
                    $("#btnEdit").linkbutton("disable");
                    $("#btnDele").linkbutton("disable");
                }else{
                    $("#btnEdit").linkbutton("enable");
                    $("#btnDele").linkbutton("enable");
                }
                var a = /^([\d])/.test(row.type2);
                if (a && (_iseduuser || _iszjcuser))
                    $("#btnBindPost").show();
                else
                    $("#btnBindPost").hide();
                $('#cc').layout('remove', 'east');
                var options = {
                    region: 'east',
                    width: '200px',
                    title: '已关联工种',
                    content: getContent(row),
                    collapsed: false,
                    split: true
                };
                $('#cc').layout('add', options);
            }
            function getContent(row) {
                var contentHtml = "";
                var postHtml = "";
                $.ajax({
                    type: 'get',
                    url: 'bookPost',
                    data: {bookid: row.id},
                    dataType: "json",
                    async: false,
                    success: function (r) {
                        if (r.result) {
                            var items = r.rows;
                            for (var j = 0; j < items.length; j++) {
                                postHtml += "<p>" + items[j][0] + "</p>";
                            }
                        } else
                            $.messager.alert("提示", r.info, "alert");
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "alert");
                    }
                });
                postHtml = postHtml === "" ? "<p style='color:#D4D4D4'>未关联工种</p>" : postHtml;
                contentHtml += '<div style="padding:60px 0 0 10px;font-size:20px;font-weight:bold;">' + row.title + '</div>';
                contentHtml += '<div style="padding:20px 0 0 10px;font-size:14px;">已关联工种：</div>';
                contentHtml += '<div style="padding:10px 0 0 10px;font-size:14px;">' + postHtml + '</div>';
                return contentHtml;
            }
            function addBook() {
                var con = '<iframe src="edit" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                $("#view-window").html(con);
                $("#view-window").window({title: '新增资料', width: '800px', height: '580px'});
                $("#view-window").window("open");
            }
            function editBook() {
                var rows = $("#tt").datagrid("getSelections");
                if (rows.length > 0) {
                    var con = '<iframe src="edit?bookid=' + rows[rows.length - 1].id + '" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                    $("#view-window").html(con);
                    $("#view-window").window({title: '编辑资料[ ' + rows[rows.length - 1].title + ' ]', width: '800px', height: '580px'})
                    $("#view-window").window("open");
                } else {
                    $.messager.alert("提示", "请选择要编辑的资料！", "alert");
                }
            }
            function delBook() {
                var rows = $("#tt").datagrid("getSelections");
                if (rows.length > 0) {
                    var row = rows[rows.length - 1];
                    $.messager.confirm("提示", "确定要删除资料[" + row.title + "]？", function (r) {
                        if (r)
                        {
                            $.ajax({
                                type: 'delete',
                                url: 'book/' + row.id,
                                data: {},
                                dataType: "json",
                                success: function (r) {
                                    $.messager.alert("提示", r.info, "alert");
                                    if (r.result) {
                                        bindBindedPost();
                                        bindData();
                                    }
                                },
                                error: function () {
                                    $.messager.alert("提示", "调用后台接口出错！", "alert");
                                }
                            });
                        }
                    });
                } else {
                    $.messager.alert("提示", "请选择要删除的资料！", "alert");
                }
            }
            function shBook(){
                var _ty = $("#btnSh .l-btn-text").attr("ty");
                var _msg = $("#btnSh .l-btn-text").html();
                var rows = $("#tt").datagrid("getSelections");
                if (rows.length > 0) {
                    var row = rows[rows.length - 1];
                    $.messager.confirm("提示", "确定要"+_msg+"资料[" + row.title + "]？", function (r) {
                        if (r)
                        {
                            $.ajax({
                                type: 'post',
                                url: 'shbook',
                                data: {bookid:row.id,ty:_ty},
                                dataType: "json",
                                success: function (r) {
                                    $.messager.alert("提示", r.info, "alert");
                                    if (r.result) {
                                        bindData();
                                        $("#tt").datagrid("unselectAll");
                                    }
                                },
                                error: function () {
                                    $.messager.alert("提示", "调用后台接口出错！", "alert");
                                }
                            });
                        }
                    });
                } else {
                    $.messager.alert("提示", "请选择要审核的资料！", "alert");
                }
            }
            function searchClick() {
                $("#tt").datagrid("unselectAll");
                bindData();
            }
            function viewWindowClosing() {
                $('#view-window').panel('clear');
            }
        </script>
    </head>
    <body>
        <div id='cc' class="easyui-layout" data-options="fit:true">
            <div data-options="region:'center'">
                <table id="tt" title="资料信息列表" class="easyui-datagrid" data-options="
                       rownumbers:true,
                       fit:true,
                       singleSelect:false,
                       pagination:true,
                       pageSize:20,
                       idField:'id',
                       onSortColumn:bindData,
                       onClickRow:datagridRowClick,
                       onCheck:datagridRowCheck,
                       toolbar:'#menuTollbar'">
                    <thead>
                        <tr>
                            <th data-options="field:'ck',checkbox:true"></th>
                            <th data-options="field:'type2',width:100,align:'center',halign:'center',sortable:'true'">大类</th>
                            <th data-options="field:'type3',width:90,align:'center',halign:'center',sortable:'true'">小类</th>
                            <th data-options="field:'title',width:300,align:'left',halign:'center',sortable:'true'">标题</th>
                            <th data-options="field:'author',width:100,align:'center',halign:'center',sortable:'true'">作者</th>
                            <th data-options="field:'press',width:100,align:'center',halign:'center',sortable:'true'">出版社/单位</th>
                            <th data-options="field:'tdate',width:80,align:'center',halign:'center',formatter:formatDate,sortable:'true'">日期</th>
                            <th data-options="field:'type4',width:50,align:'center',halign:'center',sortable:'true'">类别</th>
                            <th data-options="field:'postcount',width:80,align:'center',halign:'center'">关联工种</th>
                            <th data-options="field:'publishUserUnitId',width:100,align:'center',halign:'center'">发布单位</th>
                            <th data-options="field:'publishUser',width:60,align:'center',halign:'center'">发布人</th>
                            <th data-options="field:'sh',width:60,align:'center',halign:'center',formatter:formatShStatus">审核人</th>
                            <th data-options="field:'opt',width:80,align:'center',halign:'center',formatter:formatOptions">在线查阅</th>
                        </tr>
                    </thead>
                </table>
                <div id="menuTollbar" style="height: auto;">
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-reload'" onclick="bindData();">刷新</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-add'" id="btnAdd" onclick="addBook();">添加</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-edit'" id="btnEdit" onclick="editBook();">编辑</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-del'" id="btnDele" onclick="delBook();">删除</a>
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-man'" id="btnSh" onclick="shBook();">审核</a>
                    <div style="padding:2px;border-top:1px solid #D4D4D4;">
                        <span style="padding-left:10px;">大类：</span>
                        <input class="easyui-combobox" data-options="valueField:'code',textField:'type',onChange:bindSmallType" style="width:130px;" id="cbBigType">
                        <span style="padding-left:10px;">小类：</span>
                        <input class="easyui-combobox" data-options="valueField:'code',textField:'type'" style="width:130px;" id="cbSmallType">
                        <!--                        <span style="padding-left:10px;">类别：</span>
                                                <input class="easyui-combobox" data-options="valueField:'code',textField:'type'" style="width:130px;" id="cbType3">-->
                        <span style="padding-left:10px;">资料工种：</span>
                        <input class="easyui-combobox" data-options="valueField:'post',textField:'post'" style="width:130px;" id="cbPost">
                        <span>标题：</span>
                        <input class="easyui-textbox" style="width:140px" id="tbTitle">
                        <span style="padding-left:10px;">所属：</span>
                        <input class="easyui-combobox" data-options="valueField:'code',textField:'name'" style="width:100px;" id="cbStatus">
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-s-search'" onclick="searchClick()">查询</a>
                        <a id="btnBindPost" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-lock'" onclick="openBindPostDialog()">关联工种</a>
                    </div>
                </div>
            </div>
        </div>

        <div id="bindPost_dlg" class="easyui-dialog" title="关联工种" data-options="iconCls:'icon-save',closed:true,buttons:'#bindPost_dlg-buttons'" style="width:550px;height:600px;padding:10px">
            <div class="easyui-layout" data-options="fit:true">
                <div id="selectBookDiv" data-options="region:'west'" style="width:270px;padding:0 10px;" title="所选择的资料"></div>
                <div id="postDiv" data-options="region:'center'" style="padding:0 10px;" title="工种选择">
                    <div id="aa" class="easyui-accordion" data-options="fit:true"></div>
                </div>
            </div>
        </div>

        <div id="bindPost_dlg-buttons">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveBookeBindPost()">确定</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-no'" onclick="$('#bindPost_dlg').dialog('close');">关闭</a>
        </div>

        <div id="view-window" class="easyui-window" title="在线阅读/下载" 
             data-options="modal:true,closed:true,iconCls:'icon-save',minimizable:false,collapsible:false,onBeforeClose:viewWindowClosing" 
             style="width:660px;height:540px;overflow:hidden;">
        </div>
    </body>
</html>
