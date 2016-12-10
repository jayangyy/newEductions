<%-- 
    Document   : index
    Created on : 2016-12-8, 11:39:49
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="_csrf" content="${_csrf.token}" />
        <meta name="_csrf_header" content="${_csrf.headerName}" />
        <title>站段信息提报管理</title>
    </head>
    <body>
        <form id="stations_form">
            <table id="stations_grid" style="height:100%;min-height: 500px;">
            </table>
            <div id="tb">
                <form id="search_form">
                    <div id="grud_div">
                        <a id="btn" href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-s-del'" onclick="stationsViewModel.removeStas()">删除计划</a>
                    </div>
                    <label for="plan_mainid">
                        <span>单位:</span><input id="sta_unit" class="easyui-combobox" name="sta_unit" style="width:200px;height:30px;"
                                               data-options="valueField:'name',textField:'name',editable:false">
                        计划名称：</lable><input type="text" name="planname" id="planname"  data-options="lable:'计划名称'" />
                        <a id="btnsearch" href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-search'" data-bind="click:stationSearch">搜索</a>
                </form>
            </div>
        </form>
        <%@include file="/WEB-INF/views/jspf/commonjs.jspf"%>
        <script type="text/javascript">
            $(function () {
                anticsrf();
                enterExt("#planname", "#btnsearch");//回车事件
                stationsViewModel = {
                    init: function () {
                        var self = this;
                        ko.applyBindings(stationsViewModel, $("#stations_form")[0]);
                        self.initUnit();
                        self.initTable();
                    },
                    stationUpNum: function (value, row, index) {
                        return "<a href='#' onclick=stationsViewModel.stationEdit('" + row.station_code + "')>修改人数</a>";
                    },
                    stationRemove: function (value, row, index) {
                        return "<a href='#' onclick=stationsViewModel.removeStas()>删除</a>";

                    },
                    stationSearch: function () {
                        var formdata = $("#stations_form").serializeArray();
                        var obj = {};
                        $.each(formdata, function (index, item) {
//                            if (item.name == "plan_mainid") {
//                                if (item.value == "全部") {
//                                    item.value = "";
//                                }
//                            }
                            if (item.name == "sta_unit") {
                                if (item.value == "全部单位") {
                                    item.value = "";
                                }
                            }
                            obj[item.name] = item.value;
                        })
                        $("#stations_grid").datagrid('reload', obj);
                    },
                    stationEdit: function (stacode) {
                        var window1 = $('<div/>')
                        var url = "edit?id=" + stacode;
                        window1.dialog({
                            title: '修改',
                            width: 300,
                            height: 250,
                            maximized: false,
                            maximizable: false,
                            closed: false,
                            cache: false,
                            href: url,
                            modal: true,
                            onClose: function () {
                                window1.dialog('clear');
                            },
                            buttons: [{
                                    text: '确定',
                                    handler: function () {
                                        $.ajax({
                                            url: 'patchPerNum',
                                            type: 'post',
                                            data: window1.find('form').serializeArray(),
                                            dataType: 'json'
                                        }).done(function (result) {
                                            if (!result.result) {
                                                $.messager.alert('提示', result.info, 'info');
                                            } else {
                                                window1.dialog('clear');
                                                window1.dialog('close');
                                                $.messager.show({
                                                    title: '消息提示',
                                                    msg: '执行成功',
                                                    timeout: 2000,
                                                    showType: 'slide'
                                                });
                                                $('#stations_grid').datagrid('reload');
                                            }
                                        }).error(function (errorMsg) {
                                            $.messager.alert('提示', errorMsg, 'info');
                                        })
                                    }
                                }, {
                                    text: '关闭',
                                    handler: function () {
                                        window1.dialog('clear');
                                        window1.dialog('close');
                                    }
                                }]
                        });
                    },
                    initTable: function () {
                        $("#stations_grid").datagrid({
                            url: 'getpPserPaging',
                            title: '站段提报管理',
                            frozenColumns: [[
                                    {field: 'ck', checkbox: true},
                                    {field: 'xx', title: '操作', width: 100, hidden: false, formatter: stationsViewModel.stationUpNum}
//                                    {field: 'x1', title: '删除', width: 100, hidden: false, formatter: stationsViewModel.stationRemove}
                                ]],
                            columns: [[
                                    {field: 'station_code', title: 'd', width: 100, hidden: true},
                                    {field: 'plan_code', title: 'd', width: 100, hidden: true},
                                    {field: 'add_user', title: 'd', width: 100, hidden: true},
                                    {field: 'station_id', title: '单位名称', width: 150, hidden: true, align: 'left'},
                                    {field: 'station_name', title: '单位名称', width: 150, align: 'left'},
                                    {field: 'plan_name', title: '计划名称', width: 150, align: 'left'},
                                    {field: 'station_num', title: '人数', width: 150, align: 'left'},
                                    {field: 'station_cmt', title: '备注', width: 400, align: 'left'}
                                ]],
                            method: 'get', fitColumns: false, fit: true, idField: 'station_code', checkbox: true, toolbar: '#tb', pagination: true, pageNumber: 1, pageSize: 20, sortOrder: 'DESC', sortName: 'plan_code', singleSelect: true
                        })
                    },
                    initUnit: function () {
                        $.getJSON('getUnits?levelId=0&searchType=1&uid=&uname=', function (data) {
                            if (data.length > 0) {
                                $('#sta_unit').combobox({
                                    data: data, onSelect: stationsViewModel.stationSearch
                                });
                                // $('#unitid1').combobox('select', data[0].u_id);
                            }
                        }).error(function (errMsg) {
                            $.messager.alert('提示', "未查到记录，稍后重试！", 'info');
                        })
                    },
                    removeStas: function () {
                        var node = $('#stations_grid').datagrid('getSelected');
                        if (node) {
                            $.messager.confirm('Confirm', '确定删除此计划?', function (r) {
                                if (r) {
                                    $.ajax({
                                        url: 'deltePer?ids=' + node.station_code,
                                        type: 'POST',
                                        dataType: 'json'
                                    }).done(function (result) {
                                        if (!result.result) {
                                            $.messager.alert('提示', result.info, 'info');
                                        }
                                        $('#stations_grid').datagrid('reload');
                                    }).error(function (errorMsg) {
                                        $.messager.alert('提示', errorMsg, 'info');
                                    })
                                }
                            });
                        } else {
                            $.messager.alert('提示', "至少选中一条目录", 'info');
                        }

                    }
                };
                stationsViewModel.init();
            })
        </script>
    </body>
</html>
