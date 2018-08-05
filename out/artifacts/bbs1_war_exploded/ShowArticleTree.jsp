<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: mcb
  Date: 2018/7/31
  Time: 10:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String admin = (String) session.getAttribute("admin");
    if(admin != null && admin.equals("true")){
        login = true;
    }
%>

<%!
    String str = "";
    boolean login = false;
    private void tree(Connection conn, int id, int level){
        String preStr = "";
        for (int i = 0; i < level; i++){
            preStr += "----";
        }
        Statement stmt = null;
        ResultSet rs = null;
        try {
            stmt = conn.createStatement();
            String strLogin = "";
            String sql = "select * from article where pid = " + id;
            rs = stmt.executeQuery(sql);
            while (rs.next()){
                if(login){
                    strLogin = "<td><a href='Delete.jsp?id=" +
                            rs.getInt("id") + "&pid=" + rs.getInt("pid") + "'>删除</a>";
                }
                str += "<tr><td>" + rs.getInt("id") + "</td><td>" +
                        preStr + "<a href='ShowArticleDetail.jsp?id=" + rs.getInt("id") + "'>" +
                        rs.getString("title") + "</a></td>" + strLogin + "</td></tr>";
                if(rs.getInt("isleaf") != 0){
                    tree(conn, rs.getInt("id"), level + 1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            try {
                if(rs != null){
                    rs.close();
                    rs = null;
                }
                if(stmt != null){
                    stmt.close();
                    stmt = null;
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<%
    final String url = "jdbc:mysql://localhost:3306/bbs" +
            "?serverTimezone=GMT%2B8&useSSL=false";
    String username = "root";
    String password = "123456";
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url,username,password);
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM article where pid = 0");
    String strLogin = "";
    while (rs.next()){
        if(login){
            strLogin = "<td><a href='Delete.jsp?id=" +
                    rs.getInt("id") + "&pid=" + rs.getInt("pid") + "'>删除</a>";
        }
        str += "<tr><td>" + rs.getInt("id") + "</td><td>" +
                "<a href='ShowArticleDetail.jsp?id=" + rs.getInt("id") + "'>" +
                rs.getString("title") + "</a></td>" +
                strLogin +
                "</td></tr>";
        if(rs.getInt("isleaf") != 0){
            tree(conn, rs.getInt("id"), 1);
        }
    }
    rs.close();
    stmt.close();
    conn.close();
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <a href="Post.jsp">发表新帖</a>
    <table border="1">
        <%= str%>
        <%
            str="";
            login = false;
        %>
    </table>
</body>
</html>