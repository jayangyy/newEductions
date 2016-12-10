<%-- 
    Document   : authfinance
    Created on : 2016-10-25, 15:26:51
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--经费审批-->
<form id="authFinancedForm" style="text-align:left;">
    <table class="doc-table">
        <tr>
            <th>
                <span>审核人：</span>
            </th>
            <td>
                <input type="text" data-bind="value:plan_name" name="reviewer" id="reviewer" value="${user.workername}" style="width:100%;height:30px" class="easyui-textbox" data-options="iconAlign:'left',required:true,editable:false" />              
            </td>
        </tr>
        <tr>
            <th>
                <span>审核选项：</span>
            </th>
            <td>
                <span>审核通过</span> 
                <input id="review_status"  name="review_status" type="hidden" value="${passedEnum}" style="width:370px;" />
            </td>
        </tr>
        <tr>
            <th>
                <span>审核意见：</span>
            </th>
            <td colspan="4" >
                <input type="text"  style="height:70px;width:450px;overflow: auto;" name="review_cmt" id="review_cmt" value="" class="easyui-textbox" data-options="iconAlign:'left',required:false" />
            </td>
        </tr>
        <tr style="display:none">
            <th>附件上传</th>
            <td colspan="3">
                <input type="file" name="upload" id="upload" />
                <span id="uploadurl"></span>   
            </td>
        </tr>
    </table>
    <!--经费申请信息-->
    <h3>费用明细：</h3>
    <div id="info_div">
        <table class="tab" cellpadding="0" cellspacing="0" style="width:100%">
            <tr>
                <th>培训班名称</th>
                <td colspan="5" style="text-align: left">
                    <input type="text"  data-options="required:true"class="easyui-textbox" id="cost_name" name="cost_name" style="width: 100%" />
                </td>
            </tr>
            <tr>
                <th>
                    培训时间(天数)
                </th>
                <td style="text-align: left">
                    <input type="text" data-options="required:true" class="easyui-numberbox" id="cost_days" name="cost_days" />
                </td>
                <th>
                    培训地点
                </th>
                <td style="text-align: left">
                    <input type="text" data-options="required:true" class="easyui-textbox" id="cost_address" name="cost_address" />
                </td>
                <th>
                    培训人数
                </th>
                <td style="text-align: left">
                    <input type="text" data-options="required:true" class="easyui-numberbox" id="cost_persons" name="cost_persons" value="1" />
                </td>
            </tr>
            <tr>
                <th>
                    年度计划（是/否）
                </th>
                <td style="text-align: left">
                    <span data-bind="text:isyears"></span>
                    <!--<input type="" id="is_year_plan" name="is_year_plan" />-->
                    <select id="is_year_plan" class="easyui-combobox" name="is_year_plan" style="width:200px;" data-options="required:true,onLoadSuccess:onyearSelected">
                        <option value="0" >是</option>
                        <option value="1">否</option>
                    </select>
                </td>
                <th>
                    联系人
                </th>
                <td style="text-align: left">
                    <input type="text" class="easyui-textbox" id="cost_user" name="cost_user" />
                </td>
                <th>
                    联系电话
                </th>
                <td style="text-align: left">
                    <input type="text"  class="easyui-textbox" id="cost_tell" name="cost_tell" />
                </td>
            </tr>
            <tr>
                <th>
                    教室数
                </th>
                <td colspan="5" style="text-align: left">
                    <input type="text" class="easyui-numberbox" data-options="required:true" id="cost_place_num" name="cost_place_num" value="1" />
                </td>
            </tr>

        </table>
    </div>
    <div id="type_select_div" style="margin-top: 20px;">
        <label for="plan_post_type">培训类别</label>
        <select id="plan_post_type" class="easyui-combobox" name="plan_post_type" style="width:200px;" data-options="textField:'text',valueField:'id',required:true,onSelect:postSelected">
            <option value="脱产">科级（中级职称）及以上干部培训</option>
            <option value="半脱产">一般干部（初级职称）培训</option>
            <option value="半脱产">其余人员</option>
        </select>
        <label for="plan_type_fee">培训方式</label>
        <select id="plan_type_fee" class="easyui-combobox" name="plan_type_fee" style="width:200px;">
            <option value="脱产">脱产</option>
            <option value="半脱产">半脱产</option>
        </select>
    </div>
    <!--基本费用-->
    <table id="basic_costs" class="tab" cellpadding="0" cellspacing="0" style="margin-top: 10px;width: 100%">
        <thead>
            <tr>
                <th>
                    项目
                </th>
                <th>
                    标准
                </th>
                <th>
                    数量
                </th>
                <th>
                    金额
                </th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <th>
                    <span>教材费</span>
                </th>
                <td style="text-align: left">
                    <input type="text" data-is-flag="true" class="easyui-numberbox" data-options="precision:2,onChange:onStuKeyPress,required:true" id="auth_books_cost" name="auth_books_cost" value="0" />
                </td>
                <td style="text-align: left">
                    <input type="text" data-is-num="true" class="easyui-numberbox" data-options="precision:0,onChange:onStuKeyPress,required:true" id="auth_books_num" name="auth_books_num"  value="0"/>
                </td>
                <td style="text-align: left">
                    <input type="text" data-is-total="true" class="easyui-numberbox" data-options="precision:2,required:true" id="auth_books_fees" name="auth_books_fees" value="0" />
                </td>
            </tr>

            <tr>
                <th>
                    住宿费
                </th>
                <td style="text-align: left">
                    <input type="text" data-is-flag="true" class="easyui-numberbox" data-options="precision:2,onChange:onStuKeyPress,required:true" id="auth_hotel_cost" name="auth_hotel_cost"  value="0"/>
                </td>
                <td style="text-align: left">
                    <input type="text" data-is-num="true" class="easyui-numberbox" data-options="precision:0,onChange:onStuKeyPress,required:true" id="atuh_hotel_num" name="atuh_hotel_num" value="0"/>
                </td>
                <td style="text-align: left">
                    <input type="text" data-is-total="true" class="easyui-numberbox" data-options="precision:2,required:true" id="auth_hotel_fees" name="auth_hotel_fees" value="0"/>
                </td>
            </tr>
            <tr>
                <th>
                    伙食费
                </th>
                <td style="text-align: left">
                    <input type="text" data-is-flag="true" class="easyui-numberbox" data-options="precision:2,onChange:onStuKeyPress,required:true" id="auth_meals_cost" name="auth_meals_cost" value="0"/>
                </td>
                <td style="text-align: left">
                    <input type="text" data-is-num="true" class="easyui-numberbox" data-options="precision:0,onChange:onStuKeyPress,required:true" id="auth_meals_num" name="auth_meals_num" value="0" />
                </td>
                <td style="text-align: left">
                    <input type="text" data-is-total="true" class="easyui-numberbox" data-options="precision:2,required:true" id="auth_meals_fees" name="auth_meals_fees" value="0"/>
                </td>
            </tr>
            <tr>
                <th>
                    资料费
                </th>
                <td style="text-align: left">
                    <input type="text" data-is-flag="true" class="easyui-numberbox" data-options="precision:2,onChange:onStuKeyPress,required:true" id="auth_info_cost" name="auth_info_cost" value="0"/>
                </td>
                <td style="text-align: left">
                    <input type="text" data-is-num="true" class="easyui-numberbox" data-options="precision:0,onChange:onStuKeyPress,required:true" id="auth_info_num" name="auth_info_num" value="0"/>
                </td>
                <td style="text-align: left">
                    <input type="text" data-is-total="true" class="easyui-numberbox" data-options="precision:2,required:true" id="auth_info_fees" name="auth_info_fees" value="0"/>
                </td>
            </tr>
            <tr>
                <th>
                    交通费
                </th>
                <td style="text-align: left">
                    <input type="text" data-is-flag="true" class="easyui-numberbox" data-options="precision:2,onChange:onStuKeyPress,required:true" id="auth_traffic_cost" name="auth_traffic_cost" value="0"/>
                </td>
                <td style="text-align: left">
                    <input type="text" data-is-num="true" class="easyui-numberbox" data-options="precision:0,onChange:onStuKeyPress,required:true" id="auth_traffic_num" name="auth_traffic_num" value="0"/>
                </td>
                <td style="text-align: left">
                    <input type="text" data-is-total="true" class="easyui-numberbox" data-options="precision:2,required:true" id="auth_traffic_fees" name="auth_traffic_fees" value="0"/>
                </td>
            </tr>
            <tr>
                <th>
                    <span>场地租赁费</span>
                </th>
                <td style="text-align: left">
                    <input type="text" data-is-flag="true" class="easyui-numberbox" data-options="precision:2,onChange:onStuKeyPress,required:true" id="auth_place_cost" name="auth_place_cost" value="0"/>
                </td>
                <td style="text-align: left">
                    <input type="text" data-is-num="true" class="easyui-numberbox" data-options="precision:0,onChange:onStuKeyPress,required:true" id="auth_place_num" name="auth_place_num" value="0"/>
                </td>
                <td style="text-align: left">
                    <input type="text" data-is-total="true" class="easyui-numberbox" data-options="precision:2,required:true" id="auth_place_fees" name="auth_place_fees" value="0"/>
                </td>
            </tr>
        </tbody>
    </table>
    <table id="dg_finance" class="easyui-datagrid" title="讲课教师费用" style="width:700px;height:auto;max-height: 200px;"
           data-options="iconCls :'icon-edit',fit:true,singleSelect :true,toolbar: '#tb_teach1',onClickCell:onClickCell,onEndEdit:onEndEdit">
        <thead>
            <tr>
                <th data-options="field:'teach_fee_id',width:80,hidden:true">Item ID</th>
                <th data-options="field:'cost_id',width:80,hidden:true">Item ID</th>
                <th data-options="field:'teach_cmt',width:200,
                    formatter:function(value,row){
                    return row.teach_cmt;
                    },
                    editor:{
                    type:'combobox',
                    options:{
                    valueField:'posttype',
                    textField:'posttype',
                    url:'getExpenseType?isteach=1&plan_type=',method:'get',
                    onSelect:teachOnSelected,
                    required:true
                    }
                    }">教师类型</th>
                <th data-options="field:'auth_teach_fee',width:80,align:'right',editor:{type:'numberbox',options:{precision:2,onChange:flagOnChage,required:true}}">标准</th>
                <th data-options="field:'auth_teach_num',width:80,align:'right',editor:{type:'numberbox',options:{precision:0,onChange:flagOnChage,required:true}}">数量</th>
                <th data-options="field:'auth_teach_fees',width:250,editor:{type:'numberbox',options:{precision:2,required:true}}">金额（元）</th>
                <th data-options="field:'status',hidden:true,width:60,align:'center',editor:{type:'checkbox',options:{on:'P',off:''}}">Status</th>
            </tr>
        </thead>
    </table>
    <div id="tb_teach1" style="height:auto">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-s-add',plain:true" onclick="append()">添加</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-s-del',plain:true" onclick="removeit()">移除</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-s-save',plain:true" onclick="accept()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">取消</a>
    </div>

    <table id="other_fees_tab2" class="easyui-datagrid" title="其他费用" style="width:700px;height:auto;max-height: 200px;"
           data-options="iconCls :'icon-edit',fit:true,singleSelect :true,toolbar: '#tb_other_fee1',onClickCell:onClickCell1,onEndEdit:onEndEdit1">
        <thead>
            <tr>
                <th data-options="field:'other_id',width:80,hidden:true">Item ID</th>
                <th data-options="field:'cost_id',width:80,hidden:true">Item ID</th>
                <th data-options="field:'other_cmt',width:80,align:'right',editor:{type:'textbox'}">费用说明</th>
                <th data-options="field:'other_cost',width:250,editor:{type:'numberbox',options:{precision:2}}">金额（元）</th>
                <th data-options="field:'status',width:60,align:'center',hidden:true,editor:{type:'checkbox',options:{on:'P',off:''}}">Status</th>
            </tr>
        </thead>
    </table>
    <div id="tb_other_fee1" style="height:auto">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-s-add',plain:true" onclick="append1()">添加</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-s-del',plain:true" onclick="removeit">金额（元）</th>
            <th data-options="field:'status',width:60,align:'center',hidden:true,editor:{type:'checkbox',o1()">移除</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-s-save',plain:true" onclick="accept1()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject1()">取消</a>
    </div>

    <script type="text/javascript">
        $(function () {
            init();

        })
        function onyearSelected() {
            $(this).combobox('select', '0');
        }
        //var edata = [{ id: '兼职教师', text: '兼职教师' }, { id: '外聘教师', text: '外聘教师' }, { id: '外聘教师1', text: '外聘教师1' }];
        function init() {
            initTeachType();
            $("#cur_plan_type").val('${plantype}');
        }
        function initTeachType() {
            //plan_post_type
            $.getJSON('getExpenseType?isteach=0&plan_type=' +${plantype}, function (data) {
                if (data.length > 0) {
                    var array = [];
                    $.each(data, function (index, item) {
                        var max_expense='0';
                        if(item.jn_max_expense.length>0)
                        {
                            max_expense=item.jn_max_expense;
                        }else
                        {
                             max_expense=item.jw_max_expense
                        }
                        array.push({id: item.posttype, text: item.posttype, jn_max_expense: max_expense});
                    })
                    $("#plan_post_type").combobox('loadData', array).combobox('select', array[0].id);
                }
            });
        }
        function postSelected(record) {
            if (record) {
                $("#max_cost").val(record.jn_max_expense * 1.0);
            }
        }
        function teachOnSelected(record) {
            if (record)
            {
                var edits = $("#dg_finance").datagrid('getEditors', $("#dg_finance").datagrid('getRowIndex', $("#dg_finance").datagrid('getSelected')));
                var flag = record.jn_max_expense;
                var flag = 0;
                if (record.posttype.indexOf('外聘') >= 0)
                {
                    flag = (record.jw_max_expense * 1.0) / 4;
                } else
                {
                    flag = record.jn_max_expense;
                }
                $(edits[1].target).numberbox('setValue', flag);
                $(edits[2].target).numberbox('setValue', '1');
                var cost = $(edits[2].target).numberbox('getValue');
                $(edits[3].target).numberbox('setValue', (flag * 1.0) * (cost * 1.0));
            }
        }
        //自动计算输入基本费用
        function onStuKeyPress(newValue, oldValue) {
            var tr = $(this).parent().parent();
            var flag = newValue;
            var num = $(tr).find('[data-is-num=true]').numberbox('getValue');
            if (num) {
                var total = $(tr).find('[data-is-total="true"]').numberbox('setValue', (flag * 1.0) * (num * 1.0));
            }
        }
        //自动计算其他费用
        function onOtherKeyPress() {

        }
        //判断学生是否超过综合定额
        function isOutStus() {
            var max_expense = $("#max_cost").val() * 1.0;
            var totals = $("[data-is-total=true]");
            var totalcost = 0;
            var persons = $("#cost_persons").numberbox('getText');
            $.each(totals, function (index, item) {
                if ($(item).textbox('getText').length > 0) {
                    //auth_place_fees场地租赁不算学生费用
                    if ($(item).attr('id') != 'auth_place_fees')
                    {
                        totalcost += ($(item).textbox('getText') * 1.0);
                    }
                }
            })
            if ((totalcost / (persons * 1.0)) > max_expense) {
                return true;
            }
            $("#basic_total_cost").val(totalcost);
            return false;
        }
        //判断讲课费是否超出标准
        function isOutTeache() {

        }
        function flagOnChage(newValue, oldValue) {
            debugger;
            var edits = $("#dg_finance").datagrid('getEditors', $("#dg_finance").datagrid('getRowIndex', $("#dg_finance").datagrid('getSelected')));
            if (!$(edits[0].target).form('validate')) {
                $.messager.alert('提示', '请先选择教师类型!', 'info');
                return;
            }
            var data = $(edits[0].target).combobox('getData');
            var curTeachFlag = 0;
            if (data.length > 0)
            {
                var cur_post = $(edits[0].target).combobox('getValue')
                $.each(data, function (index, item) {
                    if (item.posttype == cur_post) {
                        if (item.posttype.indexOf('外聘') >= 0)
                        {
                            curTeachFlag = (item.jn_max_expense * 1.0) / 4;//外聘教师按学时标准
                        } else
                        {
                            curTeachFlag = item.jn_max_expense;
                        }
                    }
                });
            }
            var flag = $(edits[1].target).numberbox('getValue');
            var cost = $(edits[2].target).numberbox('getValue');
            if (flag.length > 0 && cost.length > 0) {
                var total = (flag * 1.0) * (cost * 1.0);
                if (curTeachFlag != 0) {
                    if (!(flag <= (curTeachFlag * 1.0))) {
                        $.messager.alert('提示', '费用不能超过：' + curTeachFlag + '!', 'info');
                        return;
                    }
                    $(edits[3].target).numberbox('setValue', total);
                } else
                {
                    $(edits[3].target).numberbox('setValue', total);
                }
            }
        }
        var editIndex = undefined;
        function endEditing() {
            if (editIndex == undefined) {
                return true
            }
            if ($('#dg_finance').datagrid('validateRow', editIndex)) {
                $('#dg_finance').datagrid('endEdit', editIndex);
                editIndex = undefined;
                return true;
            } else {
                return false;
            }
        }
        function onClickCell(index, field) {
            if (editIndex != index) {
                if (endEditing()) {
                    $('#dg_finance').datagrid('selectRow', index)
                            .datagrid('beginEdit', index);
                    var ed = $('#dg_finance').datagrid('getEditor', {index: index, field: field});
                    if (ed) {
                        ($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
                    }
                    editIndex = index;
                } else {
                    setTimeout(function () {
                        $('#dg_finance').datagrid('selectRow', editIndex);
                    }, 0);
                }
            }
        }
        function onEndEdit(index, row) {
            var ed = $(this).datagrid('getEditor', {
                index: index,
                field: 'teach_cmt'
            });
            row.teach_cmt = $(ed.target).combobox('getText');
        }
        function append() {
            if (endEditing()) {
                $('#dg_finance').datagrid('appendRow', {status: 'P'});
                editIndex = $('#dg_finance').datagrid('getRows').length - 1;
                $('#dg_finance').datagrid('selectRow', editIndex)
                        .datagrid('beginEdit', editIndex);
            }
        }
        function removeit() {
            if (editIndex == undefined) {
                return
            }
            $('#dg_finance').datagrid('cancelEdit', editIndex)
                    .datagrid('deleteRow', editIndex);
            editIndex = undefined;
        }
        function accept() {
            if (endEditing()) {
                $('#dg_finance').datagrid('acceptChanges');
            }
        }
        function reject() {
            $('#dg_finance').datagrid('rejectChanges');
            editIndex = undefined;
        }
        function getChanges() {
            var rows = $('#dg_finance').datagrid('getChanges');
            alert(rows.length + ' rows are changed!');
        }
    </script>
    <script type="text/javascript">
        var editIndex1 = undefined;
        function endEditing1() {
            if (editIndex1 == undefined) {
                return true
            }
            if ($('#other_fees_tab2').datagrid('validateRow', editIndex1)) {
                $('#other_fees_tab2').datagrid('endEdit', editIndex1);
                editIndex1 = undefined;
                return true;
            } else {
                return false;
            }
        }
        function onClickCell1(index, field) {
            if (editIndex1 != index) {
                if (endEditing1()) {
                    $('#other_fees_tab2').datagrid('selectRow', index)
                            .datagrid('beginEdit', index);
                    var ed = $('#other_fees_tab2').datagrid('getEditor', {index: index, field: field});
                    if (ed) {
                        ($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
                    }
                    editIndex1 = index;
                } else {
                    setTimeout(function () {
                        $('#other_fees_tab2').datagrid('selectRow', editIndex1);
                    }, 0);
                }
            }
        }
        function onEndEdit1(index, row) {
            var ed = $(this).datagrid('getEditor', {
                index: index,
                field: 'other_id'
            });
            //row.teach_cmt = $(ed.target).combobox('getText');
        }
        function append1() {
            if (endEditing1()) {
                $('#other_fees_tab2').datagrid('appendRow', {status: 'P'});
                editIndex1 = $('#other_fees_tab2').datagrid('getRows').length - 1;
                $('#other_fees_tab2').datagrid('selectRow', editIndex1)
                        .datagrid('beginEdit', editIndex1);
            }
        }
        function removeit1() {
            if (editIndex1 == undefined) {
                return
            }
            $('#other_fees_tab2').datagrid('cancelEdit', editIndex1)
                    .datagrid('deleteRow', editIndex1);
            editIndex1 = undefined;
        }
        function accept1() {
            if (endEditing1()) {
                $('#other_fees_tab2').datagrid('acceptChanges');
            }
        }
        function reject1() {
            $('#other_fees_tab2').datagrid('rejectChanges');
            editIndex1 = undefined;
        }
        function getChanges1() {
            var rows = $('#other_fees_tab2').datagrid('getChanges');
            alert(rows.length + ' rows are changed!');
        }
    </script>

    <input type="hidden" name="review_dcode" id="review_dcode"/>
    <input type="hidden" id="plan_code" name="plan_code"/>
    <input type="hidden" id="plan_status_cmt" name="plan_status_cmt" value="${passedEnumcmt}"/>
    <input type="hidden" id="review_url" name="review_url" value=""/>
    <input type="hidden" id="idcard" name="idcard" value="${user.username}"/>
    <input type="hidden" id="current_unit" name="current_unit" value="${user.company}"/>
    <input type="hidden" id="current_unitid" name="current_unitid" value="${user.companyId}"/>
    <input type="hidden" id="transfer_code" name="transfer_code" value="${transfer_code}"/>
    <input type="hidden" id="cur_plan_type" name="cur_plan_type" />
    <input type="hidden" id="total_cost" name="total_cost"  value="0"/>
    <input type="hidden" id="teach_total_cost" name="teach_total_cost" />
    <input type="hidden" id="basic_total_cost" name="basic_total_cost" />
    <input type="hidden" id="basic_total_cost" name="basic_total_cost" />
    <input type="hidden" id="max_cost" name="max_cost" /> 
    <input type="hidden" id="cost_id" name="cost_id"  value="${'costid'}"/>
    <input type="hidden" id="t_plan_code" name="t_plan_code" />
</form>
<script type="text/javascript">
    $.extend($.fn.validatebox.defaults.rules, {
        canSelected: {
            validator: function (value, param) {
                return $.trim(value).indexOf("--") < 0;
            },
            message: '此节点不能选中'
        }, compareToSDate: {
            validator: function (value, param) {
                return new Date($(param[0]).datetimebox('getValue')) > new Date(value); //注意easyui 时间控制获取值的方式
            },
            message: '不能大于开始日期'
        }
    })
    var editObj = undefined;
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $(function () {
        init();
    })
    function init() {
        var id = $("#oplancode").val();
        if (id.length >= 0) {
            $("#plan_code").val(id);
            initFinance(id, '${costid}');
            //新增
        }
    }
    function initFinance(plancode, costid)
    {
        $.getJSON('getPlanCosts?plan_code=' + plancode + '&cost_id=' + costid, function (data) {
            $("#cost_days").numberbox('setValue', data.cost_days);
            $("#cost_address").textbox('setValue', data.cost_address);
            $("#cost_persons").numberbox('setValue', data.cost_persons);
            $("#is_year_plan").combobox('select', data.is_year_plan);
            $("#cost_user").textbox('setValue', data.cost_user);
            $("#cost_tell").textbox('setValue', data.cost_tell);
            $("#cost_place_num").textbox('setValue', data.cost_place_num);
            $("#plan_post_type").combobox('select', data.plan_post_type);
            $("#plan_type_fee").combobox('select', data.plan_type_fee);
            $("#auth_books_cost").numberbox('setValue', data.auth_books_cost);
            $("#auth_books_num").numberbox('setValue', data.auth_books_num);
            $("#auth_books_fees").numberbox('setValue', data.auth_books_fees);
            $("#auth_place_cost").numberbox('setValue', data.auth_place_cost);
            $("#auth_place_num").numberbox('setValue', data.auth_place_num);
            $("#auth_place_fees").numberbox('setValue', data.auth_place_fees);
            $("#auth_hotel_cost").numberbox('setValue', data.auth_hotel_cost);
            $("#atuh_hotel_num").numberbox('setValue', data.atuh_hotel_num);
            $("#auth_hotel_fees").numberbox('setValue', data.auth_hotel_fees);
            $("#auth_meals_cost").numberbox('setValue', data.auth_meals_cost);
            $("#auth_meals_num").numberbox('setValue', data.auth_meals_num);
            $("#auth_meals_fees").numberbox('setValue', data.auth_meals_fees);
            $("#auth_info_cost").numberbox('setValue', data.auth_info_cost);
            $("#auth_info_num").numberbox('setValue', data.auth_info_num);
            $("#auth_info_fees").numberbox('setValue', data.auth_info_fees);
            $("#auth_traffic_cost").numberbox('setValue', data.auth_traffic_cost);
            $("#auth_traffic_num").numberbox('setValue', data.auth_traffic_num);
            $("#auth_traffic_fees").numberbox('setValue', data.auth_traffic_fees);
            $("#cost_name").textbox('setValue', data.cost_name);
            $("#dg_finance").datagrid('loadData', data.teachfees);
            $("#other_fees_tab2").datagrid('loadData', data.otherfees);
            $("#cost_id").val(data.cost_id);
            $("#total_cost").val(data.total_cost);
        })
    }
    function authLoadSuccess(data)
    {
        $("#review_status").combobox('setValue', data[0].id);
        $("#plan_status_cmt").val(data[0].text);
    }
</script>
