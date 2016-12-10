<%-- 
    Document   : transferfinance
    Created on : 2016-10-18, 11:32:48
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<form>
    <h3>选择移送人：</h3>
    <table id="selectUserGrid" class="easyui-datagrid" style="width:700px;height:350px;display:none;max-height: 350px;"
           data-options="url:'getEmployeePage?searchType=2&offic_unit=职工教育处',method:'get',fitColumns:true,fit:true,idField:'em_idcard',checkbox:true,toolbar:'#tb3',pagination:true,pageNumber:1,pageSize:20,sortOrder:'DESC',sortName:'dwname',singleSelect:true">
        <thead>
            <tr>
                <th data-options="field:'ck',checkbox:true"></th>
                <th data-options="field:'dwid',width:120,align:'center',halign:'center',sortable:'true',hidden:true">单位</th>
                <th data-options="field:'dwname',width:120,align:'center',halign:'center',sortable:'true'">单位</th>
                <th data-options="field:'em_name',width:80,align:'center',halign:'center',sortable:'true'">姓名</th>
                <th data-options="field:'em_idcard',width:140,align:'center',halign:'center',sortable:'true',hidden:true">身份证号码</th>
            </tr>
        </thead>
    </table>
    <div id="tb3">
        <div id="search_user_form1">
            <label for="plan_user_mainid">  单位：</label>
            <input id="offic_unit1" class="easyui-combobox" name="offic_unit1" style="width:150px;"
                   data-options="valueField:'name',textField:'name',onSelect:searchPlanUnit,url:'getOfficUnits?searchType=0&extraunit=职工教育处,财务处,人事处（党委组织部）,${company}',method:'get',editable:false,onLoadSuccess:officUnitSuccess">
            <input id="offic_username" name="offic_username" class="easyui-textbox" style="width:100px;" />
            <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="selectUserSearch()">搜索</a>
        </div>
    </div>
    <script type="text/javascript">
        function searchPlanUnit(record) {
            selectUserSearch();
        }
        function officUnitSuccess(record) {
            if (record) {
                $("#offic_unit1").combobox('select', '职工教育处');
            }
        }
        function selectUserSearch() {
            var formdata = $("#search_user_form1").find(':input').serializeArray();
            var obj = {};
            $.each(formdata, function (index, item) {
                obj[item.name] = item.value;
            })
            if (obj.offic_unit1 == '全部单位') {
                obj.offic_unit1 = '职工教育处';
            }
            $("#selectUserGrid").datagrid('reload', obj);
        }
    </script>
    <h3>费用明细：</h3>
    <label>培训班名</label><input id="cost_sel" name="cost_sel" style="width:150px;">
    <input type="checkbox" id="is_update">
    <div id="finance_edit_div">
        <div id="info_div">
            <table class="tab" cellpadding="0" cellspacing="0" style="width:100%;">
                <tr>
                    <th>培训班名称</th>
                    <td colspan="5" style="text-align: left">
                        <input type="text" class="easyui-textbox" data-options="required:true" id="cost_name" name="cost_name" style="width: 100%" />
                    </td>
                </tr>
                <tr>
                    <th>
                        培训时间(天数)
                    </th>
                    <td style="text-align: left">
                        <input type="text" class="easyui-numberbox" data-options="required:true" id="cost_days" name="cost_days"  value="0"/>
                    </td>
                    <th>
                        培训地点
                    </th>
                    <td style="text-align: left">
                        <input type="text" class="easyui-textbox" id="cost_address" name="cost_address" />
                    </td>
                    <th>
                        培训人数
                    </th>
                    <td style="text-align: left">
                        <input type="text" class="easyui-numberbox" data-options="required:true" id="cost_persons" name="cost_persons" value="1" />
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
                        <input type="text" class="easyui-textbox"  id="cost_user" name="cost_user" />
                    </td>
                    <th>
                        联系电话
                    </th>
                    <td style="text-align: left">
                        <input type="text" class="easyui-textbox" id="cost_tell" name="cost_tell" />
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
               
            </select>
            <label for="plan_type_fee">培训类别</label>
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
                        <input type="text" data-is-flag="true"  class="easyui-numberbox" data-options="precision:2,onChange:onStuKeyPress,required:true" id="books_cost" name="books_cost" value="0" />
                    </td>
                    <td style="text-align: left">
                        <input type="text" data-is-num="true" class="easyui-numberbox" data-options="precision:0,onChange:onStuKeyPress,required:true" id="books_cost_num" name="books_cost_num"  value="0"/>
                    </td>
                    <td style="text-align: left">
                        <input type="text" data-is-total="true" class="easyui-numberbox" data-options="precision:2,required:true" id="books_total_fee" name="books_total_fee" value="0" />
                    </td>
                </tr>

                <tr>
                    <th>
                        住宿费
                    </th>
                    <td style="text-align: left">
                        <input type="text" data-is-flag="true" class="easyui-numberbox" data-options="precision:2,onChange:onStuKeyPress,required:true" id="hotel_cost" name="hotel_cost"  value="0"/>
                    </td>
                    <td style="text-align: left">
                        <input type="text" data-is-num="true" class="easyui-numberbox" data-options="precision:0,onChange:onStuKeyPress,required:true" id="hotel_cost_num" name="hotel_cost_num" value="0"/>
                    </td>
                    <td style="text-align: left">
                        <input type="text" data-is-total="true" class="easyui-numberbox" data-options="precision:2,required:true" id="hotel_total_fee" name="hotel_total_fee" value="0"/>
                    </td>
                </tr>
                <tr>
                    <th>
                        伙食费
                    </th>
                    <td style="text-align: left">
                        <input type="text" data-is-flag="true" class="easyui-numberbox" data-options="precision:2,onChange:onStuKeyPress,required:true" id="meals_cost" name="meals_cost" value="0"/>
                    </td>
                    <td style="text-align: left">
                        <input type="text" data-is-num="true" class="easyui-numberbox" data-options="precision:0,onChange:onStuKeyPress,required:true" id="meals_cost_num" name="meals_cost_num" value="0" />
                    </td>
                    <td style="text-align: left">
                        <input type="text" data-is-total="true" class="easyui-numberbox" data-options="precision:2,required:true" id="meals_total_fee" name="meals_total_fee" value="0"/>
                    </td>
                </tr>
                <tr>
                    <th>
                        资料费
                    </th>
                    <td style="text-align: left">
                        <input type="text" data-is-flag="true" class="easyui-numberbox" data-options="precision:2,onChange:onStuKeyPress,required:true" id="info_cost" name="info_cost" value="0"/>
                    </td>
                    <td style="text-align: left">
                        <input type="text" data-is-num="true" class="easyui-numberbox" data-options="precision:0,onChange:onStuKeyPress,required:true" id="info_cost_num" name="info_cost_num" value="0"/>
                    </td >
                    <td style="text-align: left">
                        <input type="text" data-is-total="true" class="easyui-numberbox" data-options="precision:2,required:true" id="info_total_fee" name="info_total_fee" value="0"/>
                    </td>
                </tr>
                <tr>
                    <th>
                        交通费
                    </th>
                    <td style="text-align: left">
                        <input type="text" data-is-flag="true" class="easyui-numberbox" data-options="precision:2,onChange:onStuKeyPress,required:true" id="traffic_cost" name="traffic_cost" value="0"/>
                    </td>
                    <td style="text-align: left">
                        <input type="text" data-is-num="true" class="easyui-numberbox" data-options="precision:0,onChange:onStuKeyPress,required:true" id="traffic_cost_num" name="traffic_cost_num" value="0"/>
                    </td>
                    <td style="text-align: left">
                        <input type="text" data-is-total="true" class="easyui-numberbox" data-options="precision:2,required:true" id="traffic_total_fee" name="traffic_total_fee" value="0"/>
                    </td>
                </tr>
                <tr>
                    <th>
                        <span>场地租赁费</span>
                    </th>
                    <td style="text-align: left">
                        <input type="text" data-is-flag="true" class="easyui-numberbox" data-options="precision:2,onChange:onStuKeyPress,required:true" id="place_cost" name="place_cost" value="0"/>
                    </td>
                    <td style="text-align: left">
                        <input type="text" data-is-num="true" class="easyui-numberbox" data-options="precision:0,onChange:onStuKeyPress,required:true" id="place_cost_num" name="place_cost_num" value="0"/>
                    </td>
                    <td style="text-align: left">
                        <input type="text" data-is-total="true" class="easyui-numberbox" data-options="precision:2,required:true" id="place_total_fee" name="place_total_fee" value="0"/>
                    </td>
                </tr>
            </tbody>
        </table>
        <table id="dg" class="easyui-datagrid" title="讲课教师费用" style="width:700px;height:auto;max-height: 200px;"
               data-options="iconCls :'icon-edit',fit:true,singleSelect :true,toolbar: '#tb_teach',onClickCell:onClickCell,onEndEdit:onEndEdit">
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
                    <th data-options="field:'teach_fee',required:true,width:80,align:'right',editor:{type:'numberbox',options:{precision:2,onChange:flagOnChage,required:true}}">标准</th>
                    <th data-options="field:'teach_num',required:true,width:80,align:'right',editor:{type:'numberbox',options:{precision:0,onChange:flagOnChage,required:true}}">数量</th>
                    <th data-options="field:'teach_fees',required:true,width:250,editor:{type:'numberbox',options:{precision:2,required:true}}">金额（元）</th>
                    <th data-options="field:'status',required:true,hidden:true,width:60,align:'center',editor:{type:'checkbox',options:{on:'P',off:''}}">Status</th>
                </tr>
            </thead>
        </table>
        <div id="tb_teach" style="height:auto">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-s-add',plain:true" onclick="append()">添加</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-s-del',plain:true" onclick="removeit()">移除</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-s-save',plain:true" onclick="accept()">保存</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">取消</a>
        </div>

        <table id="other_fees_tab" class="easyui-datagrid" title="其他费用" style="width:700px;height:auto;max-height: 200px;"
               data-options="iconCls :'icon-edit',fit:true,singleSelect :true,toolbar: '#tb_other_fee',onClickCell:onClickCell1,onEndEdit:onEndEdit1">
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
        <div id="tb_other_fee" style="height:auto">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-s-add',plain:true" onclick="append1()">添加</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-s-del',plain:true" onclick="removeit1()">移除</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-s-save',plain:true" onclick="accept1()">保存</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject1()">取消</a>
        </div>
    </div>
    <div id="finance_details_div">
    </div>
    <input type="hidden" id="total_cost" name="total_cost"  value="0"/>
    <input type="hidden" id="teach_total_cost" name="teach_total_cost" />
    <input type="hidden" id="basic_total_cost" name="basic_total_cost" />
    <input type="hidden" id="basic_total_cost" name="basic_total_cost" />
    <input type="hidden" id="max_cost" name="max_cost" /> 
    <input type="hidden" id="cost_id" name="cost_id" />
    <input type="hidden" id="t_plan_code" name="t_plan_code" />
</form>
<script type="text/javascript">
    $(function () {
        init();
    })
    function onyearSelected(){
         $(this).combobox('select','0');
    }
    //var edata = [{ id: '兼职教师', text: '兼职教师' }, { id: '外聘教师', text: '外聘教师' }, { id: '外聘教师1', text: '外聘教师1' }];
    function costSelected(record)
    {
        if (record)
        {
            if (record.cost_id == "0")
            {
                $("#cost_id").val("");
                $("#finance_edit_div").attr("style", "display:''");
                $("#finance_details_div").html('').attr("style", 'display:none');
                $("#is_update").attr("style", "display:none");
                $("#is_update")[0].ckecked = false;
            } else
            {
//                $("#cost_id").val(record.cost_id);
//                $("#finance_details_div").attr("style", "display:''");
//                $("#is_update").attr("style", "display:none");
//                $("#is_update")[0].ckecked = false;
//                $("#finance_edit_div").attr("style", 'display:none');
                fillFinance(record.cost_id);
                // $("#finance_details_div").html('').load('getfinance?cost_id=' + record.cost_id + '&plan_code=' + planViewModel.$plancode);
            }
        }
    }
    function fillFinance(cost_id)
    {
        $.getJSON('getPlanCosts?cost_id=' + cost_id + '&plan_code=' + planViewModel.$plancode, function (data) {
            $("#cost_days").numberbox('setValue', data.cost_days);
            $("#cost_address").textbox('setValue', data.cost_address);
            $("#cost_persons").numberbox('setValue', data.cost_persons);
            $("#is_year_plan").combobox('select',data.is_year_plan);
            $("#cost_user").textbox('setValue', data.cost_user);
            $("#cost_tell").textbox('setValue', data.cost_tell);
            $("#cost_place_num").textbox('setValue', data.cost_place_num);
            $("#plan_post_type").combobox('select', data.plan_post_type);
            $("#plan_type_fee").combobox('select', data.plan_type_fee);
            $("#books_cost").numberbox('setValue', data.books_cost);
            $("#books_cost_num").numberbox('setValue', data.books_cost_num);
            $("#books_fees").numberbox('setValue', data.books_fees);
            $("#place_cost").numberbox('setValue', data.place_cost);
            $("#place_cost_num").numberbox('setValue', data.place_cost_num);
            $("#place_fees").numberbox('setValue', data.place_fees);
            $("#hotel_cost").numberbox('setValue', data.hotel_cost);
            $("#hotel_cost_num").numberbox('setValue', data.hotel_cost_num);
            $("#hotel_fees").numberbox('setValue', data.hotel_fees);
            $("#meals_cost").numberbox('setValue', data.meals_cost);
            $("#meals_cost_num").numberbox('setValue', data.meals_cost_num);
            $("#meals_fees").numberbox('setValue', data.meals_fees);
            $("#info_cost").numberbox('setValue', data.info_cost);
            $("#info_cost_num").numberbox('setValue', data.info_cost_num);
            $("#info_fees").numberbox('setValue', data.info_fees);
            $("#traffic_cost").numberbox('setValue', data.traffic_cost);
            $("#traffic_cost_num").numberbox('setValue', data.traffic_cost_num);
            $("#traffic_fees").numberbox('setValue', data.traffic_fees);
            $("#dg").datagrid('loadData', data.teachfees);
            $("#cost_name").textbox('setValue', data.cost_name);
            $("#cost_place_num").textbox('setValue', data.cost_place_num);
            $("#other_fees_tab").datagrid('loadData', data.otherfees);
            $("#cost_id").val(data.cost_id);
            $("#total_cost").val(data.total_cost);
        }).error(function (errmst) {

        })
    }
    function init() {
        initTeachType();
        initFinSelects();
        $("#t_plan_code").val(planViewModel.$plancode);
        $("#cur_plan_type").val(planViewModel.plantype);
    }
    function initFinSelects()
    {
        $("#cost_sel").combobox({
            valueField: 'cost_id',
            textField: 'cost_name',
            onSelect: costSelected,
            url: 'getFinances?plan_code=' + planViewModel.$plancode,
            method: 'get',
            editable: false,
            loadFilter: function (data) {
                data.unshift({cost_id: '0', cost_name: '-请选择-'});
                return data;
            },
            onLoadSuccess: costSuccess
        })
    }
    function costSuccess(record)
    {
        if (record) {
            $("#cost_sel").combobox('select', '0');
        }
    }
    function initTeachType() {
        //plan_post_type
        $.getJSON('getExpenseType?isteach=0&plan_type=' + planViewModel.plantype(), function (data) {
            if (data.length > 0) {
                var array = [];
                debugger;
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
                   // array.push({id: item.posttype, text: item.posttype, jn_max_expense: item.jn_max_expense});
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
        //curTeachFlag = record.jn_max_expense;
        if (record)
        {
            var edits = $("#dg").datagrid('getEditors', $("#dg").datagrid('getRowIndex', $("#dg").datagrid('getSelected')));
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
        var flag = $(tr).find('[data-is-flag=true]').numberbox('getValue');
        if (flag)
        {

        }
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
        debugger;
        var max_expense = $("#max_cost").val() * 1.0;
        var totals = $("[data-is-total=true]");
        var totalcost = 0;
        var persons = $("#cost_persons").textbox('getText');
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
        var edits = $("#dg").datagrid('getEditors', $("#dg").datagrid('getRowIndex', $("#dg").datagrid('getSelected')));
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
                        curTeachFlag = (item.jw_max_expense * 1.0) / 4; //外聘教师按学时标准
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
        var ed = $(this).datagrid('getEditor', {
            index: index,
            field: 'teach_cmt'
        });
        row.teach_cmt = $(ed.target).combobox('getText');
    }
    function append() {
        if (endEditing()) {
            $('#dg').datagrid('appendRow', {status: 'P'});
            editIndex = $('#dg').datagrid('getRows').length - 1;
            $('#dg').datagrid('selectRow', editIndex)
                    .datagrid('beginEdit', editIndex);
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
        alert(rows.length + ' rows are changed!');
    }
</script>
<script type="text/javascript">
    var editIndex1 = undefined;
    function endEditing1() {
        if (editIndex1 == undefined) {
            return true
        }
        if ($('#other_fees_tab').datagrid('validateRow', editIndex1)) {
            $('#other_fees_tab').datagrid('endEdit', editIndex1);
            editIndex1 = undefined;
            return true;
        } else {
            return false;
        }
    }
    function onClickCell1(index, field) {
        if (editIndex1 != index) {
            if (endEditing1()) {
                $('#other_fees_tab').datagrid('selectRow', index)
                        .datagrid('beginEdit', index);
                var ed = $('#other_fees_tab').datagrid('getEditor', {index: index, field: field});
                if (ed) {
                    ($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
                }
                editIndex1 = index;
            } else {
                setTimeout(function () {
                    $('#other_fees_tab').datagrid('selectRow', editIndex1);
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
            $('#other_fees_tab').datagrid('appendRow', {status: 'P'});
            editIndex1 = $('#other_fees_tab').datagrid('getRows').length - 1;
            $('#other_fees_tab').datagrid('selectRow', editIndex1)
                    .datagrid('beginEdit', editIndex1);
        }
    }
    function removeit1() {
        if (editIndex1 == undefined) {
            return
        }
        $('#other_fees_tab').datagrid('cancelEdit', editIndex1)
                .datagrid('deleteRow', editIndex1);
        editIndex1 = undefined;
    }
    function accept1() {
        if (endEditing1()) {
            $('#other_fees_tab').datagrid('acceptChanges');
        }
    }
    function reject1() {
        $('#other_fees_tab').datagrid('rejectChanges');
        editIndex1 = undefined;
    }
    function getChanges1() {
        var rows = $('#other_fees_tab').datagrid('getChanges');
        alert(rows.length + ' rows are changed!');
    }
</script>

