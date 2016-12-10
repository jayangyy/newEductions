<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>首页</title>
        <%@include file="/WEB-INF/views/jspf/commonjs.jspf"%>
        <script type="text/javascript">
            $(function () {
                $('#tt').tabs({
                    onLoad: function (panel) {
                        var plugin = panel.panel('options').title;
                        panel.find('textarea[name="code-' + plugin + '"]').each(function () {
                            var data = $(this).val();
                            data = data.replace(/(\r\n|\r|\n)/g, '\n');
                            if (data.indexOf('\t') == 0) {
                                data = data.replace(/^\t/, '');
                                data = data.replace(/\n\t/g, '\n');
                            }
                            data = data.replace(/\t/g, '    ');
                            var pre = $('<pre name="code" class="prettyprint linenums"></pre>').insertAfter(this);
                            pre.text(data);
                            $(this).remove();
                        });
                        prettyPrint();
                    }
                });
                var sw = $(window).width();
                if (sw < 767) {
                    $('body').layout('collapse', 'west');
                }
                $('.navigation-toggle span').bind('click', function () {
                    $('#head-menu').toggle();
                });
                initMenus();
            });
            function open1(obj) {
                debugger;
                var plugin = $(obj).attr("data-res-name");
                var href = $(obj).attr("data-res-url");
                if ($('#tt').tabs('exists', plugin)) {
                    $('#tt').tabs('select', plugin);
                } else {
                    $('#tt').tabs('add', {
                        title: plugin,
                        content: '<iframe src="' + href + '" style="width:100%;height:100%;margin:0px;border:0px;overflow:hidden"></iframe>',
                        closable: true,
                        bodyCls: 'content-doc'
                    });
                }
            }

            ///加载菜单
            function initMenus()
            {
                $.ajax({
                    url: "getMenus",
                    type: "get",
                    dataType: 'json'
                }).done(function (result) {
                    debugger;
                    if (!result.result) {
                        $.messager.show({
                            title: '消息提示',
                            msg: '加载菜单出错' + result.info,
                            timeout: 2000,
                            showType: 'slide'
                        });
                    }
                    //加载菜单
                    var strHtml = '<ul class="easyui-tree" id="menu_tree">';
                    $.each(result.rows, function (index, item) {
                        if (item.res_pid == "0")
                        {
                            strHtml += '<li iconCls="icon-base"><span data-res-url="${pageContext.request.contextPath}' + item.res_url + '" data-res-name="' + item.res_name + '" onclick="open1(this)">' + item.res_name + '</span><ul>';
                            $.each(result.rows, function (index1, item1) {
                                if (item1.res_pid == item.id)
                                {
                                    strHtml += ' <li iconCls="icon-gears"><a href="#" data-res-url="${pageContext.request.contextPath}' + item1.res_url + '" data-res-name="' + item1.res_name + '" onclick="open1(this)">' + item1.res_name + '</a></li>'
                                }
                            })
                            strHtml += '</ul></li>';
                        }
                    })
                    $("#menu_div").html(strHtml+" </ul>");
                    $.parser.parse('#menu_div');
                }).error(function (errorMsg) {
                    $.messager.show({
                        title: '消息提示',
                        msg: '加载菜单出错' + errorMsg,
                        timeout: 2000,
                        showType: 'slide'
                    });
                })
            }
        </script>
        <style type="text/css">
            .tree-title {
                font-size: 14px;
            }

            .tree-title a {
                text-decoration: none;
            }

            #head-menu {
                position: absolute;
                z-index: 8;
                display: none;
                background: #2d3e50;
                color: #fff;
                left: 0;
                padding: 0 4.5%;
                top: 66px;
            }

            #head-menu .navbar {
                margin: 0 40px 20px 40px;
            }

            #head-menu a {
                color: #fff;
            }
        </style>
    </head>
    <body class="easyui-layout" style="text-align:left">
<!--        <div region="north" border="false" class="" style="height:66px;font-size:100%;overflow-y:hidden">
            <div class="content">
                <div id="elogo" class="navbar navbar-right">
                    <ul>
                        <li>
                            <a href="loginout">注销登陆</a>
                        </li>
                    </ul>
                </div>
                <div style="clear:both"></div>
            </div>
            <script type="text/javascript">
                function setNav() {
                    var demosubmenu = $('#demo-submenu');
                    if (demosubmenu.length) {
                        if ($(window).width() < 450) {
                            demosubmenu.find('a:last').hide();
                        } else {
                            demosubmenu.find('a:last').show();
                        }
                    }
                    if ($(window).width() < 767) {
                        $('.navigation-toggle').each(function () {
                            $(this).show();
                            var target = $(this).attr('data-target');
                            $(target).hide();
                            setDemoNav();
                        });
                    } else {
                        $('.navigation-toggle').each(function () {
                            $(this).hide();
                            var target = $(this).attr('data-target');
                            $(target).show();
                        });
                    }
                }
                function setDemoNav() {
                    $('.navigation-toggle').each(function () {
                        var target = $(this).attr('data-target');
                        if (target == '#navbar-demo') {
                            if ($(target).is(':visible')) {
                                $(this).css('margin-bottom', 0);
                            } else {
                                $(this).css('margin-bottom', '2.3em');
                            }
                        }
                    });
                }
                $(function () {
                    setNav();
                    $(window).bind('resize', function () {
                        setNav();
                    });
                    $('.navigation-toggle').bind('click', function () {
                        var target = $(this).attr('data-target');
                        $(target).toggle();
                        setDemoNav();
                    });
                })
            </script>
        </div>-->
        <div region="west" split="true" title="菜单" style="width:240px;min-width:180px;padding:5px;">
            <div id="menu_div">
            </div>

        </div>
        <div region="center">
            <div id="tt" class="easyui-tabs" fit="true" border="false" plain="true">
                <div title="首页" class="content-doc">欢迎使用</div>
            </div>
        </div>
    </body>
</html>
