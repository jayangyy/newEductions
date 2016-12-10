<%-- 
    Document   : view
    Created on : 2016-9-22, 10:05:10
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
        <style>
            table {
                font-family: verdana,arial,sans-serif;
                font-size:18px;	
                color:#333333;
                width: 100%;
                border-collapse: collapse;
            }
            .tdclass{
                border-width: 1px;
                padding: 8px;
                border-style: solid;
                border-color: #BBBBBB;
            }
            .center{
                text-align: center;
            }
            .borderblack{
                border-color: black;
            }
            .padding12{
                padding: 12px;
            }
            .padding5{
                padding: 5px;
            }
            .padding10{
                padding: 10px;
            }
            .tdtitle{text-align: left; text-indent: 2em;}
        </style>
        <script type="text/javascript">
            $(document).ready(function () {
                anticsrf();
                var userpid = GetQueryString("pid");
            });
        </script>
    </head>
    <body>
        <table>
            <tbody>
                <tr>
                    <td align="center" valign="middle">


                        <table style="width:720px;background-color: #FFFFEE;">
                            <tr><td colspan="2" class="tdclass center">铁&nbsp;&nbsp;路&nbsp;&nbsp;岗&nbsp;&nbsp;位&nbsp;&nbsp;培&nbsp;&nbsp;训&nbsp;&nbsp;合&nbsp;&nbsp;格&nbsp;&nbsp;证&nbsp;&nbsp;书</td></tr>
                            <tr>
                                <td class="tdclass center" style="width:50%">
                                    <table>
                                        <tr><td height="230"><img src="#" width="120" height="160" title="照片"></td></tr>
                                        <tr><td height="32"></td></tr>
                                        <tr><td style="font:楷体_GB2312; font-size:20px" height="35">成都车站（章）</td></tr>
                                        <tr><td align="center" style="font-family:楷体; font-size:22px" height="40"><B></b></td></tr>
                                        <tr><td align="center" style="font-family:楷体; font-size:20px" height="60">培证字第&nbsp;<B>1410103008</B>&nbsp;号</td></tr>
                                        <tr><td style="font-family:楷体; font-size:18px" height="40">发证日期&nbsp;2012年7月1日</td></tr>
                                    </table>
                                </td>
                                <td class="tdclass center">
                                    <table>
                                        <tr><td height="32" colspan="2"></td></tr>
                                        <tr>
                                            <td height="60" width="115" align="right" style="font-size:20px;">
                                                姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名&nbsp;&nbsp;
                                            </td>
                                            <td align="left">
                                                <B>安宇宵</B>
                                                &nbsp;&nbsp;<font style="font-family:宋体; font-size:20px;">性别&nbsp;</font><B>男</B>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="50" width="115" align="right" style="font-size:20px;">
                                                出生日期&nbsp;&nbsp;
                                            </td>
                                            <td align="left">
                                                <B>1992年2月18日</B>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="40" width="115" align="right" style="font-size:20px;">
                                                文化程度&nbsp;&nbsp;
                                            </td>
                                            <td align="left">
                                                <B>大专(高职)</B>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="50" width="115" align="right" style="font-size:20px;">
                                                工作单位&nbsp;&nbsp;
                                            </td>
                                            <td align="left">
                                                <B>成都车站</B>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="50" width="115" align="right" style="font-size:20px;">
                                                部&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;门&nbsp;&nbsp;
                                            </td>
                                            <td align="left">
                                                <B>成都东客售车间</B>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="50" width="115" align="right" style="font-size:20px;">
                                                参工时间&nbsp;&nbsp;
                                            </td>
                                            <td align="left">
                                                <B>2012 年 7 月</B>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="50" width="115" align="right" style="font-size:20px;">
                                                职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名&nbsp;&nbsp;
                                            </td>
                                            <td align="left">
                                                <B>	铁路售票员</B>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="50" width="115" align="right" style="font-size:20px;">
                                                技能等级&nbsp;&nbsp;
                                            </td>
                                            <td align="left">
                                                <B>初级工</B>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>

                        <br>
                        <br>

                        <table style="width:720px;background-color: #FFFFEE;">
                            <tr><td class="tdclass center" style="height:45px">铁&nbsp;&nbsp;路&nbsp;&nbsp;岗&nbsp;&nbsp;位&nbsp;&nbsp;培&nbsp;&nbsp;训&nbsp;&nbsp;合&nbsp;&nbsp;格&nbsp;&nbsp;证&nbsp;&nbsp;书</td></tr>
                            <tr>
                                <td class="tdclass" style="border-top: none;border-bottom: none;">
                                    <table style="width:620px;" align="center">
                                        <tr>
                                            <td align="center" height="60" width="24%" style="font-family:'楷体'; font-size:24px;">专&nbsp;&nbsp;业&nbsp;&nbsp;学&nbsp;&nbsp;历&nbsp;&nbsp;登&nbsp;&nbsp;记</td>
                                        </tr>
                                    </table>
                                    <table style="width:620px;text-align: center;" align="center">
                                        <tr>
                                            <td class="tdclass borderblack padding12" style="width:25%">时&nbsp;&nbsp;&nbsp;&nbsp;间</td>
                                            <td class="tdclass borderblack padding12" style="width:25%">学&nbsp;&nbsp;&nbsp;&nbsp;校</td>
                                            <td class="tdclass borderblack padding12" style="width:25%">专&nbsp;&nbsp;&nbsp;&nbsp;业</td>
                                            <td class="tdclass borderblack padding12" style="width:25%">毕业证书编号</td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding12"></td>
                                            <td class="tdclass borderblack padding12">成都铁中</td>
                                            <td class="tdclass borderblack padding12">交通运输</td>
                                            <td class="tdclass borderblack padding12"></td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding12">&nbsp;</td>
                                            <td class="tdclass borderblack padding12"></td>
                                            <td class="tdclass borderblack padding12"></td>
                                            <td class="tdclass borderblack padding12"></td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding12">&nbsp;</td>
                                            <td class="tdclass borderblack padding12"></td>
                                            <td class="tdclass borderblack padding12"></td>
                                            <td class="tdclass borderblack padding12"></td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding12">&nbsp;</td>
                                            <td class="tdclass borderblack padding12"></td>
                                            <td class="tdclass borderblack padding12"></td>
                                            <td class="tdclass borderblack padding12"></td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding12">&nbsp;</td>
                                            <td class="tdclass borderblack padding12"></td>
                                            <td class="tdclass borderblack padding12"></td>
                                            <td class="tdclass borderblack padding12"></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr><td class="tdclass" style="height:20px;border-top: none;"></td></tr>
                        </table>

                        <br>
                        <br>


                        <table style="width:720px;background-color: #FFFFEE;">
                            <tr><td class="tdclass center" colspan="2" style="height:45px">铁&nbsp;&nbsp;路&nbsp;&nbsp;岗&nbsp;&nbsp;位&nbsp;&nbsp;培&nbsp;&nbsp;训&nbsp;&nbsp;合&nbsp;&nbsp;格&nbsp;&nbsp;证&nbsp;&nbsp;书</td></tr>
                            <tr>
                                <td class="tdclass center" align="center" style="width:360px;">
                                    <table style="width:280px;margin:auto;">
                                        <tr><td style="height:20px"></td></tr>
                                        <tr><td height=82 align="center" style="font-family:楷体; font-size:22px">资格性培训合格证</td></tr>
                                        <tr><td style="font-family:楷体; font-size:20px; line-height:220%;text-align: left;" height="135">&nbsp;&nbsp;&nbsp;&nbsp;自 <B>2012年3月18日</B> 至 <B>2012年6月16日</B> 参加 <B>铁路售票员</B> 任职资格培训，经考试（核）合格，颁发此证。</td></tr>
                                        <tr><td style="height:60px">&nbsp;</td></tr>
                                        <tr><td align="right" style="font-family:楷体; font-size:20px;height:40px">成都车站（章）</td></tr>
                                        <tr><td align="right" style="font-family:楷体; font-size:20px;height:40px">2015年1月4日</td></tr>
                                    </table>
                                </td>
                                <td class="tdclass center">
                                    <div style="line-height:160%;font-family:'楷体';">培训科目与成绩</div>
                                    <table style="text-align: center;font-size:14px;font-family:'宋体';width:280px;margin: auto;" align="center">
                                        <tr>
                                            <td class="tdclass borderblack padding5">序<BR>号</td>
                                            <td class="tdclass borderblack padding5">培训科目</td>
                                            <td class="tdclass borderblack padding5">培训<BR>学时</td>
                                            <td class="tdclass borderblack padding5">成绩</td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding5">1</td>
                                            <td class="tdclass borderblack padding5">安全理论培训</td>
                                            <td class="tdclass borderblack padding5">40</td>
                                            <td class="tdclass borderblack padding5">98</td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding5">2</td>
                                            <td class="tdclass borderblack padding5">专业理论培训</td>
                                            <td class="tdclass borderblack padding5">100</td>
                                            <td class="tdclass borderblack padding5">100</td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding5">3</td>
                                            <td class="tdclass borderblack padding5">实作技能培训</td>
                                            <td class="tdclass borderblack padding5">110</td>
                                            <td class="tdclass borderblack padding5">98</td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding5">4</td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding5">5</td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding5">6</td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding5">7</td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding5">8</td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding5">9</td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding5">10</td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                        </tr>
                                    </table>
                                    <div style="font-family:'宋体'; font-size:14px; line-height:160%;" align="right">成都车站（盖章）&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
                                    <div style="font-family:'宋体'; font-size:14px; line-height:160%;" align="right">2015年1月4日&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
                                </td>
                            </tr>
                        </table>

                        <br>
                        <br>


                        <table style="width:720px;background-color: #FFFFEE;">
                            <tr><td class="tdclass center" colspan="2" style="height:45px">铁&nbsp;&nbsp;路&nbsp;&nbsp;岗&nbsp;&nbsp;位&nbsp;&nbsp;培&nbsp;&nbsp;训&nbsp;&nbsp;合&nbsp;&nbsp;格&nbsp;&nbsp;证&nbsp;&nbsp;书</td></tr>
                            <tr>
                                <td class="tdclass center" align="center" style="width:360px;">
                                    <table style="width:280px;margin:auto;">
                                        <tr><td style="height:20px"></td></tr>
                                        <tr><td height=82 align="center" style="font-family:楷体; font-size:22px">工班长资格培训合格证</td></tr>
                                        <tr><td style="font-family:楷体; font-size:20px; line-height:220%;text-align: left;" height="135">&nbsp;&nbsp;&nbsp;&nbsp;自____月____日 至____月____日 参加 ____________ 培训，经考试（核）合格，颁发此证。</td></tr>
                                        <tr><td style="height:60px">&nbsp;</td></tr>
                                        <tr><td align="right" style="font-family:楷体; font-size:20px;height:40px">（章）</td></tr>
                                        <tr><td align="right" style="font-family:楷体; font-size:20px;height:40px">年&nbsp;&nbsp;月&nbsp;&nbsp;日</td></tr>
                                    </table>
                                </td>
                                <td class="tdclass center">
                                    <div style="line-height:160%;font-family:'楷体';">培训科目与成绩</div>
                                    <table style="text-align: center;font-size:14px;font-family:'宋体';width:280px;margin: auto;" align="center">
                                        <tr>
                                            <td class="tdclass borderblack padding5">序<BR>号</td>
                                            <td class="tdclass borderblack padding5">培训科目</td>
                                            <td class="tdclass borderblack padding5">培训<BR>学时</td>
                                            <td class="tdclass borderblack padding5">成绩</td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding5">1</td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding5">2</td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding5">3</td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding5">4</td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding5">5</td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding5">6</td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding5">7</td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding5">8</td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding5">9</td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding5">10</td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5"></td>
                                        </tr>
                                    </table>
                                    <div style="font-family:'宋体'; font-size:14px; line-height:160%;" align="right">培训考核单位（盖章）&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
                                    <div style="font-family:'宋体'; font-size:14px; line-height:160%;" align="right">&nbsp;&nbsp;年&nbsp;&nbsp;月&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
                                </td>
                            </tr>
                        </table>

                        <br>
                        <br>


                        <table style="width:720px;background-color: #FFFFEE;">
                            <tr><td class="tdclass center" style="height:45px">铁&nbsp;&nbsp;路&nbsp;&nbsp;岗&nbsp;&nbsp;位&nbsp;&nbsp;培&nbsp;&nbsp;训&nbsp;&nbsp;合&nbsp;&nbsp;格&nbsp;&nbsp;证&nbsp;&nbsp;书</td></tr>
                            <tr>
                                <td class="tdclass center" style="border-bottom: none;">
                                    <table style="text-align: center;font-size:14px;font-family:'宋体';width:620px;margin: auto;" align="center">
                                        <tr style="height:60px;">
                                            <td align="center" colspan="8" style=" font-family:'楷体'; font-size:24px;">适&nbsp;应&nbsp;性&nbsp;培&nbsp;训&nbsp;考&nbsp;核&nbsp;记&nbsp;录</td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack" rowspan="2" align="center" style="width:80px;"><b>培训时间</b></td>
                                            <td class="tdclass borderblack" rowspan="2" align="center"><b>培&nbsp; 训&nbsp; 内&nbsp; 容</b></td>
                                            <td class="tdclass borderblack" rowspan="2" align="center" style="width:30px;"><b>培训<BR>学时</b></td>
                                            <td class="tdclass borderblack" rowspan="2" align="center" style="width:30px;"><strong>培训<BR>形式</strong></td>
                                            <td class="tdclass borderblack" colspan="3" align="center"><strong>考试科目成绩</strong></td>
                                            <td class="tdclass borderblack" rowspan="2" align="center" style="width:100px;"><strong>培训考核<BR>单位（盖章）</strong></td>
                                        </tr>
                                        <tr style="height: 25px;" align="center">
                                            <td class="tdclass borderblack" style="width:30px;"><b>安全</b></td>
                                            <td class="tdclass borderblack" style="width:30px;"><b>理论</b></td>
                                            <td class="tdclass borderblack" style="width:30px;"><B>实作</B></td>
                                        </tr>
                                        <tr>
                                            <td class="tdclass borderblack padding5">2014-12-5至2014-12-8</td>
                                            <td class="tdclass borderblack padding5 tdtitle">2014年成绵乐客专运行图调图培训</td>
                                            <td class="tdclass borderblack padding5">32</td>
                                            <td class="tdclass borderblack padding5">半脱产</td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding5">100</td>
                                            <td class="tdclass borderblack padding5"></td>
                                            <td class="tdclass borderblack padding10">
                                                <table style="border:1px solid #FF0000;" cellpadding="2" cellspacing="0">
                                                    <tr>
                                                        <td style="color:#FF0000" align="center">
                                                            <font style='font-size:12px'>成都车站<BR>培训考核专用章</font>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr><td class="tdclass" style="height:20px;border-top: none;"></td></tr>
                        </table>
                        <br>
                        <br>


                        <table style="width:720px;background-color: #FFFFEE;">
                            <tr>
                                <td class="tdclass borderblack center" style="border-bottom: none;width:50%;">
                                    <table style="height:100px;">
                                        <tr><td style="height:40px;">&nbsp;</td></tr>
                                        <tr><td align="center" style="font-family:楷体; font-size:22px;height:40px">工作部门及岗位变更情况</td></tr>
                                        <tr>
                                            <td align="center">
                                                <table style="width:260px;margin:auto;font-size:14px;">
                                                    <tr>
                                                        <td class="tdclass borderblack center" style="width:80px;">变更时间</td>
                                                        <td class="tdclass borderblack center" style="width:80px;">工作部门</td>
                                                        <td class="tdclass borderblack center" style="width:100px;">工作岗位</td>
                                                    </tr>
                                                    <tr style="font-size:13px;">
                                                        <td class="tdclass borderblack center">2015-1-13</td>
                                                        <td class="tdclass borderblack center"></td>
                                                        <td class="tdclass borderblack center">铁路售票员34</td>
                                                    </tr>
                                                    <tr style="font-size:13px;">
                                                        <td class="tdclass borderblack center">2015-1-13</td>
                                                        <td class="tdclass borderblack center"></td>
                                                        <td class="tdclass borderblack center">铁路售票员34</td>
                                                    </tr>
                                                    <tr style="font-size:13px;">
                                                        <td class="tdclass borderblack center">2015-1-13</td>
                                                        <td class="tdclass borderblack center"></td>
                                                        <td class="tdclass borderblack center">铁路售票员34</td>
                                                    </tr>
                                                    <tr style="font-size:13px;">
                                                        <td class="tdclass borderblack center">2015-1-13</td>
                                                        <td class="tdclass borderblack center"></td>
                                                        <td class="tdclass borderblack center">铁路售票员34</td>
                                                    </tr>
                                                    <tr style="font-size:13px;">
                                                        <td class="tdclass borderblack center">2015-1-13</td>
                                                        <td class="tdclass borderblack center"></td>
                                                        <td class="tdclass borderblack center">铁路售票员34</td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td class="tdclass borderblack center" style="border-bottom: none;font-size: 20px;font-family:'楷体';padding:8px 30px;">
                                    <div style="height:33px;"></div>
                                    <div style="font-size:28px;padding-bottom: 20px;"><B>证书使用说明</B></div>
                                    <div class="tdtitle">1.本证书应填写本人所参加的各项岗位培训内容，是上岗任职资格凭证之一。</div>
                                    <div class="tdtitle">2.无发证单位盖章，本证书无效。</div>
                                    <div class="tdtitle">3.本证书由本人妥善保管，严禁涂改。如有遗失，须到所在单位职教部门申请补发。</div>
                                    <div class="tdtitle">4.遇有各级领导检查培训情况时，须出示此证，接受检查。</div>
                                </td>
                            </tr>
                            <tr><td class="tdclass borderblack" style="height:20px;border-top: none;"></td><td class="tdclass borderblack" style="height:20px;border-top: none;"></td></tr>
                        </table>
                        <br>
                        <br>
                        
                        
                    </td>
                </tr>
            </tbody>
        </table>
    </body>
</html>
