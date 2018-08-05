<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: mcb
  Date: 2018/7/31
  Time: 11:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    String action = request.getParameter("action");
    if(action != null && action.equals("post")) {
        String title = request.getParameter("title");
        String cont = request.getParameter("cont");

        cont = cont.replaceAll("\n", "<br>");

        final String url = "jdbc:mysql://localhost:3306/bbs" +
                "?serverTimezone=GMT%2B8&useSSL=false";
        String username = "root";
        String password = "123456";
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, username, password);

        conn.setAutoCommit(false);

        String sql = "insert into article values(null, 0, ?, ?, ?, now(), 0)";
        PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        Statement stmt = conn.createStatement();

        pstmt.setInt(1, -1);
        pstmt.setString(2, title);
        pstmt.setString(3, cont);
        pstmt.executeUpdate();

        ResultSet rskey = pstmt.getGeneratedKeys();
        rskey.next();
        int key = rskey.getInt(1);
        rskey.close();
        stmt.executeUpdate("update article set rootid = " + key + " where id = " + key);

        conn.commit();
        conn.setAutoCommit(true);

        stmt.close();
        pstmt.close();
        conn.close();
        response.sendRedirect("ShowArticleFlat.jsp");
    }
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="Post.jsp" method="post">
    <input type="hidden" name="action" value="post">
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
