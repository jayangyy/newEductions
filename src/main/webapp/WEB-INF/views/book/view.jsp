<%-- 
    Document   : view
    Created on : 2016-7-7, 10:16:55
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
        <title>JSP Page</title>
        <%@include file="/WEB-INF/views/jspf/commonjs.jspf"%>
        <script type="text/javascript" src="../s/jwplayer/jwplayer.js"></script>
        <script type="text/javascript" src="../s/jwplayer/jwpsrv.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                anticsrf();
                var bookid = GetQueryString("bookid");
                var tip = GetQueryString("tip");
                $.ajax({
                    type: 'get',
                    url: 'book/'+bookid,
                    data: {},
                    dataType: "json",
                    success: function (r) {
                        if(r.result){
                            var row = r.rows;
                            var type = row.type4;
                            switch(type){
                                case '教材':
                                case '电子书':
                                    location.href = 'http://10.194.5.19/ebook/admin/upbigload/file/'+row.fileurl6;
                                    break;
                                case '视频':
                                case '音频':
                                    var url1 = row.fileurl1;
                                    var url2 = row.fileurl2;
                                    var url3 = row.fileurl3;
                                    var url4 = row.fileurl4;
                                    var url5 = row.fileurl5;
                                    var html = '<table style="width:100%;text-align:center;">';
                                    html+='<tr><td><h3 style="line-height:0px;">'+row.title+'</h3></td></tr><tr><td><div id="v" style="width:640px;height:480px;"></div></td></tr><tr><td>';
                                    var tempHtml = "";
                                    var i = 1;
                                    if(url1!=null && url1!=""){
                                        tempHtml+=' <a href="#" onclick="play(\''+url1+'\')">'+i+'</a> |';
                                        i++;
                                    }
                                    if(url2!=null && url2!=""){
                                        tempHtml+=' <a href="#" onclick="play(\''+url2+'\')">'+i+'</a> |';
                                        i++;
                                    }
                                    if(url3!=null && url3!=""){
                                        tempHtml+=' <a href="#" onclick="play(\''+url3+'\')">'+i+'</a> |';
                                        i++;
                                    }
                                    if(url4!=null && url4!=""){
                                        tempHtml+=' <a href="#" onclick="play(\''+url4+'\')">'+i+'</a> |';
                                        i++;
                                    }
                                    if(url5!=null && url5!=""){
                                        tempHtml+=' <a href="#" onclick="play(\''+url5+'\')">'+i+'</a> |';
                                        i++;
                                    }
                                    if(tempHtml!="")
                                        tempHtml = tempHtml.substring(0,tempHtml.length-1);
                                    html+=tempHtml;
                                    html+='</td></tr><tr><td style="padding-top:20px;"><a id="downloadUrl" style="border:2px solid blue;background-color:gray;padding:5px 16px;color:#fff;cursor:pointer;text-decoration:none;">&nbsp;点击下载&nbsp;</a></td></tr>';
                                    html+='</table>';
                                    var info = (tip == '1') ? "<div style=\"color:red;font-size: 12px;padding:2px;\">备注：如果mp4视频播放无画面，说明mp4视频内部编码格式不正确，" +
                                            "请下载<a href='http://10.194.3.33/格式工厂3.8.exe'>格式工厂</a>，将视频转换为AVC(H.264)格式（输出配置选AVC 720p）</div>" : '';
                                    $("#spDiv").html( info + html).show();
                                    if(tempHtml!="")
                                        $(tempHtml.split('|')[0]).click();
                                    break;
                                default:
                                    showDownLoad(row.fileurl6);
                                    break;
                            }
                        }
                        else 
                            $.messager.alert("提示", r.info, "alert");
                    },
                    error: function () {
                        $.messager.alert("提示", "调用后台接口出错！", "alert");
                    }
                });
            });
            function showDownLoad(url) {
                if(url!=null && url!=""){
                    var html = $("#otherDiv").html();
                    html = html.replace('@url','http://10.194.5.19/ebook/admin/upbigload/file/'+url);
                    $("#otherDiv").html(html).show();
                }else{
                    $("#otherDiv").html("未上传资料").show();
                }
            }
            function play(url) {
                url = 'http://10.194.5.19/ebook/admin/upbigload/file/'+url;
                $("#downloadUrl").attr("href",url);
                jwplayer('v').setup({file:url, width:600, height:430}).play(true);
            }
            function GetQueryString(name)
            {
                var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
                var r = window.location.search.substr(1).match(reg);
                if(r!=null)return  unescape(r[2]); return null;
            } 
        </script>

    </head>
    <body style="margin:0 auto;">
        <div id="spDiv" style="display:none;">
        </div>
        <div id="otherDiv" style="padding: 100px 0px 0px 140px;display:none;">  
            此类型资料不支持在线阅读，请<a href="@url">&nbsp;点击下载&nbsp;</a>
        </div>
    </body>
</html>
