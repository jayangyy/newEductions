<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="_csrf" content="${_csrf.token}"/>
        <meta name="_csrf_header" content="${_csrf.headerName}"/>
        <title>职工查阅资料页</title>
        <%@include file="/WEB-INF/views/jspf/commonjs.jspf"%>
        <style>
            #postDiv p{border-bottom: #575765 dashed 1px;padding-bottom:2px;text-indent:1em;cursor:pointer;line-height:22px;}
            #postDiv p.selected{border-bottom: #575765 dashed 1px;padding-bottom:2px;text-indent:1em;cursor:pointer;color:red;}
        </style>
        <script type="text/javascript">
            var _searchType="1";
            var _loginUpid="";
            var _loginUpost="";
            var _loginUSystem="";
            $(document).ready(function () {
                anticsrf();
                _loginUpid = "${user.username}";//"";
                _loginUpost = "${user.post}";//"";
                _loginUSystem = "${user.system}";
                bindAllPost();
                $("#tt").datagrid('getPager').pagination({
                    onSelectPage: function () {
                        bindData();
                    }
                });
            });
            function bindAllPost() {
                $.ajax({
                    type: 'get',
                    url: 'allPostTree',
                    data: {system:_loginUSystem},
                    dataType: "json",
                    success: function (r) {
                        var items = r.rows;
                        $('#postTree').tree('loadData', items);
                        var n = $('#postTree').tree('find', items[0].id);
                        $('#postTree').tree('select', n.target);
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "alert");
                    }
                });
            }
            function postCheck(obj) {
                $(obj).siblings().removeClass("selected").attr("ck", "0");
                $(obj).addClass("selected").attr("ck", "1");
            }
            function bindData() {
                var postid = 0;
                var post = "";
                var selectNode = $("#postTree").tree("getSelected");
                if (selectNode) {
                    postid = selectNode.id;
                    post = selectNode.text;
                }
                var pageNumber = $("#tt").datagrid('getPager').data("pagination").options.pageNumber;
                pageNumber = pageNumber === 0 ? 1 : pageNumber;
                var pageSize = $("#tt").datagrid('getPager').data("pagination").options.pageSize;
                var _filterRules = [];
                    _filterRules.push({"field": "sh", "op": "equals", "value": "1"});
                var _title= $("#tbTitle").textbox("getValue");
                if (_title!="")
                    _filterRules.push({"field": "title", "op": "contains", "value": $("#tbTitle").val()});
                if(_searchType == "1" || _title==""){
                    if (postid == 1)//推荐：当前用户工种
                        _filterRules.push({"field": "post", "op": "custom", "value": _loginUpost});
                    else if (postid == 2)//收藏
                        _filterRules.push({"field": "collection", "op": "custom", "value": _loginUpid});
                    else if (postid == 3)//铁路专业
                    {
                        if(post=="其他"){
                            var parent = $("#postTree").tree("getParent",selectNode.target);
                            var typeid = parent.typeId;
                            _filterRules.push({"field": "other", "op": "custom", "value": typeid});
                        }
                        else
                            _filterRules.push({"field": "post", "op": "custom", "value": post});
                    }
                    else if (postid == 4)//非铁路专业
                    {
                        var parentNode = $('#postTree').tree('getParent', selectNode.target);
                        _filterRules.push({"field": "type2", "op": "equals", "value": parentNode.text});
                        _filterRules.push({"field": "type3", "op": "equals", "value": selectNode.text});
                    }
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
                    data: {page: pageNumber, rows: pageSize, filterRules: filterRuleStr, sort: _sort, order: _order,upid:_loginUpid},
                    dataType: "json",
                    success: function (r) {
                        if (r.result)
                            $("#tt").datagrid("loadData", r);
                        else
                            $.messager.alert("提示", r.info, "alert");
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "alert");
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
            function openView(bookid) {
                var url = "view?bookid=" + bookid;
                var con = '<iframe src="' + url + '" frameborder="no" width="100%" height="100%" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes"></iframe>';
                $('#view-window').html(con);
                $('#view-window').window({title: '资料查阅', width: '660px', height: '660px'});
                $('#view-window').window('open');
            }
            function bindBigType() {
                $.ajax({
                    type: 'get',
                    url: 'bigType',
                    data: {},
                    dataType: "json",
                    success: function (r) {
                        if (r.result) {
                            r.rows.unshift({"code": "-1", "type": "--所有--"});
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
                $("#cbType2").combobox("loadData", []);
                var bigTypeCode = $("#cbType1").combobox("getValue");
                $.ajax({
                    type: 'get',
                    url: 'smallType',
                    data: {code: bigTypeCode},
                    dataType: "json",
                    success: function (r) {
                        if (r.result) {
                            r.rows.unshift({"code": "-1", "type": "--所有--"});
                            $("#cbType2").combobox("loadData", r.rows);
                            $("#cbType2").combobox("select", r.rows[0].code);
                        } else
                            $.messager.alert("提示", r.info, "alert");
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "alert");
                    }
                });
            }
            function postTreeSelect(node) {
                $("#tt").datagrid("unselectAll");
                if (node.id == "2") {
                    $("#collection").hide();
                    $("#uncollection").show();
                } else {
                    $("#collection").show();
                    $("#uncollection").hide();
                }
                if (!node.children){
                    _searchType = "1";
                    $("#tbTitle").textbox("setValue","");
                    bindData();
                }
            }
            function collectionClick(ty) {
                var selectBooks = $("#tt").datagrid("getChecked");
                var _bookids = "";
//                if(_loginUpid && _loginUpid!=""){
                for (var i = 0; i < selectBooks.length; i++) {
                    var bookid = selectBooks[i].id;
                    _bookids += bookid + ',';
                }
                _bookids = _bookids.substring(0, _bookids.length - 1);
                $.ajax({
                    type: 'post',
                    url: 'collectionBook',
                    data: {bookids: _bookids, userid: _loginUpid, opt: ty},
                    dataType: "json",
                    success: function (r) {
                        $.messager.alert("提示", r.info, "alert");
                        if (r.result)
                            bindData();
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "alert");
                    }
                });
            }
            function datagridRowClick(index,row) {
                $("#tt").datagrid("unselectAll");
                $("#tt").datagrid("selectRow",index);
            }
            function viewWindowClosing() {
                $('#view-window').panel('clear');
            }
            function rowContentClick(e, rowIndex, rowData) {
                if(_loginUpid && _loginUpid!="users"){
                    e.preventDefault();
                    $(this).datagrid('selectRow', rowIndex);
                    $('#menu').menu('show', {left: e.pageX,top: e.pageY});
                }
           }
        </script>
    </head>
    <body>
        <div id='cc' class="easyui-layout" data-options="fit:true">
            <div id="postDiv" data-options="region:'west',split:true" title="学习资料" style="width:300px">
                <ul id="postTree" class="easyui-tree" data-options="onSelect:postTreeSelect"></ul>
            </div>
            <div data-options="region:'center'">
                <table id="tt" title="资料列表" class="easyui-datagrid" data-options="
                       rownumbers:true,
                       fit:true,
                       singleSelect:false,
                       pagination:true,
                       pageSize:20,
                       idField:'id',
                       onSortColumn:bindData,
                       toolbar:'#menuTollbar',
                       onClickRow:datagridRowClick,
                       onRowContextMenu:rowContentClick
                       ">
                    <thead>
                        <tr>
                            <th data-options="field:'ck',checkbox:true"></th>
                            <th data-options="field:'title',width:300,align:'left',halign:'center',sortable:'true'">标题</th>
                            <th data-options="field:'author',width:100,align:'center',halign:'center',sortable:'true'">作者</th>
                            <th data-options="field:'press',width:150,align:'center',halign:'center',sortable:'true'">出版社/单位</th>
                            <th data-options="field:'tdate',width:80,align:'center',halign:'center',formatter:formatDate,sortable:'true'">日期</th>
                            <th data-options="field:'type4',width:100,align:'center',halign:'center',sortable:'true'">类别</th>
                            <th data-options="field:'postcount',width:100,align:'center',halign:'center'">已绑定工种数</th>
                            <th data-options="field:'opt',width:80,align:'center',halign:'center',formatter:formatOptions">在线查阅</th>
                            <th data-options="field:'collection',width:50,align:'center',halign:'center'">收藏</th>
                        </tr>
                    </thead>
                </table>
                <div id="menuTollbar" style="height: auto;">
                    <a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-reload'" onclick="bindData();">刷新</a>
                    <div style="padding:2px;border-top:1px solid #D4D4D4;">
                        <span>标题：</span>
                        <input class="easyui-textbox" style="width:300px" id="tbTitle">
                        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-s-search'" onclick="javascript:_searchType='1';bindData();">当前分类中查询</a>
                        <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-s-search'" onclick="javascript:_searchType='2';bindData();">全部分类中查询</a>
                    </div>
                </div>
            </div>
        </div>

        <div id="view-window" class="easyui-window" title="在线阅读/下载" 
             data-options="modal:true,closed:true,iconCls:'icon-save',minimizable:false,collapsible:false,onBeforeClose:viewWindowClosing" 
             style="width:660px;height:700px;overflow:hidden;">
        </div>

        <div id="menu" class="easyui-menu" style="width: 50px; display: none;">
            <div id="collection" data-options="iconCls:'icon-save'" onclick="collectionClick('collection')">收藏</div>
            <div id="uncollection" data-options="iconCls:'icon-no'" onclick="collectionClick('uncollection')">取消收藏</div>
        </div>
    </body>
</html>
