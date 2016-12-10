<%-- 
    Document   : video
    Created on : 2016-9-2, 9:57:05
    Author     : milord
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="_csrf" content="${_csrf.token}"/>
        <meta name="_csrf_header" content="${_csrf.headerName}"/>
        <title></title>
        <%@include file="/WEB-INF/views/jspf/commonjs.jspf"%>
        <script type="text/javascript" src="../s/jwplayer/jwplayer.js"></script>
        <script type="text/javascript" src="../s/jwplayer/jwpsrv.js"></script>
        <style>
            #content div{float:left;padding: 10px;cursor: pointer;}
            #content div ul{
                padding: 0px;
                margin: 0px;
            }
            #content div ul li{
                list-style: none;
                text-align: center;
            }
            #content div ul li.text{
                font-size: 20px;
                font-weight: bold;
                width:220px;
                height:45px;
                overflow: hidden;
/*                white-space:nowrap;
                text-overflow:ellipsis;
                -o-text-overflow:ellipsis;*/
            }
            .menuDiv{
            }
            .menuDiv div{
                float:left;
                text-align: center;
                padding-top: 15px;
                font-weight: bold;
                border: 1px solid #dddddd;
                border-left: none;
                width:100px;
                height:30px;
                cursor: pointer;
            }
            .menuDiv div:hover{
                background-color: #EDEDED;
            }
            .menuDiv div.select{
                background-color: #C6C6C6;
            }
            .menuDiv div.first{
                border-left: 1px solid #dddddd;
            }
        </style>
        <script type="text/javascript">
            var _currentUserSystem = "";
            $(document).ready(function () {
                _currentUserSystem = "${user.system}";
                bindProfessional();
//                bindData();
            });
            function bindProfessional(){
                $(".menuDiv").html("");
                $.ajax({
                    type: 'get',
                    url: 'getSgspProfessional',
                    data: {},
                    dataType: "json",
                    success: function (r) {
                        if (r.result){
                            r.rows.unshift({children: null, id: 0, main: "0", post: "", professional: "全部", type: 0});
                            for (var i = 0; i < r.rows.length; i++) {
                                var _html = "";
                                if(i==0)
                                    _html = "<div onclick='menuClick(this)' class='first' code='"+r.rows[i].main+"' name='"+r.rows[i].professional+"'>"+r.rows[i].professional+"</div>";
                                else
                                    _html = "<div onclick='menuClick(this)' code='"+r.rows[i].main+"' name='"+r.rows[i].professional+"'>"+r.rows[i].professional+"</div>";
                                $(".menuDiv").html($(".menuDiv").html()+_html);
                            }
                            if($(".menuDiv").find("div[name='"+_currentUserSystem+"']").length==0)
                                $(".first").click();
                            else
                                $(".menuDiv").find("div[name='"+_currentUserSystem+"']").click();
                        } 
                        else
                            $.messager.alert("提示", r.info, "alert");
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "alert");
                    }
                });
            }
            function menuClick(obj){
                $(obj).siblings().removeClass("select");
                $(obj).addClass("select");
                bindData();
            }
            function bindData() {
                var _code = $(".select").attr("code");
                var _filterRules = [];
                _filterRules.push({"field": "sh", "op": "equals", "value": "1"});
                _filterRules.push({"field": "memo", "op": "equals", "value": "施工视频"});
                if(_code!="0")
                    _filterRules.push({"field": "type2id", "op": "equals", "value": _code});
                var filterRuleStr = "";
                if (_filterRules.length > 0)
                    filterRuleStr = JSON.stringify(_filterRules);
                $.ajax({
                    type: 'get',
                    url: 'getSgspBooks',
                    data: {page: 1, rows: 999, filterRules: filterRuleStr},
                    dataType: "json",
                    success: function (r) {
                        if (r.result)
                        {
                            var _html = "";
                            for (var i = 0; i < r.rows.length; i++) {
                                var row = r.rows[i];
                                var title=row.title.replace("(一体化实作项目)","").replace("（一体化实作项目）","");
                                if(_code=="0")
                                    title="["+row.professional+"]"+title;
                                if (row.fileurl1 != null && row.fileurl1 != "")
                                    _html += '<div onclick="showVideo(\'' + row.title + '\',\'' + row.fileurl1 + '\')" title="' + row.title + '"><ul><li><img src="../s/file/video.png"/></li><li class="text">' + title + '</li></ul></div>';
                                else if (row.fileurl2 != null && row.fileurl2 != "")
                                    _html += '<div onclick="showVideo(\'' + row.title + '\',\'' + row.fileurl2 + '\')" title="' + row.title + '"><ul><li><img src="../s/file/video.png"/></li><li class="text">' + title + '</li></ul></div>';
                                else if (row.fileurl3 != null && row.fileurl3 != "")
                                    _html += '<div onclick="showVideo(\'' + row.title + '\',\'' + row.fileurl3 + '\')" title="' + row.title + '"><ul><li><img src="../s/file/video.png"/></li><li class="text">' + title + '</li></ul></div>';
                                else if (row.fileurl4 != null && row.fileurl4 != "")
                                    _html += '<div onclick="showVideo(\'' + row.title + '\',\'' + row.fileurl4 + '\')" title="' + row.title + '"><ul><li><img src="../s/file/video.png"/></li><li class="text">' + title + '</li></ul></div>';
                                else if (row.fileurl5 != null && row.fileurl5 != "")
                                    _html += '<div onclick="showVideo(\'' + row.title + '\',\'' + row.fileurl5 + '\')" title="' + row.title + '"><ul><li><img src="../s/file/video.png"/></li><li class="text">' + title + '</li></ul></div>';
                            }
                            $("#content").html(_html);
                        } else
                            $.messager.alert("提示", r.info, "alert");
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "alert");
                    }
                });
            }
            function showVideo(_title,_url) {
                $('#video-dialog').dialog({title:'在线查阅[ '+_title+' ]'});
                $('#video-dialog').dialog('open');
                play(_url);
            }
            function play(url) {
                url = 'http://10.194.5.19/ebook/admin/upbigload/file/' + url;
                $("#downloadUrl").attr("href", url);
                jwplayer('v').setup({file: url, width: 600, height: 430}).play(true);
            }
            function viewWindowClosing() {
                jwplayer('v').stop();
            }
        </script>
    </head>
    <body>
        <div class="menuDiv">
            <div class="first">全部</div>
            <div class="select">车辆</div>
            <div>车辆</div>
            <div>车辆</div>
            <div>车辆</div>
            <div>车辆</div>
        </div>
        
        <div style="clear: both;padding:5px;border-bottom: 1px solid #dddddd;"></div>
        
        <div id="content">
        </div>

        <div id="video-dialog" class="easyui-dialog" title="在线查阅" data-options="closed:true,iconCls:'icon-s-search',maximizable:true,resizable:true,buttons: '#video-dlg-buttons',onBeforeClose:viewWindowClosing" style="width:620px;height:540px;">
            <div id="spDiv">
                <table style="width:100%;text-align:center;">
                    <tr>
                        <td>
                            <div id="v"></div>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-top:5px;">
                            <a id="downloadUrl" style="border:2px solid blue;background-color:gray;padding:5px 16px;color:#fff;cursor:pointer;text-decoration:none;">&nbsp;点击下载&nbsp;</a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div id="video-dlg-buttons">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-no'" onclick="$('#video-dialog').dialog('close');">关闭</a>
        </div>
    </body>
</html>
