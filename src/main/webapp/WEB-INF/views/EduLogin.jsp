<%-- 
    Document   : login
    Created on : 2016-7-14, 19:59:46
    Author     : jayan
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="_csrf" content="${_csrf.token}"/>  
        <meta name="_csrf_header" content="${_csrf.headerName}"/>  
        <title>首页</title>
        <style>
            .error {
                padding: 15px;
                margin-bottom: 20px;
                border: 1px solid transparent;
                border-radius: 4px;
                color: #a94442;
                background-color: #f2dede;
                border-color: #ebccd1;
            }

            .msg {
                padding: 15px;
                margin-bottom: 20px;
                border: 1px solid transparent;
                border-radius: 4px;
                color: #31708f;
                background-color: #d9edf7;
                border-color: #bce8f1;
            }

            #login-box {
                width: 300px;
                padding: 20px;
                margin: 100px auto;
                background: #fff;
                -webkit-border-radius: 2px;
                -moz-border-radius: 2px;
                border: 1px solid #000;
            }
        </style>
    </head>
    <body onload='document.loginForm.username.focus();'>
        <div id="login-box">
            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>
            <c:if test="${not empty msg}">
                <div class="msg">${msg}</div>
            </c:if>
                 <c:if test="${not empty errmessage}">
                <div class="error">${errmessage}</div>
            </c:if>
            <c:if test="${not empty stackerror}">
                <div class="msg">${stackerror}</div>
            </c:if>
                <ul>
                    <li><a href="json">getJson</a></li>
                    <li><a href="post">getPost</a></li>
                </ul>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        </div>
    </body>
</html>