<%-- 
    Document   : edit
    Created on : 2016-12-8, 14:05:28
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<form id="stations_edit_form">
    <table>
        <tr>
            <th>计划名称</th>
            <td><span id="plan_name_t" data-bind="text:plan_name"></span></td>
        </tr>
        <tr>
            <th>单位名称</th>
            <td><span id="unit_name_t" data-bind="text:station_name"></span></td>
        </tr>
        <tr>
            <th>人数</th>
            <td><input type="text" class="easyui-numberbox" id="station_num" name="station_num"/></td>
        </tr>
        <tr>
            <th>备注</th>
            <td><textarea style="width:100%" id="station_cmt" name="station_cmt" cols="4" rows="4" data-bind="value:station_cmt"></textarea></td>
        </tr>
    </table>
    <input type="hidden" id="station_code" name="station_code" value="${stacode}"/>
    <input type="hidden" id="plan_code" name="plan_code"  data-bind="value:plan_code"/>
    <input type="hidden" id="add_user" name="add_user" data-bind="value:add_user"/>
    <input type="hidden" id="station_Id" name="station_Id" data-bind="value:station_Id"/>
    <input type="hidden" id="station_name" name="station_name" data-bind="value:station_name"/>
    <input type="hidden" id="plan_name" name="plan_name" data-bind="value:plan_name"/>
    <script type="text/javascript">
        $(function(){
            var code=$("#station_code").val();
            if(code.length>0)
            {
                $.getJSON('getPer?id='+code,function(data){
                    $("#station_num").numberbox('setValue',data.station_num);
                     var newstaVeiwModel = ko.mapping.fromJS(data);
                     ko.applyBindings(newstaVeiwModel, $("#stations_edit_form")[0]);
                }).error(function(result){
                     $.messager.alert('提示', result, 'info');
                })
            }
        })
    </script>
</form>

