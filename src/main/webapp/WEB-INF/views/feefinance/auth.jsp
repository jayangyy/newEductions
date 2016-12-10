<%-- 
    Document   : auth
    Created on : 2016-8-25, 15:35:46
    Author     : Jayang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
<form id="authTheahForm" style="text-align:center;">
    <table class="doc-table">
        <tr>
            <th>
                <span>审核人：</span>
            </th>
            <td>
                <input type="text" data-bind="value:plan_name" name="reviewer" id="reviewer" value="${user}" style="width:370px;height:70%" class="easyui-textbox" data-options="iconAlign:'left',required:true,editable:false" />              
            </td>
        </tr>
        <tr>
            <th>
                <span>审核选项：</span>
            </th>
            <td>
                <input id="review_status" class="easyui-combobox" name="review_status" style="width:370px;"
                       data-options="valueField:'id',textField:'text',url:'getTeachAuths?flag=财务',method:'get',editable:false,required:true,onSelect:authTypeSelected,onLoadSuccess:authLoadSuccess">

            </td>
        </tr>
        <tr>
            <th>
                <span>审核意见：</span>
            </th>
            <td colspan="4">
                <input type="text"  style="height:70%;width:78%;overflow: auto;" name="review_cmt" id="review_cmt" value="" class="easyui-textbox" data-options="iconAlign:'left',required:true" />
            </td>
        </tr>
        <tr>
            <th>审核附件上传</th>
            <td colspan="3">
                <input type="file" name="upload" id="upload" />
                <span id="uploadurl"></span>   
            </td>
        </tr>
    </table>
    <input type="hidden" name="review_dcode" id="review_dcode"/>
    <input type="hidden" id="plan_code" name="plan_code"/>
    <input type="hidden" id="plan_status_cmt" name="plan_status_cmt"/>
    <input type="hidden" id="review_url" name="review_url"/>
    <input type="hidden" id="idcard" name="idcard" value="${card}"/>

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
        $('#upload').uploadify({
            'swf': '../s/js/uploadify/uploadify.swf',
            'uploader': 'Upload?_csrf=' + token + '&_csrf_header=' + header,
            'buttonText': '选择上传文件',
            'auto': true,
            'onUploadSuccess': function (queueData, data, response) {//每一个文件上传成功后执行
                if (data == "false")
                {

                } else
                {
                    $("#uploadurl").text(queueData.name + '上传成功!')
                    $("#review_url").val(data);
                    /// alert(data);
                    // $("#refdocurl").val(data);
                }
                //  _filenames += _type + "/" + _smalltype + "/" + queueData.name + ",";
            }
        });
    })
    function init() {
        var id = $("#oplancode").val();
        if (id.length >= 0) {
            $("#plan_code").val(id);
            //新增
        }
    }

    function authLoadSuccess(data)
    {
        $("#review_status").combobox('setValue', data[0].id);
        $("#plan_status_cmt").val(data[0].text);
    }
    function formatterNum(date) {
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        var d = date.getDate();
        var mm = date.getTime().toLocaleString();
        var ds = gene_num(1000, 9999);
        alert(ds)
        return y + '' + (m < 10 ? ('0' + m) : m) + '' + ds;
    }
    function gene_num(min, max) {
        return Math.floor(Math.random() * (max - min)) + min;
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
    //承办单位选择
    function authTypeSelected(record)
    {
        if (record)
        {
            $("#plan_status_cmt").val(record.text);
        }
    }
    //初始化主办单位
    function initAuthStatu() {
        $.getJSON('getUnits?searchType=0&uid=&uname=', function (data) {
            if (data.length > 0) {
                $('#plan_unitid').combobox({
                    data: data
                });
                if (editObj)
                {
                    $('#plan_unitid').combobox('select', editObj.plan_unitid)
                } else
                {
                    $('#plan_unitid').combobox('select', '${companyId}')
                }
            }
        }).error(function (errMsg) {
            $.messager.alert('提示', "未查到记录，稍后重试！", 'info');
        })
    }
</script>
