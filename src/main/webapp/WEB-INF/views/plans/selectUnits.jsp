<%-- 
    Document   : selectUnits
    Created on : 2016-11-1, 12:41:04
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <input id="unitselected" class="easyui-combobox" name="unitselected" style="width:100%;"
               data-options="valueField:'u_id',textField:'name',groupField:'system',onSelect:UnitOnselected,editable:false,onChange:UnitsOnChange,multiple:true,url:'getUnitsGroup',method:'get',onLoadSuccess:onunitSucces,onUnselect:onunitUnselect">
        <table id="dg" class="easyui-datagrid" title="站段分配" style="width:700px;height:auto;max-height: 300px;"
               data-options="iconCls :'icon-edit',fit:true,singleSelect :true,toolbar: '#tb_teach',onClickCell:onClickCell,onEndEdit:onEndEdit">
            <thead>
                <tr>

                    <th data-options="field:'station_code',width:80,align:'right',hidden:true">单位名称</th>
                    <th data-options="field:'station_id',width:80,align:'right',hidden:true">单位名称</th>
                    <th data-options="field:'plan_code',width:280,align:'right',hidden:true">单位名称</th>
                    <th data-options="field:'station_name',required:true,width:280,align:'center'">单位名称</th>
                    <!--<th data-options="field:'unit_num',required:true,width:80,align:'right',editor:{type:'numberbox',options:{precision:0,required:true,onChange:flagOnChage1}}">数量</th>-->
                </tr>
            </thead>
        </table>
        <div id="tb_teach" style="height:auto">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-s-save',plain:true" onclick="accept()">保存</a>
        </div>
        <script type="text/javascript">
            var persons = "0";
            $(function () {
                var oldPersons = $("#persnum").val();
                if (oldPersons)
                {

                }
            })
            var editIndex = undefined;
            function endEditing() {
                if (editIndex == undefined) {
                    return true
                }
                if ($('#dg').datagrid('validateRow', editIndex)) {
                    $('#dg').datagrid('endEdit', editIndex);
                    editIndex = undefined;
                    return true;
                } else {
                    return false;
                }
            }
            function onClickCell(index, field) {
                if (editIndex != index) {
                    if (endEditing()) {
                        $('#dg').datagrid('selectRow', index)
                                .datagrid('beginEdit', index);
                        var ed = $('#dg').datagrid('getEditor', {index: index, field: field});
                        if (ed) {
                            ($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
                        }
                        editIndex = index;
                    } else {
                        setTimeout(function () {
                            $('#dg').datagrid('selectRow', editIndex);
                        }, 0);
                    }
                }
            }
            function onEndEdit(index, row) {
//                var ed = $(this).datagrid('getEditor', {
//                    index: index,
//                    field: 'teach_cmt'
//                });
                // row.teach_cmt = $(ed.target).combobox('getText');
            }
            function onunitSucces(data) {
                var data = $("#pervals").val();
                {
                    if (data)
                    {
                        $(this).combobox('setValue', JSON.parse(data));
                        $("#dg").datagrid('loadData', JSON.parse($("#persnum").val()));
                    }
                }
            }
            function removeit() {
                if (editIndex == undefined) {
                    return
                }
                $('#dg').datagrid('cancelEdit', editIndex)
                        .datagrid('deleteRow', editIndex);
                editIndex = undefined;
            }
            function accept() {
                var edits = $("#dg").datagrid('getEditors', $("#dg").datagrid('getRowIndex', $("#dg").datagrid('getSelected')));
                var rows = $("#dg").datagrid('getRows');
                var cunit = $("#dg").datagrid('getSelected');
                var newValue = $(edits[0].target).numberbox('getValue');
                var total = 0;
                $.each(rows, function (index, item) {
                    if (item.unit_num)
                    {
                        if (item.unit_name == cunit.unit_name)
                        {
                            total = (newValue * 1) + (total * 1)
                        } else
                        {
                            total = (item.unit_num * 1) + (total * 1)
                        }
                    }
                })
                if (total > persons)
                {
                    $.messager.alert('提示', '总人数不能大于' + persons, 'info');
                }
                $("#studentnum").textbox('setValue', total);
                if (endEditing()) {
                    $('#dg').datagrid('acceptChanges');
                }
            }
            function reject() {
                $('#dg').datagrid('rejectChanges');
                editIndex = undefined;
            }
            function getChanges() {
                var rows = $('#dg').datagrid('getChanges');
            }
            function UnitOnselected(record) {
                initGrid();
            }
            function onunitUnselect()
            {
                  initGrid();
            }
            function UnitsOnChange(record)
            {
                initGrid();
            }
            function initGrid()
            {
                //var persons = $("#current_persons").val();
                debugger;
                var values = $("#unitselected").combobox('getValues');
                $("#pervals").val(JSON.stringify(values));
                var data = $("#unitselected").combobox('getData');
                var array = [];
                var endArray = [];
                var plancode=$("#plan_code").val()
                $.each(values, function (index, item) {
                    $.each(data, function (index1, item1) {
                        if (item == item1.u_id)
                        {
                            array.push({station_name: item1.name, station_id: item1.u_id, station_code: '', plan_code:plancode});
                        }
                    })
                })
                $("#dg").datagrid('loadData', array);
            }
            function flagOnChage1(newValue, oldValue) {
                var edits = $("#dg").datagrid('getEditors', $("#dg").datagrid('getRowIndex', $("#dg").datagrid('getSelected')));
                var rows = $("#dg").datagrid('getRows');
                var cunit = $("#dg").datagrid('getSelected');
                var total = 0;
                $.each(rows, function (index, item) {
                    if (item.unit_num)
                    {
                        if (item.unit_name == cunit.unit_name)
                        {
                            total = (newValue * 1) + (total * 1)
                        } else
                        {
                            total = (item.unit_num * 1) + (total * 1)
                        }
                    }
                })
                if (total > persons)
                {
                    $.messager.alert('提示', '总人数不能大于' + persons, 'info');
                }
                $("#studentnum").textbox('setValue', total);
            }
        </script>
    </body>
</html>
