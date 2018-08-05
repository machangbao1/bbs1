<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: mcb
  Date: 2018/7/31
  Time: 11:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    int rootId = Integer.parseInt(request.getParameter("rootid"));
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <form name="reply" action="ReplyOK.jsp" method="post" onsubmit="return check()">
        <input type="hidden" name="id" value="<%=id%>">
        <input type="hidden" name="rootid" value="<%=rootId%>">
        <table border="1">
            <tr>
                <td>
                    <input type="text" name="title" size="80">
                </td>
            </tr>
            <tr>
                <td>
                    <textarea cols=80 rows=12 name="cont"></textarea>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="submit" value="提交">
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
