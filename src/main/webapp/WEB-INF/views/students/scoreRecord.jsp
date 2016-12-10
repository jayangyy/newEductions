<%-- 
    Document   : scoreRecord
    Created on : 2016-9-30, 15:29:13
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<form id="record_form">
    <table>
        <tbody>
            <tr>
                <th>
                    姓名：
                </th>
                <td>
                    <span data-bind="text:stu_name"></span>
                    <input type="hidden" data-bind="value:stu_name" id="stu_name" name="stu_name">
                </td>
                <th>
                    身份证号码：
                </th>
                <td>
                    <span data-bind="text:stu_idcard"></span>
                    <input type="hidden" data-bind="value:stu_name" id="stu_idcard" name="stu_idcard">
                </td>
            </tr>
            <tr>
                <th>
                    培训班：
                </th>
                <td>
                    <span data-bind="text:scorerecordViewModel.$classname"></span>
                </td>
            </tr>
            <tr>
                <th>
                    理论成绩：
                </th>
                <td>
                    <input type="text" data-bind="value:stu_phy_points" id="stu_phy_points" name="stu_phy_points">
                </td>
                <th>
                    理论补强成绩：
                </th>
                <td>
                    <input type="text" data-bind="value:stu_bphy_points" id="stu_bphy_url" name="stu_bphy_points">
                </td>
            </tr>
            <tr>
                <th>
                    安全成绩：
                </th>
                <td>
                    <input type="text" data-bind="value:stu_sec_points" id="stu_phy_points" name="stu_sec_points">
                </td>
                <th>
                    安全补强成绩：
                </th>
                <td>
                    <input type="text" data-bind="value:stu_bsec_points" id="stu_bsec_points" name="stu_bsec_points">
                </td>
            </tr>
            <tr>
                <th>
                    实作成绩：
                </th>
                <td>
                    <input type="text" data-bind="value:stu_prac_points" id="stu_prac_points" name="stu_prac_points">
                </td>
            </tr>
        </tbody>
    </table>
    <input type="hidden" id="class_no" name="class_no" data-bind="value:class_no">
        <input type="hidden" id="id" name="id" data-bind="value:id">
</form>
<script type="text/javascript">           
    scorerecordViewModel = {
        $classno:ko.observable(),
        $classname:ko.observable(),
        init:function(){                    
            var self=this;
            scorerecordViewModel.$classname(stuslistViewModel.$classname());
            $.getJSON('getStu?classno='+stuslistViewModel.$classno()+'&stu_idcard='+stuslistViewModel.$stuidcard(),function(data){
                     var newVeiwModel = ko.mapping.fromJS(data, scorerecordViewModel);
                     ko.applyBindings(newVeiwModel, $("#record_form")[0]);             
                   ///  scorerecordViewModel.initClass(data.idcard);
            });               
        },
        initClass:function(){
            $.getJSON('getStuClasses?idcard='+idcard,function(data){
                $("#class_no").combobox('loadData',data);                       
            })
        },
        onClassSuccess:function()
        {
            if(this.$classno.length>0)
            {
                $("#class_no").combobox('select',this.$classno);  
            }
        }
    }
    scorerecordViewModel.init();           
</script>
