<%-- 
    Document   : edit
    Created on : 2016-8-11, 15:20:36
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="_csrf" content="${_csrf.token}"/>
        <meta name="_csrf_header" content="${_csrf.headerName}"/>
        <title>JSP Page</title>

    </head>
    <body>
        <style type="text/css">
            .doc-table {
                border-collapse: collapse;
                border-spacing: 0;
                width: 100%;
                margin-bottom: 1.65em;
            }

            .doc-table th, .doc-table td {
                border: 0px solid #8CACBB;
                padding: 0.1em 0.1em;
                height: 40px;
                text-align: left;
            }

            .doc-table th {
                background: #eee;
            }

            .doc-table pre {
                font-family: Verdana;
                font-size: 12px;
                color: #006600;
                background: #fafafa;
                padding: 5px;
                margin: 12px 0;
                line-height: 120%;
            }

            .doc-table p {
                margin: 14px 0;
                line-height: 100%;
            }

            .doc-table input[type=text] {
                width: 300px;
                height: 100%;
            }

            .textcom {
                height: 100%;
            }
        </style>
        <form id="editClassForm" style="text-align:center;">
            <table class="doc-table">
                <tr>
                    <th>
                        <span>培训班等级:</span>
                    </th>
                    <td colspan="3">
                        <div style="margin-bottom:0px">
                            <select data-options="onSelect:levelSelected,editable:false,onLoadSuccess:levelSuccess,required:true" class="easyui-combobox" name="classlevel" id="classlevel" labonLoadSuccess:levelSuccessel="State:" labelPosition="top" style="width:31.5%;">                          
                                <option value=""></option>
                                <option value="2">路外培训</option>
                                <option value="1">局培训</option>
                                <option value="0">站段培训</option>
                                <option value="4">站段培训(干部)</option>
                                <option value="3">局培训(干部)</option>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>
                        <span>单位:</span>
                    </th>
                    <td style="width:200px;">
                        <input id="unitid" class="easyui-combobox" name="unitid" style="width:100%;"
                               data-options="valueField:'u_id',textField:'name',onSelect:unitidSelected,editable:false,required:true">
                        <input type="hidden" name="unit" id="unit"/>
                    </td>
                    <th>
                        <span>编号:</span>
                    </th>
                    <td>
                        <input type="text" data-bind="value:classno" style="height:70%;" name="classno" id="classno" value="" class="easyui-textbox" data-options="iconAlign:'left',required:true,editable:false" />
                        <input type="hidden" name="id" id="id" data-bind="value:id" value="0" />
                    </td>
                </tr>
                <tr>
                    <th>
                        <span>培训班名称：</span>
                    </th>
                    <td>
                        <input type="text" data-bind="value:classname" name="classname" id="classname" value="" style="width:100%;height:70%" class="easyui-textbox" data-options="iconAlign:'left',required:true" />
                    </td>
                    <th>
                        <span>培训班计划:</span>
                    </th>
                    <td>
                        <input id="cost_id" class="easyui-combobox" name="cost_id" style="width:56%;"
                               data-options="valueField:'cost_id',textField:'cost_name',editable:false,required:true,onSelect:plansSelected">
                    </td>
                </tr>
                <tr>
                    <th>
                        <span>主办单位：</span>
                    </th>
                    <td>
                        <input id="planunitid" class="easyui-combobox" name="planunitid" style="width:100%"
                               data-options="valueField:'u_id',textField:'name',onSelect:planunitSelected,editable:false,required:true">
                        <input type="hidden" name="planunit" id="planunit"/>
                    </td>
                    <th>
                        <span>承办单位：</span>
                    </th>
                    <td>
                        <input id="execunitid" class="easyui-combobox" name="execunitid" style="width:56%"
                               data-options="valueField:'u_id',textField:'name',onSelect:excunitSelected,editable:false,required:true">
                        <input type="hidden" name="execunit" id="execunit"/>
                    </td>
                </tr>
                <tr>
                    <th>
                        <span>部门负责人：</span>
                    </th>
                    <td>
                        <input type="text" style="height:70%;width:100%" data-bind="value:departman" name="departman" id="departman" value="" class="easyui-textbox" data-options="iconAlign:'left',required:true" />
                    </td>
                    <th>
                        <span>项目负责人：</span>
                    </th>
                    <td>
                        <input type="text" style="height:70%;" data-bind="value:projman" name="projman" id="projman" value="" class="easyui-textbox" data-options="iconAlign:'left',required:true" />
                    </td>
                </tr>
                <tr>
                    <th>
                        <span>培训对象：</span>
                    </th>
                    <td>
                        <input type="text" style="height:70%;width:100%" data-bind="value:studentscope" name="studentscope" id="studentscope" value="" class="easyui-textbox" data-options="iconAlign:'left',required:true" />
                    </td>
                    <th>
                        <span>培训形式：</span>
                    </th>
                    <td>
                        <select  class="easyui-combobox" data-options="editable:false,required:true" name="classform" id="classform" label="State:" labelPosition="top" style="width:56%">
                            <option value="脱产">脱产</option>
                            <option value="半脱产">半脱产</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>
                        <span>培训地点：</span>
                    </th>
                    <td>
                        <input type="text" style="height:70%;width:100%" data-bind="value:classplace" name="classplace" id="classplace" value="" class="easyui-textbox" data-options="iconAlign:'left',required:true" />
                    </td>
                    <th>
                        <span>培训依据：</span>
                    </th>
                    <td>     
                        <input type="text" style="height:70%;display:inline-block" data-bind="value:refdoc" name="refdoc" id="refdoc" value="" class="easyui-textbox" data-options="iconAlign:'left',required:true" />
                    </td>
                </tr>
                <tr>
                    <th>培训依据文件上传</th>
                    <td>
                        <input type="file" name="upload" id="upload" />
                        <span id="uploadurl"></span>   
                    </td>
                    <th>履历附件上传</th>
                    <td>
                        <input type="file" name="upload1" id="upload1" />
                        <span id="uploadurl1"></span>   
                    </td>
                </tr>
                <tr>
                    <th>
                        <span>项目书：</span>
                    </th>
                    <td colspan="3">     
                        <textarea cols="6" rows="6" style="width:90%;height:150px;" id="plan_books" name="plan_books"></textarea>
                    </td>
                </tr>

                <tr>
                    <th>
                        <span>开始日期：</span>
                    </th>
                    <td>
                        <input class="easyui-datetimebox" id="startdate" name="startdate" data-options="formatter:myformatter,parser:myparser,editable:false,required:true" label="Select DateTime:" labelPosition="top" style="width:100%;">
                    </td>
                    <th>
                        <span>结束日期：</span>
                    </th>
                    <td>
                        <input class="easyui-datetimebox" id="enddate" name="enddate" data-options="formatter:myformatter,parser:myparser,editable:false,required:true,validType:'compareDate[startdate]'" label="Select DateTime:" labelPosition="top" style="width:56%">
                    </td>
                </tr>
                <tr>
                    <th>
                        <span>报名截止日期：</span>
                    </th>
                    <td>
                        <input class="easyui-datetimebox" id="signenddate" name="signenddate" data-options="formatter:myformatter,parser:myparser,editable:false,required:true,validType:'compareToSDate[startdate]'" label="Select DateTime:" labelPosition="top" style="width:100%">
                    </td>
                    <th>
                        <span>通知日期：</span>
                    </th>
                    <td>
                        <input class="easyui-datetimebox" data-bind="value:telldate" id="telldate" name="telldate" data-options="formatter:myformatter,parser:myparser,editable:false,required:true,validType:'compareToSDate[startdate]'" label="Select DateTime:" labelPosition="top" style="width:56%;">
                    </td>
                </tr>
                <tr>
                    <th>
                        <span>培训人数：</span>
                    </th>
                    <td>
                        <input type="text" style="height:70%;width:100%" data-bind="value:studentnum" name="studentnum" id="studentnum" value="" class="easyui-textbox" data-options="iconAlign:'left',required:true,validType:'isZNumber'" />
                    </td>
                    <th>
                        <span>人天数：</span>
                    </th>
                    <td>
                        <input type="text" style="height:70%;" data-bind="value:studentdays" name="studentdays" id="studentdays" value="" class="easyui-textbox" data-options="iconAlign:'left',required:true,validType:'isZNumber'" />
                    </td>

                </tr>
                <tr>
                    <th>
                        <span>总课时：</span>
                    </th>
                    <td>
                        <input type="text" data-bind="value:classhours" style="height:70%;width:100%" name="classhours" id="classhours" value="" class="easyui-textbox" data-options="iconAlign:'left',required:true,validType:'isZNumber'" />
                    </td>
                    <th>
                        <span>类别：</span>
                    </th>
                    <td>
                        <input id="classtype"  style="width:56%" class="easyui-combobox" name="classtype"
                               data-options="valueField:'text',textField:'text',url:'getTrainings?id=',method:'get',editable:false,required:true,onSelect:classTypeSelected">                         
                    </td>
                </tr>
                <tr>
                    <th>
                        <span>专业：</span>
                    </th>
                    <td>
                        <input id="prof" class="easyui-combobox" name="prof" style="width:100%"
                               data-options="valueField:'name',textField:'name',url:'getProfs?id=',method:'get',editable:false,required:true">
                    </td>
                    <th>
                        <span>是否高铁：</span>
                    </th>
                    <td>
                        <select id="crh" class="easyui-combobox" name="crh" style="width:56%" data-options="editable:false,required:true">
                            <option value="0">否</option>
                            <option value="1">是 </option>
                        </select>
                    </td>

                </tr>
                <tr>
                    <th>
                        <span>新任工种：</span>
                    </th>
                    <td>
                        <input id="newpost" class="easyui-combobox" name="newpost" style="width:100%"
                               data-options="valueField:'post_name',textField:'post_name',url:'getNposts',method:'get',editable:false,validType:['canSelected']">
                    </td>
                    <th>
                        <span></span>
                    </th>
                    <td>
                        <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="showUnits()">分配</a>
                        <input  type="hidden"  id="archivedate" name="archivedate" data-options="hidden:true,formatter:myformatter,parser:myparser,editable:false" label="Select DateTime:" labelPosition="top" style="width:57%">
                    </td>
                </tr>
                <tr>
                    <th>
                        <span>教材1：</span>
                    </th>
                    <td>
                        <input type="text" style="height:70%;width:100%" data-bind="value:book1" name="book1" id="book1" value="" class="easyui-textbox" data-options="iconAlign:'left'" />

                    </td>
                    <th>
                        <span>教材来源1：</span>
                    </th>
                    <td>
                        <input type="text" style="height:70%;" data-bind="value:bookfrom1" name="bookfrom1" id="bookfrom1" value="" class="easyui-textbox" data-options="iconAlign:'left'" />
                    </td>
                </tr>
                <tr>
                    <th>
                        <span>教材2：</span>
                    </th>
                    <td>
                        <input type="text" style="height:70%;width:100%" data-bind="value:book2" name="book2" id="book2" value="" class="easyui-textbox" data-options="iconAlign:'left'" />

                    </td>
                    <th>
                        <span>教材来源2：</span>
                    </th>
                    <td>
                        <input type="text" style="height:70%;" data-bind="value:bookfrom2" name="bookfrom2" id="bookfrom2" value="" class="easyui-textbox" data-options="iconAlign:'left'" />
                    </td>
                </tr>
                <tr>
                    <th>
                        <span>教材3：</span>
                    </th>
                    <td>
                        <input type="text" style="height:70%;width:100%" data-bind="value:book3" name="book3" id="book3" value="" class="easyui-textbox" data-options="iconAlign:'left'" />

                    </td>
                    <th>
                        <span>教材来源3：</span>
                    </th>
                    <td>
                        <input type="text" style="height:70%;" data-bind="value:bookfrom3" name="bookfrom3" id="bookfrom3" value="" class="easyui-textbox" data-options="iconAlign:'left'" />
                    </td>
                </tr>
                <tr>
                    <th>
                        <span>教材4：</span>
                    </th>
                    <td>
                        <input type="text" style="height:70%;width:100%" data-bind="value:book4" name="book4" id="book4" value="" class="easyui-textbox" data-options="iconAlign:'left'" />
                    </td>
                    <th>
                        <span>教材来源4：</span>
                    </th>
                    <td>
                        <input type="text" style="height:70%;" data-bind="value:bookfrom4" name="bookfrom4" id="bookfrom4" class="easyui-textbox" value="" data-options="iconAlign:'left'" />
                    </td>
                </tr>
            </table>
            <input type="hidden" name="departmanid" id="departmanid"   value="0"/>
            <input type="hidden" name="projmanid" id="projmanid" value="0"/>
            <input type="hidden" name="refdocurl" id="refdocurl" value="" />
            <input type="hidden" name="record_url" id="record_url" value="" />
            <input type="hidden" name="selfteach" id="selfteach" value="自培"/>
            <input type="hidden" name="current_persons" id="current_persons" value="自培"/>
            <input type="hidden" name="plan_code" id="plan_code" />
            <input type="hidden" name="persnum" id="persnum"/>
            <input type="hidden" name="pervals" id="pervals"/>
            <input type="hidden" name="add_user" id="add_user"/>
            <input type="hidden" name="add_user_name" id="add_user_name"/>
            <input type="hidden" name="class_status" id="class_status" value="14"/>
            <input type="hidden" name="class_status_cmt" id="class_status_cmt"/>
        </form>

        <script type="text/javascript">
            function showUnits()
            {
                var window1 = $('<div/>')
                var href = "selectUnits";
                window1.dialog({
                    title: '分配',
                    width: 400,
                    height: 400,
                    maximized: false,
                    maximizable: false,
                    closed: false,
                    href: href,
                    cache: false,
                    modal: true,
                    onClose: function () {
                        window1.dialog('clear');
                    },
                    buttons: [{
                            text: '确定',
                            handler: function () {
                                var persons = $("#dg").datagrid('getRows');
                                $("#persnum").val(JSON.stringify(persons));
                                window1.dialog('clear');
                                window1.dialog('close');
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
            var maxPerons = 0;
            $.extend($.fn.validatebox.defaults.rules, {
                canSelected: {
                    validator: function (value, param) {
                        return $.trim(value).indexOf("--") < 0;
                    },
                    message: '此节点不能选中'
                }, compareToSDate: {
                    validator: function (value, param) {
                        return new Date($(param[0]).datetimebox('getValue')) >= new Date(value); //注意easyui 时间控制获取值的方式
                    },
                    message: '不能大于开始日期'
                }
            })
            function classTypeSelected(record)
            {
                var i = 0;
                if (record)
                {
                    if (record.text.indexOf("新职") >= 0)
                    {
                        i++;
                    }
                    if (record.text.indexOf("转岗") >= 0)
                    {
                        i++;
                    }
                    if (record.text.indexOf("晋升") >= 0)
                    {
                        i++;
                    }
                    if (i != 0)
                    {
                        $("#newpost").combobox({
                            required: true
                        });
                    } else
                    {
                        $("#newpost").combobox({
                            required: false
                        });
                    }
                }

            }
            var isedit = false;
            var editObj = undefined;
            var curplan = undefined;
            var planuid = "";
            var token = $("meta[name='_csrf']").attr("content");
            var header = $("meta[name='_csrf_header']").attr("content");
            $(function () {
                init();
                $('#upload').uploadify({
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
                            $("#refdocurl").val(data);
                        }
                        //  _filenames += _type + "/" + _smalltype + "/" + queueData.name + ",";
                    }
                });
                $('#upload1').uploadify({
                    'swf': '../s/js/uploadify/uploadify.swf',
                    'uploader': 'Upload?_csrf=' + token + '&_csrf_header=' + header,
                    'buttonText': '选择上传文件',
                    'auto': true,
                    'onUploadSuccess': function (queueData, data, response) {//每一个文件上传成功后执行

                        if (data == "false")
                        {

                        } else
                        {
                            $("#uploadurl1").text(queueData.name + '上传成功!')
                            $("#record_url").val(data);
                        }
                    }
                });
            })
            function init() {
                var id = $("#oid").val();
                if (id) {
                    if (id == "0") {
                        var num = formatterNum(new Date());
                        $("#classno").val(num);
                        var year = new Date().getFullYear();
                        $("#refdoc").val("xx教电(" + year + ")xx号");
                        //新增
                    } else {
                        //编辑
                        $.getJSON('getClass?id=' + id, function (data) {
                            if (data) {
                                editObj = data;
                                isedit = true;
                                $("#classlevel").combobox('select', data.classlevel);
                                $("#unitid").combobox('select', data.unitid);
                                $("#classno").textbox('setValue', data.classno);
                                $("#id").val(data.id);
                                $("#classname").textbox('setValue', data.classname);
                                $("#classtype").combobox('select', data.classtype);
                                $("#departman").textbox('setValue', data.departman);
                                $("#projman").textbox('setValue', data.projman);
                                $("#studentscope").textbox('setValue', data.studentscope);
                                $("#classfrom").textbox('setValue', data.classfrom);
                                $("#classplace").textbox('setValue', data.classplace);
                                $("#refdoc").textbox('setValue', data.refdoc);
                                $("#studentnum").textbox('setValue', data.studentnum);
                                $("#studentdays").textbox('setValue', data.studentdays);
                                $("#classhours").textbox('setValue', data.classhours);
                                $("#selfteach").val(data.selfteach);
                                $("#prof").combobox('setValue', data.prof);
                                $("#crh").combobox('setValue', data.crh);
                                $("#newpost").combobox('setValue', data.newpost);
                                $("#book1").textbox('setValue', data.book1);
                                $("#bookfrom1").textbox('setValue', data.bookfrom1);
                                $("#book2").textbox('setValue', data.book2);
                                $("#bookfrom2").textbox('setValue', data.bookfrom2);
                                $("#book3").textbox('setValue', data.book3);
                                $("#bookfrom3").textbox('setValue', data.bookfrom3);
                                $("#book4").textbox('setValue', data.book4);
                                $("#bookfrom4").textbox('setValue', data.bookfrom4);
                                $("#book1").textbox('setValue', data.book1);
                                $("#unitid").val(data.unitid);
                                $("#archivedate").val(data.archivedate);
                                $("#refdocurl").val(data.refdocurl);
                                $("#startdate").datetimebox('setValue', data.startdate);
                                $("#enddate").datetimebox('setValue', data.enddate);
                                $("#signenddate").datetimebox('setValue', data.signenddate);
                                $("#telldate").datetimebox('setValue', data.telldate);
                                $("#record_url").val(data.record_url);
                                $("#persnum").val(JSON.stringify(data.unitpers));
                                $("#add_user").val(data.add_user);
                                $("#add_user_name").val(data.add_user_name);
                                $("#class_status").val(data.class_status);
                                $("#class_status_cmt").val(data.class_status_cmt);
                                var perarray = [];
                                $.each(data.unitpers, function (index, item) {
                                    perarray.push(item.unit_id);
                                })
                                $("#studentnum").textbox('setValue', persons);
                                $("#pervals").val(JSON.stringify(perarray));
                                $("#plan_code").val(data.plan_code);
                                $("#plan_books").val(data.plan_books);
                            }
                        }).error(function (errMsg) {
                            $("#edituserForm").attr('disabled', 'disabled');
                        })
                    }
                }
            }
            function formatterNum(date) {
                var y = date.getFullYear();
                var m = date.getMonth() + 1;
                var d = date.getDate();
                var mm = date.getTime().toLocaleString();
                var ds = gene_num(1000, 9999);
                return y + '' + (m < 10 ? ('0' + m) : m) + '' + ds;
            }
            function gene_num(min, max) {
                return Math.floor(Math.random() * (max - min)) + min;
            }
            function levelSuccess()
            {
                var id = $("#oid").val();
                if (id) {
                    if (id == "0") {
                        $("#classlevel").combobox('select', '1');
                    }
                }
            }
            function myformatter(date) {
                var y = date.getFullYear();
                var m = date.getMonth() + 1;
                var d = date.getDate();
                return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d) + " 00:00:00";
            }
            function myparser(s) {
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
            }
            //培训班等级选择
            function levelSelected(record) {
                initUnit();
               // initExecUnit(record.value);
//                $("#cost_id").combobox({
//                    required: true
//                });
                initPlans(record);
            }
            //
            function selfteachSelected(record) {
                if (record.value == "0")
                {
                    $("#selfteach").combobox('select', '');
                }
            }
            //单位选择
            function unitidSelected(record)
            {
                if (record)
                {
                    $("#unit").val(record.name);
                }
            }
            //承办单位选择
            function excunitSelected(record)
            {
                if (record)
                {
                    $("#execunit").val(record.name);
                }
            }
            function planunitSelected(record)
            {
                if (record)
                {
                    $("#planunit").val(record.name);
                    curplan = record;
                }
            }
            function initPlans(record)
            {
                var com = '${company}';
                var id = $("#oid").val();
                var isUpdate = 0;
                if (id == "0")
                {
                } else
                {
                    isUpdate = 1;
                }
                var url = 'getPlanCosts?levelId=' + record.value + '&isUpdate=' + isUpdate;
                if (record.value != "2")
                {
                    url += "&planunit=" + com;
                }
                $.getJSON(url, function (data) {
                    $('#cost_id').combobox('clear');
                    $('#cost_id').combobox('loadData', []);
                    if (data.length > 0) {
                        $('#cost_id').combobox({
                            data: data
                        });
                        if (data.length > 0)
                        {
                            if (editObj)
                            {
                                $('#cost_id').combobox('select', editObj.cost_id)
                            } else
                            {

                                $('#cost_id').combobox('select', data[0].cost_id)
                            }
                        }
                    }
                }).error(function (errMsg) {
                    $.messager.alert('提示', "未查到记录，稍后重试！", 'info');
                })
            }
            //初始化单位
            function initUnit() {
                $.getJSON('getUnits?levelId=0&searchType=2&uid=&uname=', function (data) {
                    debugger;
                    if (data.length > 0) {
                        $('#unitid').combobox({
                            data: data
                        });
                        if (editObj)
                        {
                            if (editObj.unitid.length == 0)
                            {
                                $.each(data, function (index, item) {
                                    if (item.name == editObj.unit)
                                    {
                                        $('#unitid').combobox('select', item.u_id);
                                    }
                                })
                            } else
                            {
                                $('#unitid').combobox('select', editObj.unitid);
                            }
                        } else
                        {
                            $('#unitid').combobox('select', '${companyId}');
                        }
                    }
                }).error(function (errMsg) {
                    $.messager.alert('提示', "未查到记录，稍后重试！", 'info');
                })
            }
            //初始化主办单位,根据计划来
            function initPlanUnit(unit, uid) {
                if (uid.length > 0)
                {
                    var array = [];
                    array.push({name: unit, u_id: uid});
                    $('#planunitid').combobox('loadData', array);
                    $('#planunitid').combobox('select', array[0].u_id)
                }
            }
            //初始化承办单位
            function initExecUnit(levelId) {
                //路外培训不加载站段
                if (levelId != 2)
                {
                    $.getJSON('getUnits?levelId=1&searchType=1&uid=&uname=', function (data) {
                        debugger;
                        if (data.length > 0) {
                            $('#execunitid').combobox({
                                data: data
                            });
                            if (editObj)
                            {
                                $('#execunitid').combobox('select', editObj.execunitid)
                            } else
                            {
                                $('#execunitid').combobox('select', data[0].u_id)
                            }

                        }
                    }).error(function (errMsg) {
                        $.messager.alert('提示', "未查到记录，稍后重试！", 'info');
                    })
                }
            }
            function plansSelected(record)
            {
                debugger;
                if (isedit)
                {
                    var levelId = $("#classlevel").combobox('getValue');
                    initPlanUnit(record.plan_unit, record.plan_unitid);//主办单位     
                    $("#current_persons").val(record.cost_persons);
                    if (levelId == "1")
                    {
                        initExecuitid1(record.plan_executeunit, record.plan_execunitid);//路外执行单位
                        //局培训
                    } else if (levelId == "2"||levelId=="4")
                    {
                        initExecuitid1(record.plan_executeunit, record.plan_execunitid);//路外执行单位
                    }else if(levelId=="3"){
                        initExecuitid1(record.plan_executeunit, record.plan_execunitid);//路外执行单位 
                    }
                    isedit = false;
                } else
                {
                    var levelId = $("#classlevel").combobox('getValue');
                    initPlanUnit(record.plan_unit, record.plan_unitid);//主办单位
                    $("#classform").combobox('select', record.plan_type);
                    $("#studentscope").textbox('setValue', record.plan_object);
                    $("#classname").textbox('setValue', record.cost_name);
                    $("#current_persons").val(record.cost_persons);
                    $("#plan_code").val(record.plan_code);
                    $("#studentnum").textbox('setValue', record.cost_persons);
                    $("#studentdays").textbox('setValue', record.cost_days)
                    if (levelId == "1")
                    {
                        //局培训
                        $("#prof").combobox('select', record.plan_prof); 
                        initExecuitid1(record.plan_executeunit, record.plan_execunitid);//路外执行单位
                    } else if (levelId == "2"||levelId=="4")
                    {

                        $("#refdoc").textbox('setValue', record.refdoc);//路外URL
                        $("#refdocurl").val(record.refdocurl);//路外文件URL
                        initExecuitid1(record.plan_executeunit, record.plan_execunitid);//路外执行单位
                    }else if(levelId=="3"){
                        initExecuitid1(record.plan_executeunit, record.plan_execunitid);//路外执行单位 
                    }
                }
            }
            function initExecuitid1(unit, uid) {
                if (uid.length > 0)
                {
                    var array = [];
                    array.push({name: unit, u_id: uid});
                    $('#execunitid').combobox('loadData', array);
                    $('#execunitid').combobox('select', array[0].u_id).combobox('setValue', array[0].u_id);
                }
            }
        </script>
    </body>
</html>
