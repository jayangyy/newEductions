<%-- 
    Document   : authPassed
    Created on : 2016-9-2, 17:34:43
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
<body>
    <form id="authPassedForm" style="text-align:left;">
        <table class="doc-table">
            <tr>
                <th>
                    <span>审核人：</span>
                </th>
                <td>
                    <input type="text" data-bind="value:plan_name" name="reviewer" id="reviewer" value="${user.workername}" style="width:100%;height:70%" class="easyui-textbox" data-options="iconAlign:'left',required:true,editable:false" />              
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
                <td colspan="4">
                    <input type="text"  style="height:70%;width:450px;overflow: auto;" name="review_cmt" id="review_cmt" value="" class="easyui-textbox" data-options="iconAlign:'left',required:false" />
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
        <input type="hidden" name="review_dcode" id="review_dcode"/>
        <input type="hidden" id="plan_code" name="plan_code"/>
        <input type="hidden" id="plan_status_cmt" name="plan_status_cmt" value="${passedEnumcmt}"/>
        <input type="hidden" id="review_url" name="review_url" value=""/>
        <input type="hidden" id="idcard" name="idcard" value="${user.username}"/>
        <input type="hidden" id="current_unit" name="current_unit" value="${user.company}"/>
        <input type="hidden" id="current_unitid" name="current_unitid" value="${user.companyId}"/>
        <input type="hidden" id="transfer_code" name="transfer_code" value="${transfer_code}"/>
        <input type="hidden" id="cost_id" name="cost_id" value="${costid}"/>
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
//            $('#upload').uploadify({
//                'swf': '../s/js/uploadify/uploadify.swf',
//                'uploader': 'Upload?_csrf=' + token + '&_csrf_header=' + header,
//                'buttonText': '选择上传文件',
//                'auto': true,
//                'onUploadSuccess': function (queueData, data, response) {//每一个文件上传成功后执行
//                    if (data == "false")
//                    {
//
//                    } else
//                    {
//                        $("#uploadurl").text(queueData.name + '上传成功!')
//                       /// $("#review_url").val(data);
//                        /// alert(data);
//                        // $("#refdocurl").val(data);
//                    }
//                    //  _filenames += _type + "/" + _smalltype + "/" + queueData.name + ",";
//                }
//            });
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
    </script>

</body>

