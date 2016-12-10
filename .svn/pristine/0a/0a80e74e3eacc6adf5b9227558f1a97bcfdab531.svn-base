<%-- 
    Document   : financeview
    Created on : 2016-10-25, 15:26:37
    Author     : Jayang
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<form id="financeviewfrom">
    <h3>费用明细：</h3>
    <div id="info_div">
        <table class="tab" cellpadding="0" cellspacing="0" style="width:100%">
              <tr>
                <th>
                    培训班名称
                </th>
                <td colspan="5" style="text-align: left">
                    <span data-bind="text:cost_name"></span>
                </td>
            </tr>

            <tr>
                <th>
                    培训时间(天数)
                </th>
                <td>
                    <span data-bind="text:cost_days"></span>
                </td>
                <th>
                    培训地点
                </th>
                <td>
                    <span data-bind="text:cost_address"></span>
                </td>
                <th>
                    培训人数
                </th>
                <td>
                    <span data-bind="text:cost_persons"></span>
                </td>
            </tr>
            <tr>
                <th>
                    年度计划（是/否）
                </th>
                <td>
                    <span data-bind="text:is_year_plan>0?'否':'是'"></span>
                </td>
                <th>
                    联系人
                </th>
                <td>
                    <span data-bind="text:cost_user"></span>
                </td>
                <th>
                    联系电话
                </th>
                <td>
                    <span data-bind="text:cost_tell"></span>
                </td>
            </tr>
            <tr>
                <th>
                    教室数
                </th>
                <td colspan="5" style="text-align: left">
                    <span data-bind="text:cost_place_num"></span>
                </td>
            </tr>

        </table>
    </div>
    <div id="type_select_div" style="margin-top: 20px;">
        <label for="plan_post_type">培训类别:</label>
        <span data-bind="text:plan_post_type"></span>
        <label for="plan_type_fee">培训类别:</label>
         <span data-bind="text:plan_type_fee"></span>
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
                <td>
                    <span data-bind="text:books_cost"></span>
                </td>
                <td>
                    <span data-bind="text:books_cost_num"></span>
                </td>
                <td>
                    <span data-bind="text:books_total_fee"></span>
                </td>
            </tr>

            <tr>
                <th>
                    住宿费
                </th>
                <td>
                    <span data-bind="text:hotel_cost"></span>
                </td>
                <td>
                    <span data-bind="text:hotel_cost_num"></span>
                </td>
                <td>
                    <span data-bind="text:hotel_total_fee"></span>
                </td>
            </tr>
            <tr>
                <th>
                    伙食费
                </th>
                <td>
                    <span data-bind="text:meals_cost"></span>
                </td>
                <td>
                    <span data-bind="text:meals_cost_num"></span>
                </td>
                <td>
                    <span data-bind="text:meals_total_fee"></span>
                </td>
            </tr>
            <tr>
                <th>
                    资料费
                </th>
                <td>
                    <span data-bind="text:info_cost"></span>
                </td>
                <td>
                    <span data-bind="text:info_cost_num"></span>
                </td>
                <td>
                    <span data-bind="text:info_total_fee"></span>
                </td>
            </tr>
            <tr>
                <th>
                    交通费
                </th>
                <td>
                    <span data-bind="text:traffic_cost"></span>
                </td>
                <td>
                    <span data-bind="text:traffic_cost_num"></span>
                </td>
                <td>
                    <span data-bind="text:traffic_total_fee"></span>
                </td>
            </tr>
            <tr>
                <th>
                    <span>场地租赁费</span>
                </th>
                <td>
                    <span data-bind="text:place_cost"></span>
                </td>
                <td>
                    <span data-bind="text:place_cost_num"></span>
                </td>
                <td>
                    <span data-bind="text:place_total_fee"></span>
                </td>
            </tr>
        </tbody>
    </table>
    <table id="dg_teach" class="easyui-datagrid" title="讲课教师费用" style="width:700px;height:auto;max-height: 200px;"
           data-options="iconCls :'icon-edit',fit:true,singleSelect :true">
        <thead>
            <tr>
                <th data-options="field:'teach_fee_id',width:80,hidden:true">Item ID</th>
                <th data-options="field:'cost_id',width:80,hidden:true">Item ID</th>
                <th data-options="field:'teach_cmt',width:200">教师类型</th>
                <th data-options="field:'teach_fee',width:80,align:'right'">标准</th>
                <th data-options="field:'teach_num',width:80,align:'right'">数量</th>
                <th data-options="field:'teach_fees',width:250">金额（元）</th>
            </tr>
        </thead>
    </table>
    <table id="other_fees_tab1" class="easyui-datagrid" title="其他费用" style="width:700px;height:auto;max-height: 200px;"
           data-options="iconCls :'icon-edit',fit:true,singleSelect :true">
        <thead>
            <tr>
                <th data-options="field:'other_id',width:80,hidden:true">Item ID</th>
                <th data-options="field:'cost_id',width:80,hidden:true">Item ID</th>
                <th data-options="field:'other_cmt',width:80">费用说明</th>
                <th data-options="field:'other_cost',width:250">金额（元）</th>
            </tr>
        </thead>
    </table>
</form>
<script type="text/javascript">
  var financeViewModel={
      init:function(){
          var plancode='${plancode}';
          var costid='${costid}';
          $.getJSON('getPlanCosts?plan_code='+plancode+'&cost_id='+costid,function(data){
              var viewModel=ko.mapping.fromJS(data);
              $("#dg_teach").datagrid({data:data.teachfees}); 
              $("#other_fees_tab1").datagrid({data:data.otherfees}); 
              ko.applyBindings(viewModel,$("#financeviewfrom")[0]);
          })       
      }
  }    
  financeViewModel.init();
</script>

