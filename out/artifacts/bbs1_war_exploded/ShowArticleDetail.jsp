<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: mcb
  Date: 2018/7/31
  Time: 11:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String strId = request.getParameter("id");
    int id = Integer.parseInt(strId);
    final String url = "jdbc:mysql://localhost:3306/bbs" +
            "?serverTimezone=GMT%2B8&useSSL=false";
    String username = "root";
    String password = "123456";
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url,username,password);
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM article where id = " + id);
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    if (rs.next()){
%>
    <table border="1">
        <tr>
            <td>ID</td>
            <td><%=rs.getInt("id")%></td>
        </tr>
        <tr>
            <td>Title</td>
            <td><%=rs.getString("Title")%></td>
        </tr>
        <tr>
            <td>Content</td>
            <td><%=rs.getString("cont")%></td>
        </tr>
    </table>

    <a href="Reply.jsp?id=<%=rs.getInt("id")%>&rootid=<%=rs.getInt("rootid")%>">回复</a>
<%
    }
    rs.close();
    stmt.close();
    conn.close();
%>
</body>
</html>
