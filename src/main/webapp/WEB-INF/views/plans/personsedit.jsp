<%--
    Document   : neweidt
    Created on : 2016-8-30, 16:50:13
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body style="background: #ffffff;" class="panel-noscroll">
        <div class="easyui-layout layout easyui-fluid" fit="true" style="width: 100%; height: auto;overflow-y: auto;">
            <!--<div class="easyui-layout layout easyui-fluid" fit="true" style="width: auto; height: auto;">-->
            <!--必须-->
            <div class="panel layout-panel layout-panel-center" id="plansViewForm" style="width: auto; left: 0px; top: 15px;height:auto;">
                <!--            <div class="panel-header" style="width: auto;"><div class="panel-title">
                                </div><div class="panel-tool">
                                    <a class="panel-tool-collapse" href="javascript:void(0)" style="display: none;"></a>
                                </div>
                            </div>-->
                <form>
                    <input type="hidden" name="plan_class" id="plan_class" value="路局培训" />
                    <input type="hidden" value="" id="plan_prof" name="plan_prof" />
                    <input type="hidden" value="" id="plan_code" name="plan_code" />
                    <div data-options="region:&#39;center&#39;,title:&#39; &#39;" style="padding: 0px; overflow-x: hidden; width: 100%; height: 987px; display: block; " title="" class="panel-body layout-body">
                        <div id="myaa" class="easyui-accordion accordion" data-options="multiple:true">
                            <div class="panel" style="width:auto;">
                                <div class="panel-header accordion-header accordion-header-selected" style="width: 100%; height: 16px;">
                                    <div class="panel-title panel-with-icon">
                                        操作
                                    </div>
                                </div>
                                <div id="pXm" title="" data-options="iconCls:&#39;icon-save&#39;" style="overflow: auto; padding-left: 10px;height: 900px; padding-bottom: 10px; display: block; width: 100%;" class="panel-body accordion-body">
                                    <div>
                                        <a id="transfer" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" style="display:none;" data-bind="click:transfer">移送</a>
                                        <a id="transfercw" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-s-edit'" style="margin-left:10px;display:none;" data-bind="click:transfercw">培训班预算审批</a>
                                        <a id="transfer1" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" style="margin-left:10px;display:none;" data-bind="click:eventEnd">完结</a>
                                        <a id="transfer2" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" style="margin-left:10px;display:none;" data-bind="click:throwPlan">废弃</a>                                       
                                    </div>
                                    <div id="other_oper">
                                        <!--其他单位专有操作-->
                                    </div>
                                    <div class="tab-title" style="position:relative;">年度干部培训建议计划</div>
                                    <div id="xmbh_xm" class="sub-tab-title" style="position:relative;">
                                    </div>
                                    <table id="tab_sp_jh" class="tab" cellpadding="0" cellspacing="0" style='width:100%'>
                                        <tbody>
                                            <tr>
                                                <th style="width: 150px;min-width: 150px;">
                                                    <span>培训类型：</span>
                                                </th>
                                                <td colspan='3' style='text-align:left;padding-left: 10px'>
                                                    <select  name="traintype" id="traintype" label="State:" labelPosition="top" style="width:280px;margin-left: -10px;">                                           
                                                    </select>        
                                                </td>
                                            </tr>
                                            <tr>
                                                <th style="width: 150px;min-width: 150px;">
                                                    <span>培训班名：</span>
                                                </th>
                                                <td colspan='3'>
                                                    <input type="text" name="plan_name" id="plan_name" value="" style="height:70%;width:100%" class="easyui-textbox" data-options="iconAlign:'left',required:true,onChange:planViewModel.traintypeChange" />
                                                </td>

                                            </tr>
                                            <tr data-isself='false'>
                                                <th style="width: 150px;">
                                                    <span>专业：</span>
                                                </th>
                                                <td>
                                                    <input id="plan_profid" class="easyui-combobox" name="plan_profid" style="width:280px;" >
                                                </td>
                                                <th style="width: 150px;min-width: 150px;">
                                                    <span>高铁培训标识：</span>
                                                </th>
                                                <td>
                                                    <input id="plan_highspeed" class="easyui-combobox" name="plan_highspeed" style="width:280px;">
                                                </td>
                                            </tr>
                                            <tr data-isself='false'>
                                                <th style="width: 150px;min-width: 150px;">
                                                    <span>培训分类：</span>
                                                </th>
                                                <td>
                                                    <input id="plan_soc_type" class="easyui-combobox" name="plan_soc_type" style="width:280px;">
                                                </td>
                                                <th style="width: 150px;">
                                                    <span>境（内）外培训标识：</span>
                                                </th>
                                                <td>
                                                    <input id="plan_abroad" class="easyui-combobox" name="plan_abroad" style="width:280px;">
                                                </td>
                                            </tr>
                                            <tr>
                                                <th style="width: 150px;min-width: 150px;">
                                                    <span>主办单位：</span>
                                                </th>
                                                <td>
                                                    <input id="plan_unitid" class="easyui-combobox" name="plan_unitid" style="width:280px;" >
                                                    <input type="hidden" name="plan_unit" id="plan_unit" />
                                                </td>
                                                <th style="width: 150px;">
                                                    <span>培训方式：</span>
                                                </th>
                                                <td>
                                                    <select class="easyui-combobox" data-options="editable:false,required:true" name="plan_type" id="plan_type" label="State:" labelPosition="top" style="width:280px;">
                                                        <option value="脱产">脱产</option>
                                                        <option value="半脱产">半脱产</option>
                                                    </select>
                                                </td>

                                            </tr>
                                            <tr data-isself='false'>
                                                <th style="width: 150px;min-width: 150px;" >
                                                    <span>培训对象：</span>
                                                </th>
                                                <td >
                                                    <input type="text" style="height:70%;width:280px;" name="plan_object" id="plan_object" value="" class="easyui-textbox" />
                                                </td>
                                                <th style="width: 150px;" data-isself='false'>
                                                    <span>承办单位：</span>
                                                </th>
                                                <td data-isself='false'>
                                                    <input id="plan_execunitid" class="easyui-combobox" name="plan_execunitid" style="width:280px;"
                                                           data-options="valueField:'u_id',textField:'name',onSelect:planViewModel.excunitSelected,editable:false,required:true,onChange:planViewModel.executedChange">
                                                    <input type="hidden" name="plan_executeunit" id="plan_executeunit" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <th style="width: 150px;min-width: 150px;">
                                                    <span>开始日期：</span>
                                                </th>
                                                <td>
                                                    <input class="easyui-datetimebox" id="plan_sdate" name="plan_sdate" data-options="formatter:planViewModel.myformatter,parser:planViewModel.myparser,editable:false,required:true" labelPosition="top" style="width:280px;">
                                                </td>
                                                <th style="width: 150px;">
                                                    <span>结束日期：</span>
                                                </th>
                                                <td>
                                                    <input class="easyui-datetimebox" id="plan_edate" name="plan_edate" data-options="formatter:planViewModel.myformatter,parser:planViewModel.myparser,editable:false,required:true,validType:'compareDate[plan_sdate]'" labelPosition="top" style="width:280px;">
                                                </td>
                                            </tr>
                                            <tr>
                                                <th style="width: 150px;min-width: 150px;">
                                                    <span>培训人数：</span>
                                                </th>
                                                <td>
                                                    <input type="text" style="height:70%;width:280px;" name="plan_num" id="plan_num" value="" class="easyui-numberbox" data-options="iconAlign:'left',required:true" />
                                                </td>
                                                <th style="width: 150px;" >
                                                    <span>培训天数：</span>
                                                </th>
                                                <td  style="text-align:left;padding-left: 27px;">
                                                    <input type="text" style="height:70%;width:280px;float:left" name="plan_days" id="plan_days" value="" class="easyui-numberbox" data-options="iconAlign:'left',required:true" />
                                                </td>
                                            </tr>
                                            <tr data-isself='false'>                                               
                                                <th style="width: 150px;">
                                                    <span>培训期数：</span>
                                                </th>
                                                <td colspan="4">
                                                    <input type="text"  style="height:100%;width:100%;" name="plan_periods" id="plan_periods" value="" class="easyui-numberbox" />
                                                </td>
                                            </tr>
                                            <tr data-isself='true'>
                                                <th style="width: 150px;min-width: 150px;" >
                                                    <span>是否高铁培训：</span>
                                                </th>
                                                <td>
                                                    <input id="is_highspeed" class="easyui-combobox" name="is_highspeed" style="width:280px;"
                                                           data-options="valueField:'id',textField:'text',data:[{id:'是',text:'是'},{id:'否',text:'否'}],editable:false,required:false">
                                                </td>
                                                <th style="width: 150px;">
                                                    <span>是否人才库人员培训：</span>
                                                </th>
                                                <td>
                                                    <input id="is_personsdb" class="easyui-combobox" name="is_personsdb" style="width:280px;"
                                                           data-options="valueField:'id',textField:'text',data:[{id:'是',text:'是'},{id:'否',text:'否'}],editable:false,required:false">
                                                </td>

                                            </tr>

                                            <tr data-isself='true'>
                                                <th style="width: 150px;min-width: 150px;">
                                                    <span>培训师资：</span>
                                                </th>
                                                <td>
                                                    <input id="station_teaches" class="easyui-combobox" name="station_teaches" style="width:280px;"
                                                           data-options="url:'getStaTeaches',method:'get',valueField:'teach_code',textField:'teach_name',editable:false,required:false">
                                                </td>
                                                <th style="width: 150px;">
                                                    <span>培训渠道：</span>
                                                </th>
                                                <td>
                                                    <input id="station_channel" class="easyui-combobox" name="station_channel" style="width:280px;"
                                                           data-options="url:'getStaChannels',method:'get',valueField:'channel_code',textField:'channel_name',editable:false,required:false">
                                                </td>

                                            </tr>
                                            <tr data-isself='true'>
                                                <th style="width: 150px;min-width: 150px;">
                                                    <span>培训对象类别：</span>
                                                </th>
                                                <td>
                                                    <input id="station_type" class="easyui-combobox" name="station_type" style="width:280px;"
                                                           data-options="url:'getStaPersons',method:'get',valueField:'person_code',textField:'person_name',editable:false,required:false">
                                                </td>
                                                <th style="width: 150px;">
                                                    <span>培训专业类别：</span>
                                                </th>
                                                <td>
                                                    <input id="station_prof" class="easyui-combobox" name="station_prof" style="width:280px;"
                                                           data-options="url:'getStaTypes',method:'get',valueField:'station_code',textField:'station_name',editable:false,required:false">
                                                </td>

                                            </tr>
                                            <tr>
                                                <th>
                                                    培训类别
                                                </th>
                                                <td>

                                                    <select id="plans_post_type" class="easyui-combobox" name="plans_post_type" style="width:200px;" data-options="textField:'text',valueField:'id',required:true,onSelect:postSelected,onLoadSuccess:postOnSuccess">
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th style="width: 150px;min-width: 150px;">
                                                    <span>经费：</span>
                                                </th>
                                                <td>

                                                    <input class="easyui-numberbox" data-options="precision:2,required:true" id="total_fees" name="total_fees" labelPosition="top" style="width:280px;">
                                                </td>
                                                <th style="width: 150px;">
                                                    <span>结算方式：</span>
                                                </th>
                                                <td>
                                                    <input class="easyui-textbox" id="fees_ways" name="fees_ways"  labelPosition="top" style="width:280px;">
                                                </td>
                                            </tr>
                                            <tr data-isself='true'>
                                                <th style="width: 150px;min-width: 150px;">
                                                    <span>目标线路或项目、工程：</span>
                                                </th>
                                                <td colspan="4">
                                                    <input type="text" style="height:70%;width:100%;float: left" name="station_line" id="station_line" value="" class="easyui-textbox"  />
                                                </td>
                                            </tr>
                                            <tr>
                                                <th style="width: 150px;min-width: 150px;">
                                                    <span>培训内容：</span>
                                                </th>
                                                <td colspan="4">
                                                    <input type="text" style="height:70%;width:100%;" name="plan_cmt" id="plan_cmt" value="" class="easyui-textbox" data-options="iconAlign:'left',required:true" />
                                                </td>
                                            </tr>
                                            <tr>

                                                <th style="width: 150px;min-width: 150px;">
                                                    <span>备注：</span>
                                                </th>
                                                <td colspan="4">
                                                    <input type="text" style="height:70%;width:100%" name="plan_other_cmt" id="plan_other_cmt" value="" class="easyui-textbox" data-options="iconAlign:'left'" />
                                                </td>
                                            </tr>
                                            <tr id="road_tr"  data-isself='true'>
                                                <th style="width: 150px;min-width: 150px;">
                                                    <span>路外依据：</span>
                                                </th>
                                                <td>
                                                    <input type="text" name="plan_road" id="plan_road" value="" style="width:280px;height:70%" class="easyui-textbox" data-options="iconAlign:'left'" />
                                                </td>
                                                <th style="width: 150px;">
                                                    <span>路外依据附件：</span>
                                                </th>
                                                <td>
                                                    <input type="file" name="uploadroad" id="uploadroad" />
                                                    <span id="uploadurl"></span>   
                                                    <input type="hidden" name="plan_road_url" id="plan_road_url" value=""/>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <table id="tab_sp_jh" class="tab" cellpadding="0" cellspacing="0" style="width:100%;border-top:0px;">
                                        <tbody data-bind="foreach:transfers">
                                            <tr>
                                                <th style="width: 150px;">
                                                    <span data-bind="text:transfer_to_unit"></span>
                                                </th>
                                                <td colspan="4"  style="height:150px;text-align:left;width: 157px" height="150" >
                                                    <div class="f-l dzz" style="border:0px;border-top-color:white;display: inline-block;">
                                                        <div class="txt"><span data-bind="text:transfer_url.length>0?trans_status_cmt:''"></span></div>
                                                        <div class="time"><span data-bind="text:transfer_url.length>0?transfer_date:''"></span></div>
                                                        <div class="man"><span data-bind="text:transfer_url.length>0?transfer_to_user:''"></span></div>
                                                        <img data-bind="attr:{src:transfer_url}" border="0"  alt="  " class="z"></img>
                                                    </div>
                                                </td>

                                            </tr>
                                        </tbody>
                                    </table>
                                    <div id="auth_div" style="padding-left:0px;font-size: 14px;display:none">
                                        <a href="#">审核详细</a>
                                        <table id="plantable2" class="tab2" cellpadding="0" cellspacing="0">
                                            <thead>
                                                <tr>
                                                    <th>
                                                        操作时间
                                                    </th>
                                                    <th>
                                                        操作人
                                                    </th>
                                                    <th>
                                                        意见
                                                    </th>
                                                    <th>
                                                        状态
                                                    </th>
                                                    <th>
                                                        附件
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody data-bind="foreach:edureviews">
                                                <tr>
                                                    <td data-bind="text:review_date"></td>
                                                    <td data-bind="text:reviewer"></td>
                                                    <td data-bind="text:review_cmt"></td>
                                                    <td data-bind="text:plan_status_cmt"></td>
                                                    <td><a target="_blank" data-bind="attr:{ href: review_url}">查看附件</a></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div id="class_div" style="padding-left: 0px;font-size: 14px;min-height:400px;display: none">
                                        <a href="#">班级详细</a>
                                        <table id="plantable5" class="tab2" style="height:100px;overflow: auto;" cellpadding="0" cellspacing="0">
                                            <thead>
                                                <tr>
                                                    <th>
                                                        开始时间
                                                    </th>
                                                    <th>
                                                        结束时间
                                                    </th>
                                                    <th>
                                                        培训班名
                                                    </th>
                                                    <th>
                                                        主办单位
                                                    </th>
                                                    <th>
                                                        承办单位
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody data-bind="foreach:educlasses">
                                                <tr>
                                                    <td data-bind="text:startdate"></td>
                                                    <td data-bind="text:enddate"></td>
                                                    <td data-bind="text:classname"></td>
                                                    <td data-bind="text:planunit"></td>
                                                    <td data-bind="text:execunit"></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <!--</div>-->
                        </div>
                         <input type="hidden" id="end_total_fees" name="end_total_fees"/>
                         <input type="hidden" id="max_cost" name="max_cost" value="0"/>
                </form>

            </div>
            <div class="layout-split-proxy-h"></div><div class="layout-split-proxy-v"></div>
           
        </div>
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
            var planuid = "";
            var token = $("meta[name='_csrf']").attr("content");
            var header = $("meta[name='_csrf_header']").attr("content");
            var plancoed = $("#oplancode").val();
            $(function () {
                $('#uploadroad').uploadify({
                    'swf': '../s/js/uploadify/uploadify.swf',
                    'uploader': 'Upload?_csrf=' + token + '&_csrf_header=' + header,
                    // 'queueID': 'filelist',
                    'buttonText': '选择上传文件',
//                    'queueSizeLimit':1,
                    'auto': true,
                    'onUploadSuccess': function (queueData, data, response) {//每一个文件上传成功后执行
                        if (data == "false")
                        {

                        } else
                        {
                            $("#uploadurl").text(queueData.name + '上传成功!')
                            $("#plan_road_url").val(data);
                        }
                        //  _filenames += _type + "/" + _smalltype + "/" + queueData.name + ",";
                    }
                });
                planViewModel = {
                    $plansTable1: $("#plantable1"),
                    $plansTable2: $("#plantable2"),
                    $plancode: plancoed,
                    plandays: ko.observable("0"),
                    planaddress: ko.observable(""),
                    plannums: ko.observable("0"),
                    isyears: ko.observable("是"),
                    transfers: ko.observableArray([]),
                    plantype: ko.observable("0"),
                    init1: function () {
                        var self = this;
                        if (this.$plancode.length > 0) {
                            //编辑
                            $.getJSON('getPlanInclude?id=' + this.$plancode, function (data) {
                                if (data) {
                                    var newVeiwModel = ko.mapping.fromJS(data, planViewModel);
                                    ko.applyBindings(newVeiwModel, $("#plansViewForm")[0]);
                                }
                            }).error(function (errMsg) {
                                $("#edituserForm").attr('disabled', 'disabled');
                                $.messager.alert('提示', "未查到记录，稍后重试！", 'info');
                            })
                        } else {
                            //新增
                        }

                    },
                    inittable2: function () {
                        var self = this;
                        var data = ko.mapping.toJS(this.educlasses())
                        this.__ko_mapping__.$plansTable1.datagrid({
                            data: data
                        });
                    },
                    formatterFileUrl: function (value, row, index) {
                        return '<a href="' + row.review_url + '">查看附件</a>'
                    },
                    initPlanUnit: function () {
                        $.getJSON('getUnits?searchType=0&uid=&uname=', function (data) {
                            if (data.length > 0) {
                                $('#plan_unitid').combobox({
                                    data: data
                                });
                                if (editObj) {
                                    $('#plan_unitid').combobox('select', editObj.plan_unitid)
                                } else {
                                    $('#plan_unitid').combobox('select', '${companyId}')
                                }
                            }
                        }).error(function (errMsg) {
                            $.messager.alert('提示', "未查到记录，稍后重试！", 'info');
                        })
                    },
                    initExecUnit: function () {
                        $.getJSON('getUnits?searchType=1&uid=&uname=', function (data) {
                            if (data.length > 0) {
                                $('#plan_execunitid').combobox({
                                    data: data
                                });
                                if (editObj) {
                                    $('#plan_execunitid').combobox('select', editObj.plan_execunitid)
                                }
                            }
                        }).error(function (errMsg) {
                            $.messager.alert('提示', "未查到记录，稍后重试！", 'info');
                        })
                    },
                    planunitSelected: function (record) {
                        if (record) {
                            $("#plan_unit").val(record.name);
                        }
                    },
                    profSelected: function (record) {
                        if (record) {
                            $("#plan_prof").val(record.name);

                        }
                    },
                    excunitSelected: function (record) {
                        if (record) {
                            $("#plan_executeunit").val(record.name);

                        }
                    },
                    myparser: function (s) {
                        if (!s)
                            return new Date();
                        var ss = (s.split('-'));
                        var y = parseInt(ss[0], 10);
                        var m = parseInt(ss[1], 10);
                        var d = parseInt(ss[2], 10);
                        if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
                            return new Date(y, m - 1, d);
                        } else {
                            return new Date();
                        }
                    },
                    myformatter: function (date) {
                        var y = date.getFullYear();
                        var m = date.getMonth() + 1;
                        var d = date.getDate();
                        return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d) + " 00:00:00";
                    },
                    gene_num: function (min, max) {
                        return Math.floor(Math.random() * (max - min)) + min;
                    },
                    formatterNum: function (date) {
                        var y = date.getFullYear();
                        var m = date.getMonth() + 1;
                        var d = date.getDate();
                        var mm = date.getTime().toLocaleString();
                        var ds = gene_num(1000, 9999);
                        return y + '' + (m < 10 ? ('0' + m) : m) + '' + ds;
                    },
                    profOnSuccess: function () {
                        if (editObj) {
                            $("#plan_profid").combobox('select', editObj.plan_profid);
                        }
                    },
                    init: function () {
                        var self = this;
                        //解决EASYUI 未及时渲染，相应控件为HTML时候问题
                        $("#plan_unitid").combobox({valueField: 'u_id', textField: 'name', onSelect: planViewModel.planunitSelected, editable: false, required: true, onChange: planViewModel.planuintChange});
                        $("#plan_profid").combobox({valueField: 'id', textField: 'name', url: 'getProf?id=', method: 'get', editable: false, required: true, onSelect: planViewModel.profSelected, onLoadSuccess: planViewModel.profOnSuccess});
                        $("#plan_highspeed").combobox({url: 'getSocFlages', method: 'get', valueField: 'speed_code', textField: 'speed_name', editable: false, required: true});
                        $("#plan_soc_type").combobox({url: 'getSocTypes', method: 'get', valueField: 'social_code', textField: 'social_name', editable: false, required: true});
                        $("#plan_abroad").combobox({url: 'getSocAbroads', method: 'get', valueField: 'abroad_code', textField: 'abroad_type', editable: false, required: true});
                        $('#plan_object').textbox({iconAlign: 'left', required: true});
                        $('#plan_periods').numberbox({iconAlign: 'left', required: true, hidden: false});
                        $("#station_line").textbox({iconAlign: 'left', required: false})
                        if (this.$plancode.length >= 0) {
                            var data = [];
                            var is_station = '${isstation}';
                            if (is_station == 'false') {
                                data = [{id: "3", value: "局培训（干部）"}, {id: "4", value: "站段培训（干部）"}];
                            } else
                            {
                                data = [{id: "4", value: "站段培训（干部）"}];
                            }

                            $("#traintype").combobox({editable: false, required: true, onSelect: planViewModel.trainSelected, data: data, valueField: 'id', textField: 'value'});
                            if (this.$plancode == "") {
                                if (data.length > 1) {
                                    $("#traintype").combobox('select', '3');
                                } else {
                                    $("#traintype").combobox('select', '4');
                                }
                                //新增
                            } else {
                                //编辑
                                $.getJSON('getPlanInclude?id=' + this.$plancode, function (data) {
                                    if (data) {
                                        editObj = data;
                                        $("#classno").textbox('setValue', data.classno);
                                        $("#plan_code").val(data.plan_code);
                                        $("#plan_name").textbox('setValue', data.plan_name);
                                        $("#plan_type").combobox('select', data.plan_type);
                                        ///  $("#execunit").textbox('setValue', data.execunit);
                                        $("#plan_num").numberbox('setValue', data.plan_num);
                                        $("#plan_periods").numberbox('setValue', data.plan_periods);
                                        $("#plan_object").textbox('setValue', data.plan_object);
                                        $("#plan_cmt").textbox('setValue', data.plan_cmt);
                                        $("#plan_class").val(data.plan_class);
                                        $("#plan_sdate").datetimebox('setValue', data.plan_sdate);
                                        $("#plan_edate").datetimebox('setValue', data.plan_edate);
                                        $("#plan_days").textbox('setValue', data.plan_days);
                                        $("#plan_road").textbox('setValue', data.plan_road);
                                        $("#plan_road_url").val(data.plan_road_url);
                                        //$("#plan_situation").textbox('setValue', data.plan_situation);
                                        //planViewModel.initPlanUnit();
                                        ///planViewModel.initExecUnit();
                                        $("#traintype").combobox('select', data.traintype);
                                        $("#plan_profid").combobox('select', editObj.plan_profid);
                                        $("#plan_highspeed").combobox('select', editObj.plan_highspeed);
                                        $("#plan_abroad").combobox('select', editObj.plan_abroad);
                                        $("#plan_gradation").combobox('select', editObj.plan_gradation);
                                        $("#plan_soc_type").combobox('select', editObj.plan_soc_type);
                                        $("#plan_gradation").combobox('select', editObj.plan_gradation);
                                        $("#is_highspeed").combobox('select', editObj.is_highspeed);
                                        $("#is_personsdb").combobox('select', editObj.is_personsdb);
                                        $("#station_type").combobox('select', editObj.station_type);
                                        $("#station_teaches").combobox('select', editObj.station_teaches);
                                        $("#station_channel").combobox('select', editObj.station_channel);
                                        $("#station_prof").combobox('select', editObj.station_prof);
                                        $("#station_line").textbox('setValue', editObj.station_line);
                                        $("#plan_other_cmt").textbox('setValue', editObj.plan_other_cmt);
                                        $("#plan_road_url").val(editObj.plan_road_url);
                                        $("#fees_ways").textbox('setValue', data.fees_ways);
                                        $("#total_fees").numberbox('setValue', data.total_fees);
                                        $("#uploadurl").text("已上传！")
                                        var overStatus = '${statusEnum}';
                                        self.educlasses(data.educlasses);
                                        self.edureviews(data.edureviews);
                                        self.plandays(data.plan_days);
                                        // self.planaddress( data.plan_days);
                                        self.plannums(data.plan_num);
                                        self.plantype(data.traintype);
                                        //需盖公章数目
                                        var transarray = [];
                                        var keyarray = [];
                                        $.each(data.plantranfers, function (inex, item) {
                                            if (item.transfer_code == self.$transcode && !('${statusEnum}'.indexOf(item.trans_status) >= 0)) {
                                                self.upuser(item.transfer_from_user);
                                                self.upuerid(item.transfer_from_idcard);
                                                self.upunit(item.transfer_from_unitid);
                                                self.upuid(item.transfer_from_unit);
                                                $("#transfer").attr('style', 'display:""');
                                                $("#transfer1").attr('style', 'display:""');
                                                $("#transfer2").attr('style', 'display:""');
                                                $("#transfercw").attr('style', 'display:""');
                                                $("#class_div").attr('style', 'display:""');
                                                $("#auth_div").attr('style', 'display:""');
                                                $("#transfer_to").attr('style', 'display:""');
                                                $("#transfer_from").attr('style', 'display:""');
                                                $("#transfer_back").attr('style', 'display:""');
                                            }
                                            if (transarray[item.transfer_to_unit] != null) {
                                                if (transarray[item.transfer_to_unit].transfer_url.length == 0 && item.transfer_url.length > 0) {
                                                    transarray[item.transfer_to_unit] = item;
                                                }
                                            } else {
                                                transarray[item.transfer_to_unit] = item;
                                                keyarray.push(item.transfer_to_unit);
                                            }
                                        })
                                        var endarray = [];
                                        for (var i = 0; i < keyarray.length; i++) {
                                            endarray.push(transarray[keyarray[i]]);
                                        }
                                        $.each(endarray, function (index, item) {
                                            $.each(data.edureviews, function (index, item1) {
                                                if (item.transfer_to_unit == item1.current_unit)
                                                {
                                                    if (new Date(item1.review_date) > new Date(item.transfer_date))
                                                    {
                                                        item.transfer_date = item1.review_date;
                                                    }
                                                }

                                            })

                                        })
                                        self.transfers(endarray);
                                        if (overStatus.indexOf(data.plan_status) < 0)
                                        {
                                            $("#transfer").attr('style', 'display:""');
                                            $("#transfer1").attr('style', 'display:""');
                                            $("#transfer2").attr('style', 'display:""');
                                            $("#transfercw").attr('style', 'display:""');
                                            $("#class_div").attr('style', 'display:""');
                                            $("#auth_div").attr('style', 'display:""');
                                        } else
                                        {
                                            $("#transfer").attr('style', 'display:none"');
                                            $("#transfer1").attr('style', 'display:none"');
                                            $("#transfer2").attr('style', 'display:none"');
                                            $("#transfercw").attr('style', 'display:none');
                                            $("#class_div").attr('style', 'display:none"');
                                            $("#auth_div").attr('style', 'display:none"');
                                        }
                                    }
                                }).error(function (errMsg) {
                                    $("#edituserForm").attr('disabled', 'disabled');
                                })
                            }
                        }
                        ko.applyBindings(planViewModel, $("#plansViewForm")[0]);
                    }
                    ,
                    planuintChange: function (newValue, oldVaule) {
                        $("#plan_unit").val($("#plan_unitid").combobox('getText'));
                    },
                    executedChange: function (newValue, oldValue) {
                        debugger;
                        $("#plan_executeunit").val($(this).combobox('getText'));
                    },
                    traintypeChange: function (newValue, oldValue) {
                        $("#plan_class").val($("#traintype").combobox('getText'));
                    },
                    gradationSelected: function (record) {//培训层次选择事件
                        if (record)
                        {
                            $.getJSON('getSocExecs', function (data) {
                                if (data)
                                {
                                    $("#plan_execunitid").combobox('clear').combobox('loadData', data).combobox('select', data[0].u_id);
                                }
                            });
                        }
                    },
                    gradationChange: function (newValue, oldValue) {//培训层次Change事件

                    },
                    transfer: function () {
                        var window1 = $('<div/>')
                        window1.dialog({
                            title: '移送',
                            width: 420,
                            height: 450,
                            closed: false,
                            maximizable: true,
                            cache: false,
                            href: 'selectUser',
                            modal: true,
                            onClose: function () {
                                window1.dialog('clear');
                            },
                            buttons: [{
                                    text: '确定',
                                    handler: function () {
                                        var users = $("#selectUserGrid").datagrid('getSelections');
                                        if (users.length == 0)
                                        {
                                            return;
                                        }
                                        var userArray = [];
                                        $.each(users, function (index, item) {
                                            var obj = {current_unit: item.dwname, current_unitid: item.dwid, review_to_idcard: item.em_idcard, review_to_user: item.em_name};
                                            userArray.push(obj);
                                        })
                                        $.ajax({
                                            url: 'transOfficPlan',
                                            type: 'POST',
                                            data: {prof: JSON.stringify(userArray), plan_code: $("#plan_code").val()},
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
                                                $("#oplancode").val("");
                                                $('#editDialog').dialog('clear');
                                                $('#editDialog').dialog('close');
                                                searchPlans();
                                                searchPlans1();
                                                // $("#transfer").attr('style', 'display:none');
                                            }
                                        }).error(function (errorMsg) {
                                            $.messager.alert('提示', errorMsg, 'info');
                                        })
                                    }
                                }, {
                                    text: '取消',
                                    handler: function () {
                                        window1.dialog('clear');
                                        window1.dialog('close');
                                    }
                                }]
                        });
                    },
                    eventEnd: function () {
                        $.messager.confirm('提示', '确定完结该计划?', function (r) {
                            if (r) {
                                $.ajax({
                                    url: 'overPlan',
                                    type: 'POST',
                                    data: {plan_code: $("#plan_code").val()},
                                    dataType: 'json'
                                }).done(function (result) {
                                    if (!result.result) {
                                        $.messager.alert('提示', result.info, 'info');
                                    } else {
                                        $.messager.show({
                                            title: '消息提示',
                                            msg: '执行成功',
                                            timeout: 2000,
                                            showType: 'slide'
                                        });
                                        $("#transfer").attr('style', 'display:none');
                                        $("#transfer1").attr('style', 'display:none');
                                        $("#transfer2").attr('style', 'display:none');
                                        $("#transfercw").attr('style', 'display:none');
                                        $("#class_div").attr('style', 'display:none');
                                        $("#auth_div").attr('style', 'display:none');
                                        $("#oplancode").val("");
                                        $('#editDialog').dialog('clear');
                                        $('#editDialog').dialog('close');
                                        searchPlans();
                                        searchPlans1();
                                        // $("#transfer").attr('style', 'display:none');
                                    }
                                }).error(function (errorMsg) {
                                    $.messager.alert('提示', errorMsg, 'info');
                                })
                            }
                        });


                    },
                    throwPlan: function () {
                        $.messager.confirm('提示', '确定废弃该计划?', function (r) {
                            if (r) {
                                $.ajax({
                                    url: 'throwPlan',
                                    type: 'POST',
                                    data: {plan_code: $("#plan_code").val()},
                                    dataType: 'json'
                                }).done(function (result) {
                                    if (!result.result) {
                                        $.messager.alert('提示', result.info, 'info');
                                    } else {
                                        $.messager.show({
                                            title: '消息提示',
                                            msg: '执行成功',
                                            timeout: 2000,
                                            showType: 'slide'
                                        });
                                        $("#transfer").attr('style', 'display:none');
                                        $("#transfer1").attr('style', 'display:none');
                                        $("#transfer2").attr('style', 'display:none');
                                        $("#transfercw").attr('style', 'display:none');
                                        $("#class_div").attr('style', 'display:none');
                                        $("#auth_div").attr('style', 'display:none');
                                        $("#oplancode").val("");
                                        $('#editDialog').dialog('clear');
                                        $('#editDialog').dialog('close');
                                        searchPlans();
                                        searchPlans1();
                                        // $("#transfer").attr('style', 'display:none');
                                    }
                                }).error(function (errorMsg) {
                                    $.messager.alert('提示', errorMsg, 'info');
                                })
                            }
                        });

                    },
                    trainSelected: function (record) {
                        if (record)
                        {
                             planViewModel.initTeachType(record.id);
                            if (record.id == "3")
                            {//局办（干部）
                                if (editObj)
                                {
                                    $.getJSON('getSocExecs', function (data) {
                                        if (data)
                                        {
                                            if (editObj.plan_execunitid)
                                            {
                                                $("#plan_execunitid").combobox('clear').combobox('loadData', data).combobox('select', editObj.plan_execunitid);
                                            } else
                                            {
                                                $("#plan_execunitid").combobox('clear').combobox('loadData', data).combobox('select', data[0].u_id);
                                            }

                                        }
                                    });
                                    $.getJSON('getSocMunits', function (data) {
                                        if (data)
                                        {
                                            $("#plan_unitid").combobox('clear').combobox('loadData', data).combobox('select', editObj.plan_unitid);
                                        }
                                    });
                                    $("#plan_object").textbox({required: true, hidden: false}).textbox('setValue', editObj.plan_object);
                                    $("#plan_periods").textbox({required: true, hidden: false, hight: 100}).textbox('setValue', editObj.plan_periods);
                                } else
                                {
                                    $.getJSON('getSocExecs', function (data) {
                                        if (data)
                                        {
                                            $("#plan_execunitid").combobox('clear').combobox('loadData', data).combobox({required: true});
                                        }
                                    });
                                    $.getJSON('getSocMunits', function (data) {
                                        if (data)
                                        {
                                            $("#plan_unitid").combobox('clear').combobox('loadData', data).combobox('setValue', data[0].u_id).combobox('setText', data[0].name);
                                        }
                                    });
                                    $("#plan_object").textbox({required: true, hidden: false}).textbox('setValue', '');
                                    $("#plan_periods").textbox({required: true, hidden: false, hight: 100}).textbox('setValue', '');
                                }
                                $("#tab_sp_jh [data-isself=false]").removeClass('hideInfo').addClass('showInfo');
                                $("#tab_sp_jh [data-isself=true]").removeClass('showInfo').addClass('hideInfo');
                                $("#tab_sp_jh [data-isself=false]").children().removeClass('hideInfo').addClass('showInfo');
                                $("#tab_sp_jh [data-isself=true]").children().removeClass('showInfo').addClass('hideInfo');
                                $("#plan_highspeed").combobox({required: true});
                                $("#plan_profid").combobox({required: true});
                                $("#plan_highspeed").combobox({required: true});
                                $("#plan_soc_type").combobox({required: true});
                                $("#plan_abroad").combobox({required: true});
                                $("#plan_execunitid").combobox({required: true});
                                $('#plan_object').textbox({required: true});
                                $('#plan_periods').numberbox({required: true});
                                $("#station_line").textbox({required: false, hidden: true});
                                $("#plan_road").textbox({hidden: true});
                            } else if (record.id == "4")
                            {
                                debugger;
                                $("#tab_sp_jh [data-isself=true]").removeClass('hideInfo').addClass('showInfo');
                                $("#tab_sp_jh [data-isself=true]").children().removeClass('hideInfo').addClass('showInfo');
                                $("#tab_sp_jh [data-isself=false]").removeClass('showInfo').addClass('hideInfo');
                                $("#tab_sp_jh [data-isself=false]").children().removeClass('showInfo').addClass('hideInfo');
                                if (editObj)
                                {
                                    if (editObj.plan_unitid)
                                    {
                                        debugger;
                                        var parray = [];
                                        parray.push({name: editObj.plan_unit, u_id: editObj.plan_unitid});
                                        $("#plan_unitid").combobox('clear').combobox('loadData', parray).combobox('select', editObj.plan_unitid);
                                    } else
                                    {
                                        $("#plan_unitid").combobox('readonly').combobox('loadData', []);
                                    }
                                    var earray = [];
                                    earray.push({name: editObj.plan_executeunit, u_id: editObj.plan_execunitid});
                                    // $("#plan_execunitid").combobox('loadData', earray).combobox('select',editObj.plan_execunitid).combobox({required: false});
                                    $("#plan_execunitid").combobox('loadData', earray).combobox('select', editObj.plan_execunitid).combobox({required: false});
                                    $("#plan_road").textbox({hidden: false});
                                } else
                                {
                                    $("#plan_unitid").combobox('loadData', [{u_id: '${companyId}', name: '${company}'}]);
                                    $("#plan_unitid").combobox('select', '${companyId}');
                                    $("#plan_execunitid").combobox({required: false}).combobox('loadData', [{u_id: '${companyId}', name: '${company}'}]);
                                    $("#plan_execunitid").combobox('select', '${companyId}');
                                    $("#plan_road").textbox({hidden: false}).textbox('setValue', '');
                                }
                                $("#plan_type").combobox({data: [{id: "脱产", text: '脱产'}, {id: "半脱产", text: '半脱产'}], textField: "text", valueField: 'id'})

                                $("#plan_profid").combobox('unselect').combobox({required: false});
                                $("#plan_highspeed").combobox('unselect').combobox({required: false});
                                $("#plan_soc_type").combobox('unselect').combobox({required: false});
                                $("#plan_abroad").combobox('unselect').combobox({required: false});
                                // $("#plan_execunitid").combobox('unselect').combobox({required: false});
                                ///$("#plan_executeunit").val('');
                                $('#plan_object').textbox('setValue', '0').textbox({required: false});
                                $('#plan_periods').numberbox('setValue', '0').numberbox({required: false});
                                $("#station_line").textbox('setValue', '').textbox({required: false, hidden: false});


                            } else
                            {

                            }
                        }
                    },
                                        initTeachType: function (plantype) {
                        //plan_post_type
                        $.getJSON('getExpenseType?isteach=0&plan_type=' + plantype, function (data) {
                            if (data.length > 0) {
                                var array = [];
                                debugger;
                                $.each(data, function (index, item) {
                                    var max_expense = '0';
                                    if (item.jn_max_expense.length > 0)
                                    {
                                        max_expense = item.jn_max_expense;
                                    } else
                                    {
                                        max_expense = item.jw_max_expense
                                    }
                                    array.push({id: item.posttype, text: item.posttype, jn_max_expense: max_expense});
                                    // array.push({id: item.posttype, text: item.posttype, jn_max_expense: item.jn_max_expense});
                                })
                                $("#plans_post_type").combobox('loadData', array);
                            }
                        });
                    },
                    transfercw: function () {
                        var window1 = $('<div/>')
                        window1.dialog({
                            title: '移送财务审核',
                            width: 990,
                            height: 450,
                            closed: false,
                            maximizable: true,
                            cache: false,
                            href: 'transfinance',
                            modal: true,
                            onClose: function () {
                                window1.dialog('clear');
                            },
                            buttons: [{
                                    text: '确定',
                                    handler: function () {
                                        //移送用户
                                        var users1 = $("#selectUserGrid").datagrid('getSelections');
                                        if (users1.length == 0)
                                        {
                                            return;
                                        }
                                        var userArray = [];
                                        $.each(users1, function (index, item) {
                                            var obj = {current_unit: item.dwname, current_unitid: item.dwid, review_to_idcard: item.em_idcard, review_to_user: item.em_name};
                                            userArray.push(obj);
                                        })
                                        var total_cost = 0;
                                        //讲课费用
                                        var teaches1 = $("#dg").datagrid('getRows');
                                        $.each(teaches1, function (index, item) {
                                            total_cost = total_cost + (item.teach_fees * 1.0);
                                        })
                                        //其他费用                                
                                        var otherfees1 = $("#other_fees_tab").datagrid('getRows');
                                        $.each(otherfees1, function (index, item) {
                                            total_cost = total_cost + (item.other_cost * 1.0);
                                        })
                                        total_cost = total_cost + ($("#books_total_fee").numberbox('getValue') * 1.0)
                                                + ($("#hotel_total_fee").numberbox('getValue') * 1.0) + ($("#meals_total_fee").numberbox('getValue') * 1.0) + ($("#info_total_fee").numberbox('getValue') * 1.0)
                                                + ($("#traffic_total_fee").numberbox('getValue') * 1.0) + ($("#place_total_fee").numberbox('getValue') * 1.0);
                                        $("#total_cost").val(total_cost);
                                        //基本费用          
                                        var formdata = $(window1).find('form').serializeArray();
                                        if (isOutStus())
                                        {
                                            $.messager.alert('提示', '学生费用超过标准!', 'info');
                                            return;
                                        }
                                        var obj1 = {name: 'teaches1', value: ''};
                                        obj1.value = JSON.stringify(teaches1);
                                        var obj2 = {name: 'otherfees1', value: ''};
                                        obj2.value = JSON.stringify(otherfees1);
                                        var obj3 = {name: 'users1', value: ''};
                                        obj3.value = JSON.stringify(userArray);
                                        formdata.push(obj1);
                                        formdata.push(obj2);
                                        formdata.push(obj3);
                                        $.ajax({
                                            url: 'transferfin',
                                            type: 'POST',
                                            data: formdata,
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
                                                $("#oplancode").val("");
                                                $('#editDialog').dialog('clear');
                                                $('#editDialog').dialog('close');
                                                searchPlans();
                                                searchPlans1();
                                                // $("#transfer").attr('style', 'display:none');
                                            }
                                        }).error(function (errorMsg) {
                                            $.messager.alert('提示', errorMsg, 'info');
                                        })
                                    }
                                }, {
                                    text: '取消',
                                    handler: function () {
                                        window1.dialog('clear');
                                        window1.dialog('close');
                                    }
                                }]
                        });
                    },
                    educlasses: ko.observableArray([]),
                    edureviews: ko.observableArray([]),
                    edureurls: ko.observableArray([]),
                    gradationData: ko.observableArray([{id: '0', text: '局办'}, {id: '', text: '站段培训'}])
                }
                planViewModel.init();
            })
            //不能超过定额
            function isOutStus() {
                var max_expense = $("#max_cost").val() * 1.0;
                var totalcost = $("#total_fees").val() * 1.0;
                var persons = $("#plan_num").textbox('getText');
                if ((totalcost / (persons * 1.0)) > max_expense) {
                    return true;
                }
                /// $("#basic_total_cost").val(totalcost);
                return false;
            }
            function postSelected(record) {
                if (record) {
                    debugger;
                    $("#max_cost").val(record.jn_max_expense * 1.0);
                }
            }
            function postOnSuccess(record)
            {
                debugger;
                if (record)
                {
                    if (editObj)
                    {
                        $("#plans_post_type").combobox('select', editObj.plans_post_type);
                    }else
                    {
                        $("#plans_post_type").combobox('select', record[0].id);
                    }
                }
            }
        </script>
        <style>
            .btn-con {
                display: none;
            }
            /*按钮容器*/
            /*审批文件样式--编辑*/
            #spwj_bl {
                list-style: none;
                padding: 0;
                margin: 0;
                height: auto;
            }

            #spwj_bl > li {
                list-style: none;
                float: left;
                position: relative;
                padding: 5px;
                margin-right: 5px;
                border: 1px solid #D2D2D2;
                border-radius: 5px;
            }

            #spwj_bl > li.zw {
                display: none;
            }

            #spwj_bl > li > a.del {
                display: none;
                position: absolute;
                right: -10px;
                top: -5px;
                width: 16px;
                height: 16px;
                font-size: 12px;
            }

            #spwj_bl > li:hover {
                cursor: default;
            }

            #spwj_bl > li:hover > a.del {
                display: block;
                cursor: pointer;
                color: red;
            }
            /*审批文件样式-查看*/
            #qsspwj_v {
                list-style: none;
                padding: 0;
                margin: 0;
                height: auto;
            }

            #qsspwj_v > li {
                list-style: none;
                float: left;
                position: relative;
                padding: 5px;
                margin-right: 5px;
            }

            /*电子章*/
            .dzz {
                position: relative;
                width: 150px;
                height: 150px;
                padding-top: 25px;
                margin-right: 10px;
                box-sizing: border-box;
            }

            .dzz > div {
                position: relative;
                text-align: center;
                margin: 5px 0;
                font-size: 14px;
                z-index: 1;
            }

            .dzz > div.man {
                font-size: 16px;
            }

            .dzz > .z {
                position: absolute;
                width: 100%;
                height: 100%;
                top: 0;
                left: 0;
                z-index: 0;
            }

            td.td-bj {
                width: 90px;
            }
            /*单位报价*/
            .txt-bj {
                width: 80px;
            }
            /*单位报价--文本框*/
            td.td-rz {
                width: 80px;
            }
            /*单位认证*/
            td.td-rz.pass {
                color: green;
            }
            /*认证通过*/
            td.td-rz.unpass {
                color: red;
            }
            /*认证未通过*/
            td.td-bx {
                width: 80px;
            }
            /*比选*/
            td.td-bx.active {
                color: green;
            }
            /*比选--中标单位*/
            /*当前待办字体*/
            .c-red > span {
                color: #980000;
            }
            /*专家组--选择*/
            .zj-btn {
                color: white;
                padding: 5px 10px;
                margin: 5px;
                width: 60px;
                background-color: #A5C2F3;
                border: 2px solid transparent;
            }

            .zj-btn.count {
                width: 110px;
                height: 50px;
                font-size: 30px;
            }

            .zj-btn.active {
                border-color: #ff7a51;
            }

            .zj-view {
                float: left;
                position: relative;
                min-width: 240px;
                margin-left: 10px;
                border: 1px dashed #A5C2F3;
                cursor: default;
            }

            .zj-view:hover > .tool {
                display: block;
            }

            .zj-view > .tool {
                position: absolute;
                display: none;
                top: 1px;
                right: 1px;
            }

            .zj-view > .photo {
                float: left;
                width: 110px;
                height: 130px;
                display: none;
            }

            .zj-view > .detail {
                float: left;
                margin-left: 5px;
                margin-right: 10px;
            }
            .showInfo{
                display: '';
            }
            .hideInfo{
                display: none;
            }
        </style>
    </body>
</html>
