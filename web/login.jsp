<%@ page import="java.awt.*" %><%--
  Created by IntelliJ IDEA.
  User: mcb
  Date: 2018/7/31
  Time: 16:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String action = request.getParameter("action");
    if(action != null && action.equals("login")){
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        if(username == null || !username.equals("admin")){
            %>
                <span style="color:white; size: 10px">你输入的用户名有误请重新输入</span>
            <%
        }
        else if(password == null || !password.equals("admin")){
            %>
                <span style="color:white; size: 10px">密码错误</span>
            <%
        }else{
            session.setAttribute("admin", "true");
            response.sendRedirect("ShowArticleTree.jsp");
        }
    }
%>
<html>
<head>
    <meta charset="utf-8">
    <title>网站后台内容管理系统登录登陆界面模板 - cssmoban</title>
    <meta name="keywords" content="后台登陆页面模板,后台登录界面html,后台登录模板,后台登录页面html,后台管理系统后台登录模板">
    <meta name="description" content="cssmoban提供后台管理系统登录界面html模板学习和下载">
    <meta name="viewport" content="width=device-width">
    <link href="public/css/base.css" rel="stylesheet" type="text/css">
    <link href="public/css/login.css" rel="stylesheet" type="text/css">
</head>
<body>
<body>

<div class="login">
    <form action="login.jsp" method="post">
        <input type="hidden" name="action" value="login">
        <div class="logo"></div>
        <div class="login_form">
            <div class="user">
                <input class="text_value" value="" name="username" type="text" id="username">
                <input class="text_value" value="" name="password" type="password" id="password">
            </div>
            <button class="button" id="submit" type="submit">登录</button>
        </div>
</div>
</form>
</div>
<script>var basedir='public/ui/';</script>
<script src="public/ui/do.js"></script>
<script src="public/ui/config.js"></script>
<script>
    Do.ready('form', function() {
        $("#form").Validform({
            ajaxPost:true,
            postonce:true,
            tiptype:function(msg,o,cssctl){
                if(!o.obj.is("form")){
                    var objtip=o.obj.siblings(".Validform_checktip");
                    cssctl(objtip,o.type);
                    objtip.text(msg);
                }else{
                    var objtip=o.obj.find("#tip");
                    cssctl(objtip,o.type);
                    if(o.type==2){
                        window.location.href='index.php?r=admin/index/index';
                    }else{
                        objtip.text(msg);
                    }
                }
            }
        });
    });

</script>
</body>
</html>