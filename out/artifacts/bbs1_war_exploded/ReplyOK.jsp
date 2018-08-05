<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: mcb
  Date: 2018/7/31
  Time: 12:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    request.setCharacterEncoding("utf-8");

    int id = Integer.parseInt(request.getParameter("id"));
    int rootId = Integer.parseInt(request.getParameter("rootid"));
    String title = request.getParameter("title");
    String cont = request.getParameter("cont");

    cont = cont.replaceAll("\n", "<br>");

    final String url = "jdbc:mysql://localhost:3306/bbs" +
            "?serverTimezone=GMT%2B8&useSSL=false";
    String username = "root";
    String password = "123456";
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url,username,password);

    conn.setAutoCommit(false);

    String sql = "insert into article values(null, ?, ?, ?, ?, now(), 0)";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    Statement stmt = conn.createStatement();

    pstmt.setInt(1, id);
    pstmt.setInt(2, rootId);
    pstmt.setString(3, title);
    pstmt.setString(4, cont);
    pstmt.executeUpdate();

    stmt.executeUpdate("update article set isleaf = 1 where id = " + id);

    conn.commit();
    conn.setAutoCommit(true);

    stmt.close();
    pstmt.close();
    conn.close();
    response.sendRedirect("ShowArticleTree.jsp");
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <span style="color: red; font-size: xx-large; ">
        OK!
    </span>
</body>
</html>
