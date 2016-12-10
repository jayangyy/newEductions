<%--
    Document   : planview
    Created on : 2016-8-24, 10:04:41
    Author     : Jayang
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
</style>
<body style="background: #ffffff;" class="panel-noscroll">
    <div class="easyui-layout layout easyui-fluid" fit="true" style="width: 100%; height: auto;overflow-y: auto;">
        <!--必须-->
        <div class="panel layout-panel layout-panel-center" id="plansViewForm" style="width: auto; left: 0px; top: 15px;height:auto;">
            <div data-options="region:&#39;center&#39;,title:&#39; &#39;" style="padding: 0px; overflow-x: hidden; width: 100%; height: 410px;" title="" class="panel-body layout-body">
                <div id="myaa" class="easyui-accordion accordion" data-options="multiple:true">
                    <div class="panel" style="width:auto;">
                        <div id="pXm" title="" data-options="iconCls:&#39;icon-save&#39;" style="overflow: auto; padding-left: 10px; padding-bottom: 10px; display: block; width: auto;" class="panel-body accordion-body">
                            <div id="auth_div">
                                <a id="transfer" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" style="display:none;" data-bind="click:__ko_mapping__.authPassed" >审核通过</a>
                                <a id="authfinance" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" style="display:none;" data-bind="click:__ko_mapping__.authFinance" >审核通过</a>
                                <!--<a id="authfinance" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" style="display:none;" data-bind="click:__ko_mapping__.authFinance" >总预算修改</a>-->
                                <a id="transfer_to" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" style="display:none;"  data-bind="click:__ko_mapping__.authTransfer">移送</a>
                                <a id="transfer_from" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" style="margin-left:10px;display:none;"  data-bind="click:__ko_mapping__.authBacktop">返拟稿人</a>
                                <a id="transfer_back" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" style="margin-left:10px;display:none;" data-bind="click:__ko_mapping__.authBackUser">返<span data-bind="text:__ko_mapping__.upuser"></span></a>                                   
                            </div>
                            <div class="tab-title" style="position:relative;">培训计划审批表</div>
                            <div id="xmbh_xm" class="sub-tab-title" style="position:relative;"><span data-bind="text:plan_name"></span></div>
                            <table id="tab_sp_jh" class="tab" cellpadding="0" cellspacing="0">
                                <tbody>
                                    <tr>
                                        <th style="width: 150px;">培训类型</th>
                                        <td style="width: 470px;"><div><span data-bind="text:plan_class"></span></div></td>
                                        <th style="width: 150px;">培训班名</th>
                                        <td style="width: 470px;"><div><span data-bind="text:plan_name"></span></div></td>
                                    </tr>
                                    <tr>
                                        <th style="width: 150px;">专业系统</th>
                                        <td style="width: 470px;"><div><span data-bind="text:plan_prof"></span></div></td>
                                        <th style="width: 150px;">培训人数</th>
                                        <td style="width: 470px;"><div><span data-bind="text:plan_num">3</span></div></td>
                                    </tr>
                                    <tr>
                                        <th style="width: 150px;">培训期数</th>
                                        <td style="width: 470px;"><div><span data-bind="text:plan_periods"></span></div></td>
                                        <th style="width: 150px;">培训对象</th>
                                        <td style="width: 470px;"><div><span data-bind="text:plan_object"></span></div></td>
                                    </tr>
                                    <tr>
                                        <th style="width: 150px;">开始时间</th>
                                        <td style="width: 470px;"><div><span data-bind="text:plan_sdate"></span></div></td>
                                        <th style="width: 150px;">结束时间</th>
                                        <td style="width: 470px;"><div><span <span data-bind="text:plan_edate"></span></div></td>
                                    </tr>
                                    <tr>
                                        <th style="width: 150px;">培训方式</th>
                                        <td style="width: 470px;"><div><span data-bind="text:plan_type"></span></div></td>
                                        <th style="width: 150px;">主办单位</th>
                                        <td style="width: 470px;"><div><span data-bind="text:plan_unit">3</span></div></td>
                                    </tr>
                                    <tr>
                                        <th style="width: 150px;">承办单位</th>
                                        <td style="width: 470px;"><div><span data-bind="text:plan_executeunit">成铁文化传媒总公司</span></div></td>
                                        <th style="width: 150px;">主办单位</th>
                                        <td style="width: 470px;"><div><span data-bind="text:plan_unit">3</span></div></td>
                                    </tr>
                                    <tr>
                                        <th style="width: 150px;max-width: 150px;min-width: 150px;">培训内容</th>
                                        <td id="xmsqdwqz_v_xm" colspan="3" height="150" style="text-align: left; width: 470px;">
                                            <span data-bind="text:plan_cmt"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th style="width: 150px;">落实情况</th>
                                        <td id="lqdwqz_v_xm" colspan="3" height="150" valign="top" style="text-align: left; width: 470px;">
                                            <span data-bind="plan_situation"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th style="width: 150px;">经费</th>
                                        <td style="width: 470px;"><div><span data-bind="text:total_fees"></span></div></td>
                                        <th style="width: 150px;">结算方式</th>
                                        <td style="width: 470px;"><div><span data-bind="text:fees_ways">3</span></div></td>
                                    </tr>
                                    <tr data-isrsc="true" style="display:none">
                                        <th style="width: 150px;">境（内）外培训标识</th>
                                        <td style="width: 470px;"><div><span data-bind="text:plan_abroad"></span></div></td>
                                        <th style="width: 150px;">是否高铁培训</th>
                                        <td style="width: 470px;"><div><span data-bind="text:is_highspeed">3</span></div></td>
                                    </tr>
                                    <tr data-isrsc="true" style="display:none">
                                        <th style="width: 150px;">是否人才库人员培训</th>
                                        <td style="width: 470px;"><div><span data-bind="text:is_personsdb"></span></div></td>
                                        <th style="width: 150px;">培训师资</th>
                                        <td style="width: 470px;"><div><span data-bind="text:station_teaches">3</span></div></td>
                                    </tr>
                                    <tr data-isrsc="true" style="display:none">
                                        <th style="width: 150px;">培训渠道</th>
                                        <td style="width: 470px;"><div><span data-bind="text:station_channel"></span></div></td>
                                        <th style="width: 150px;">培训对象类别</th>
                                        <td style="width: 470px;"><div><span data-bind="text:station_type">3</span></div></td>
                                    </tr>
                                    <tr data-isrsc="true" style="display:none">
                                        <th style="width: 150px;">培训专业类别</th>
                                        <td style="width: 470px;"><div><span data-bind="text:station_prof"></span></div></td>
                                        <th style="width: 150px;">目标线路或项目、工程</th>
                                        <td style="width: 470px;"><div><span data-bind="text:station_line">3</span></div></td>
                                    </tr>
                                    <tr>
                                        <th style="width: 150px;">备注</th>
                                        <td id="lqdwqz_v_xm" colspan="3" height="150" valign="top" style="text-align: left; width: 470px;">
                                            <span data-bind="plan_other_cmt"></span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <table id="tab_sp_jh1" class="tab" cellpadding="0" cellspacing="0" style="width:100%;border-top:0px;">
                                <tbody data-bind="foreach:__ko_mapping__.transfers">
                                    <tr >
                                        <th style="width: 150px;height: 150px;max-height: 150px;max-width: 150px;" >
                                            <span data-bind="text:transfer_to_unit"></span>
                                        </th>
                                        <td colspan="4"  style="height:150px;width: 157px;max-height: 150px;" height="150" >
                                            <div class="f-l dzz">
                                                <div class="txt" style="margin-top:20px;"><span data-bind="text:transfer_url.length>0?trans_status_cmt:''"></span></div>
                                                <div class="time" style="margin-top:20px;" ><span data-bind="text:transfer_url.length>0?transfer_date:''"></span></div>
                                                <div class="man"  style="margin-top:20px;"><span data-bind="text:transfer_url.length>0?transfer_to_user:''"></span></div>
                                                <img data-bind="attr:{src:transfer_url}" border="0"  alt="  " class="z" style="height:145px;margin-top: -110px"></img>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>


                            <div style="padding-left:0px;font-size: 14px;">
                                <a href="#" data-bind="click:__ko_mapping__.inittable2">审核详细</a>  
                                <table id="plantable2"  class="tab2" cellpadding="0" cellspacing="0" >
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
                                            <td  data-bind="text:review_cmt"></td>
                                            <td  data-bind="text:plan_status_cmt"></td>
                                            <td ><a target="_blank" data-bind="attr:{ href: review_url}">查看附件</a></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div style="padding-left: 0px;font-size: 14px;min-height:400px;">
                                <a href="#">班级详细</a>  
                                <table id="plantable5" class="tab2" style="height:100px;overflow: auto;"  cellpadding="0" cellspacing="0" >
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
                                            <td  data-bind="text:classname"></td>
                                            <td  data-bind="text:planunit"></td>
                                            <td data-bind="text:execunit"></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div id="finance_div1" style="padding-left: 0px;font-size: 14px;min-height:400px;">

                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="layout-split-proxy-h"></div><div class="layout-split-proxy-v"></div>
    </div>
    <script type="text/javascript">
        var user = GetUrlObj(window.location.href);
        $(function () {
            planViewModel = {
                $plansTable1: $("#plantable1"),
                $plansTable2: $("#plantable2"),
                $plancode: $("#oplancode").val(),
                $transcode: $("#otransfercode").val(),
                upuser: ko.observable(''),
                upuerid: ko.observable(''),
                upunit: ko.observable(''),
                upuid: ko.observable(''),
                costid: ko.observable(""),
                transfers: ko.observableArray([]),
                plantype: ko.observable("0"),
                init: function () {
                    var self = this;
                    $.getJSON('getPlanInclude?id=' + this.$plancode, function (data) {
                        if (data) {
                            var transarray = [];
                            var keyarray = [];
                            self.plantype(data.traintype);
                            var isfinance = '${isfinance}';
                            var typename = '${typename}';
                            $.each(data.plantranfers, function (inex, item) {
                                if (item.transfer_code == self.$transcode && (item.trans_status * 1) == ${editEnum}) {
                                    self.upuser(item.transfer_from_user);
                                    self.upuerid(item.transfer_from_idcard);
                                    self.upunit(item.transfer_from_unit);
                                    self.upuid(item.transfer_from_unitid);
                                    self.costid(item.cost_id);
                                    if (item.cost_id.length > 0)
                                    {
                                        $("#finance_div1").load('getfinance?cost_id=' + item.cost_id + '&plan_code=' + item.plan_code);
                                    }
                                    $("#class_div").attr('style', 'display:""');
                                    $("#auth_div").attr('style', 'display:""');
                                    $("#transfer_to").attr('style', 'display:""');
                                    $("#transfer_from").attr('style', 'display:""');
                                    $("#transfer_back").attr('style', 'display:""');
                                                                        if (true)
                                    {
                                        if (isfinance== "0"&&item.cost_id.length>0)
                                        {
                                            $("#transfer").attr('style', 'display:none');
                                            $("#authfinance").attr('style', 'display:""'); //切换财务审核通过按钮

                                        } else
                                        {
                                            $("#transfer").attr('style', 'display:""');
                                            $("#authfinance").attr('style', 'display:none');
                                        }
                                    } else
                                    {
                                        $("#transfer").attr('style', 'display:none');
                                    }

                                }

//                                if (typename.length > 0)
//                                {
//                                    alert('2')
//                                    if (typename.indexOf('单位正职领导') >= 0 || typename.indexOf('单位副职领导') >= 0)
//                                    if (true)
//                                    {
//                                        if (isfinance== "0"&&item.cost_id.length>0)
//                                        {
//                                            $("#transfer").attr('style', 'display:none');
//                                            $("#authfinance").attr('style', 'display:""'); //切换财务审核通过按钮
//
//                                        } else
//                                        {
//                                            $("#transfer").attr('style', 'display:""');
//                                            $("#authfinance").attr('style', 'display:none');
//                                        }
//                                    } else
//                                    {
//                                        $("#transfer").attr('style', 'display:none');
//                                    }
//                                }
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
                            var newVeiwModel = ko.mapping.fromJS(data, planViewModel);
                            //需盖公章数目
                            ko.applyBindings(newVeiwModel, $("#plansViewForm")[0]);
                        }
                    }).error(function (errMsg) {
                        $("#edituserForm").attr('disabled', 'disabled');
                        $.messager.alert('提示', "未查到记录，稍后重试！", 'info');
                    })
                },
                inittable2: function () {
                    var self = this;
                    var data = ko.mapping.toJS(this.educlasses())
                    this.__ko_mapping__.$plansTable1.datagrid({
                        data: data
                    });
                },
                getFile: function (o) {
                    ///window.location.href=o.review_url();
                    ///window.frames["frameName"].location.href="action(或你需要的名字).aspx"
                    window.open(o.review_url(), '', 'height=0,width=0')
                },
                formatterFileUrl: function (value, row, index) {
                    return '<a href="' + row.review_url + '">查看附件</a>'
                },
                edureurls: ko.observableArray([])
                , authPassed: function () {
                    var window1 = $('<div/>')
                    window1.dialog({
                        title: '审核',
                        width: 600,
                        height: 300,
                        closed: false,
                        maximizable: true,
                        cache: false,
                        href: "authPassedView?id=" + planViewModel.$plancode + '&tcode=' + planViewModel.$transcode + '&costid=' + planViewModel.costid(),
                        modal: true,
                        onClose:function(){
                           window1.dialog('clear');  
                        },
                        buttons: [{
                                text: '确定',
                                handler: function () {
                                    $.ajax({
                                        url: 'authPassed',
                                        type: 'POST',
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
                                            $("#auth_div").html('');
                                           $("#oplancode").val("");
                                            $('#editDialog').dialog('clear');
                                            $('#editDialog').dialog('close');
                                            searchPlans1();
                                            searchPlans();
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
                authTransfer: function () {
                    var window1 = $('<div/>');
                    window1.dialog({
                        title: '移送',
                        width: 600,
                        height: 450,
                        closed: false,
                        maximizable: true,
                        cache: false,
                        href: "authTransView?id=" + planViewModel.$plancode + '&tcode=' + planViewModel.$transcode + "&cost_code=" + planViewModel.costid(),
                        modal: true,
                        onClose: function () {
                            window1.dialog('clear');
                        },
                        buttons: [{
                                text: '确定',
                                handler: function () {
                                    var formData = window1.find('form').serializeArray();
                                    var users = $("#selectUnitUserGrid").datagrid('getSelections');
                                    var userArray = [];
                                    var reviewArray = [];
                                    var username = '';
                                    var uid = '';
                                    var obj1 = {};
                                    $.each(formData, function (index, item) {
                                        obj1[item.name] = item.value;
                                    })
                                    reviewArray.push(obj1);
                                    var cost_id = $("#cost_id").val();
                                    $.each(users, function (index, item) {
                                        var obj = {transfer_to_unit: item.dwname, transfer_to_uid: item.dwid, transfer_to_idcard: item.em_idcard, transfer_to_user: item.em_name, transfer_from_user: obj1.reviewer, transfer_from_idcard: obj1.idcard, cost_id: cost_id};
                                        userArray.push(obj);
                                    })
                                    var params = {transfer_people: JSON.stringify(userArray), review: JSON.stringify(reviewArray), costid: cost_id}
                                    $.ajax({
                                        url: 'authTransfer',
                                        type: 'POST',
                                        data: params,
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
                                            $("#auth_div").html('');
                                            $("#oplancode").val("");
                                            $('#editDialog').dialog('clear');
                                            $('#editDialog').dialog('close');
                                            searchPlans1();
                                            searchPlans();
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
                authBacktop: function () {
                    //返拟稿人
                    var window1 = $('<div/>')
                    window1.dialog({
                        title: '返拟稿人',
                        width: 600,
                        height: 300,
                        closed: false,
                        maximizable: true,
                        cache: false,
                        href: "backTop?id=" + planViewModel.$plancode + '&tcode=' + planViewModel.$transcode + '&costid=' + planViewModel.costid(),
                        modal: true,
                        onClose:function(){
                           window1.dialog('clear');  
                        },
                        buttons: [{
                                text: '确定',
                                handler: function () {
                                    $.ajax({
                                        url: 'backTopuser',
                                        type: 'POST',
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
                                            $("#auth_div").html('');
                                            $("#oplancode").val("");
                                            $('#editDialog').dialog('clear');
                                            $('#editDialog').dialog('close');
                                            searchPlans1();
                                            searchPlans();
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
                authBackUser: function () {
                    //返上一级
                    var window1 = $('<div/>')
                    window1.dialog({
                        title: '返上一级',
                        width: 600,
                        height: 300,
                        closed: false,
                        maximizable: true,
                        cache: false,
                        href: "backUser?id=" + planViewModel.$plancode + '&tcode=' + planViewModel.$transcode + '&to_user=' + planViewModel.upuser() + '&to_uid=' + planViewModel.upuerid() + '&to_unit=' + planViewModel.upunit() + '&to_unitid=' + planViewModel.upuid(),
                        modal: true,                      
                        onClose:function(){
                           window1.dialog('clear');  
                        },
                        buttons: [{
                                text: '确定',
                                handler: function () {
                                    $.ajax({
                                        url: 'backUpUser',
                                        type: 'POST',
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
                                            $("#auth_div").html('');
                                            $("#oplancode").val("");
                                            $('#editDialog').dialog('clear');
                                            $('#editDialog').dialog('close');
                                            searchPlans1();
                                            searchPlans();
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
                authFinance: function () {
                    //审核财务
                    var window1 = $('<div/>')
                    window1.dialog({
                        title: '审核',
                        width: 600,
                        height: 300,
                        closed: false,
                        maximizable: true,
                        cache: false,
                        href: "authfinance?id=" + planViewModel.$plancode + '&tcode=' + planViewModel.$transcode + '&plantype=' + planViewModel.plantype() + "&costid=" + planViewModel.costid(),
                        modal: true,
                        onClose:function(){
                           window1.dialog('clear');  
                        },
                        buttons: [{
                                text: '确定',
                                handler: function () {
                                    var total_cost = 0 * 1.0;
                                    //讲课费用
                                    var teaches1 = $("#dg_finance").datagrid('getRows');
                                    $.each(teaches1, function (index, item) {
                                        total_cost = total_cost + (item.auth_teach_fees * 1.0);
                                    })
                                    //其他费用                                
                                    var otherfees1 = $("#other_fees_tab2").datagrid('getRows');
                                    $.each(otherfees1, function (index, item) {
                                        total_cost = total_cost + (item.other_cost * 1.0);
                                    })
                                    total_cost = total_cost + ($("#auth_books_fees").numberbox('getValue') * 1.0)
                                            + ($("#auth_hotel_fees").numberbox('getValue') * 1.0) + ($("#auth_meals_fees").numberbox('getValue') * 1.0) + ($("#auth_info_fees").numberbox('getValue') * 1.0)
                                            + ($("#auth_traffic_fees").numberbox('getValue') * 1.0) + ($("#auth_place_fees").numberbox('getValue') * 1.0);
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
                                    formdata.push(obj1);
                                    formdata.push(obj2);
                                    $.ajax({
                                        url: 'authfinPassed',
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
                                            $("#auth_div").html('');
                                            $("#oplancode").val("");
                                            $('#editDialog').dialog('clear');
                                            $('#editDialog').dialog('close');
                                            searchPlans1();
                                            searchPlans();
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
                }
            }
            planViewModel.init();
        })
    </script>


</body>

