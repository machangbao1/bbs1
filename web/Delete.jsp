<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: mcb
  Date: 2018/7/31
  Time: 12:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String admin = (String) session.getAttribute("admin");
    if(admin == null || !admin.equals("true")){
        out.println("小贼！别想过我这关！");
        return;
    }
%>

<%!
    String str = "";
    private void del(Connection conn, int id){
        Statement stmt = null;
        ResultSet rs = null;
        try {
            stmt = conn.createStatement();
            String sql = "select * from article where pid = " + id;
            rs = stmt.executeQuery(sql);
            while (rs.next()){
                del(conn, rs.getInt("id"));
            }
            stmt.executeUpdate("delete from article where id = " + id);
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
    int id = Integer.parseInt(request.getParameter("id"));
    int pid = Integer.parseInt(request.getParameter("pid"));

    final String url = "jdbc:mysql://localhost:3306/bbs" +
            "?serverTimezone=GMT%2B8&useSSL=false";
    String username = "root";
    String password = "123456";
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url,username,password);

    conn.setAutoCommit(false);

    del(conn, id);

    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("select count(*) from article where pid=" + pid);
    rs.next();
    int count = rs.getInt(1);
    rs.close();
    stmt.close();

    if(count <= 0){
        Statement stmtUpdate = conn.createStatement();
        stmtUpdate.executeUpdate("update article set isleaf = 0 where id = " + pid);
    }

    conn.commit();
    conn.setAutoCommit(true);
    conn.close();
    response.sendRedirect("ShowArticleTree.jsp");
%>