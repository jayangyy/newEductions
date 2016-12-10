<%--
    Document   : planview
    Created on : 2016-8-24, 10:04:41
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="panel-fit">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>完整流程视图</title>
        <link rel="stylesheet" href="../s/js/stepCommon/kfgl.css" />
        <link rel="stylesheet" href="../s/js/stepCommon/uploadify.css" />
        <!--<script type="text/javascript" src="../s/js/stepCommon/all-easyui.js"></script>-->
        <link rel="stylesheet" href="../s/js/stepCommon/common.css" />
        <link rel="stylesheet" href="../s/js/stepCommon/icon.css" />
        <link rel="stylesheet" href="../s/js/stepCommon/color.css" />
        <link rel="stylesheet" href="../s/js/stepCommon/easyui.css" />
        <script src="../s/js/stepCommon/common.js"></script>
        <script src="../s/js/common.js" type="text/javascript"></script>
        <script src="../s/js/stepCommon/jquery.min.js"></script>
        <script src="../s/js/stepCommon/jquery.easyui.min.js"></script>
        <script src="../s/js/stepCommon/jquery-validatebox.js"></script>
        <script src="../s/js/stepCommon/easyui-lang-zh_CN.js"></script>
        <script src="../s/js/ko/ko3.4.js" type="text/javascript"></script>
        <script src="../s/js/ko/knockout.mapping.js" type="text/javascript"></script>
        <!--<script type="text/javascript" src="./完整流程视图_files/allFlowView.js"></script>-->
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
                border-color: white;
                border-width: 0px;
                border-right-width: 0px;
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
    </head>
    <body style="background: #ffffff;" class="panel-noscroll">
        <div class="easyui-layout layout easyui-fluid" fit="true" style="width: auto; height: auto;">
            <!--必须-->
            <div class="panel layout-panel layout-panel-center" id="plansViewForm" style="width: auto; left: 0px; top: 15px;height:auto;">
                <!--            <div class="panel-header" style="width: auto;"><div class="panel-title"> 
                                </div><div class="panel-tool">
                                    <a class="panel-tool-collapse" href="javascript:void(0)" style="display: none;"></a>
                                </div>
                            </div>-->
                <div data-options="region:&#39;center&#39;,title:&#39; &#39;" style="padding: 0px; overflow-x: hidden; width: 100%; height: 530px;" title="" class="panel-body layout-body">
                    <div id="myaa" class="easyui-accordion accordion" data-options="multiple:true">
                        <div class="panel" style="width:auto;">
                            <div id="pXm" title="" data-options="iconCls:&#39;icon-save&#39;" style="overflow-y: scroll; padding-left: 10px; padding-bottom: 10px; display: block; width: auto;" class="panel-body accordion-body">
                                <div class="tab-title" style="position:relative;">培训计划审批表</div>
                                <div id="xmbh_xm" class="sub-tab-title" style="position:relative;"><span data-bind="text:plan_name"></span></div>
                                <table id="tab_sp_jh" class="tab" cellpadding="0" cellspacing="0">
                                    <tbody>
                                        <tr>
                                            <th style="width: 276px;max-width: 276px;min-width: 276px;">培训类型</th>
                                            <td style="width: 470px;"><div><span data-bind="text:plan_class"></span></div></td>
                                            <th style="width: 470px;">培训班名</th>
                                            <td style="width: 470px;"><div><span data-bind="text:plan_name"></span></div></td>
                                        </tr>
                                        <tr>
                                            <th style="width: 276px;max-width: 276px;min-width: 276px;">专业系统</th>
                                            <td style="width: 470px;"><div><span data-bind="text:plan_prof"></span></div></td>
                                            <th style="width: 470px;">培训人数</th>
                                            <td style="width: 470px;"><div><span data-bind="text:plan_num">3</span></div></td>
                                        </tr>
                                        <tr>
                                            <th style="width: 276px;max-width: 276px;min-width: 276px;">培训期数</th>
                                            <td style="width: 470px;"><div><span data-bind="text:plan_periods"></span></div></td>
                                            <th style="width: 470px;">培训对象</th>
                                            <td style="width: 470px;"><div><span data-bind="text:plan_object"></span></div></td>
                                        </tr>
                                        <tr>
                                            <th style="width: 276px;max-width: 276px;min-width: 276px;">开始时间</th>
                                            <td style="width: 470px;"><div><span data-bind="text:plan_sdate"></span></div></td>
                                            <th style="width: 470px;">结束时间</th>
                                            <td style="width: 470px;"><div><span <span data-bind="text:plan_edate"></span></div></td>
                                        </tr>
                                        <tr>
                                            <th style="width: 276px;max-width: 276px;min-width: 276px;">培训方式</th>
                                            <td style="width: 470px;"><div><span data-bind="text:plan_type"></span></div></td>
                                            <th style="width: 470px;">主办单位</th>
                                            <td style="width: 470px;"><div><span data-bind="text:plan_unit">3</span></div></td>
                                        </tr>
                                        <tr>
                                            <th style="width: 276px;max-width: 276px;min-width: 276px;">承办单位</th>
                                            <td style="width: 470px;"><div><span data-bind="text:plan_executeunit">成铁文化传媒总公司</span></div></td>
                                            <th style="width: 470px;">主办单位</th>
                                            <td style="width: 470px;"><div><span data-bind="text:plan_unit">3</span></div></td>
                                        </tr>
                                        <tr>
                                            <th style="width: 276px;max-width: 276px;min-width: 276px;">培训内容</th>
                                            <td id="xmsqdwqz_v_xm" colspan="3" height="150" style="text-align: left; width: 470px;">
                                                <span data-bind="text:plan_cmt"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th style="width: 276px;max-width: 276px;min-width: 276px;">落实情况</th>
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
                                        <tr>
                                            <th style="width: 276px;max-width: 276px;min-width: 276px;">
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
                                    <table id="plantable5" class="tab2" style="height:100px;overflow: hidden;"  cellpadding="0" cellspacing="0" >
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
                    $plancode: user.id,
                    transfers: ko.observableArray([]),
                    init: function () {
                        var self = this;
                        $.getJSON('getPlanInclude?id=' + this.$plancode, function (data) {
                            if (data) {
                                var transarray = [];
                                var keyarray = [];
                                $.each(data.plantranfers, function (inex, item) {
                                    if (transarray[item.transfer_to_unit] != null) {
                                        if (item.transfer_url.length > 0 && transarray[item.transfer_to_unit].transfer_url.length == 0) {
                                            transarray[item.transfer_to_unit] = item;
                                        }
                                    } else {
                                        transarray[item.transfer_to_unit] = item;
                                        keyarray.push(item.transfer_to_unit);
                                    }
                                })
                                var endarray = [];
                                debugger;
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
                    formatterFileUrl: function (value, row, index)
                    {
                        return '<a href="' + row.review_url + '">查看附件</a>'
                    }
                }
                planViewModel.init();
            })
        </script>

    </body>
</html>
