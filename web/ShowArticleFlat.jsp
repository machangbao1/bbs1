<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: mcb
  Date: 2018/7/31
  Time: 10:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%

    int pageSize = 3;

    String strPageNo = request.getParameter("pageNo");
    int pageNo;
    if(strPageNo == null || strPageNo.equals("")){
        pageNo = 1;
    }else{
        try{
            pageNo = Integer.parseInt(strPageNo.trim());
        }catch (NumberFormatException e){
            pageNo = 1;
        }
        if(pageNo <= 0) pageNo = 1;
    }



    final String url = "jdbc:mysql://localhost:3306/bbs" +
            "?serverTimezone=GMT%2B8&useSSL=false";
    String username = "root";
    String password = "123456";
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url,username,password);

    Statement stmtCount = conn.createStatement();
    ResultSet rsCount = stmtCount.executeQuery("select count(*) from  article where pid = 0");
    rsCount.next();
    int totalRecords = rsCount.getInt(1);
    int totalPages = totalRecords % pageSize == 0 ? totalRecords / pageSize : totalRecords / pageSize + 1;
    if(pageNo > totalPages) pageNo = totalPages;

    int startPos = (pageNo - 1) * pageSize;

    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM article where pid = 0 order by pdate desc limit " + startPos + "," + pageSize);
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<a href="Post.jsp">发表新帖</a>
<table border="1">
    <%
        while (rs.next()){
    %>
    <tr>
        <td>
          <%=rs.getString("title")%>
        </td>
    </tr>
    <%
        }
        rs.close();
        stmt.close();
        conn.close();
    %>
</table>
共<%=totalPages%>页 第<%=pageNo%>页
<a href="ShowArticleFlat.jsp?pageNo=<%=pageNo-1%>"> < </a>&nbsp;&nbsp;
<a href="ShowArticleFlat.jsp?pageNo=<%=pageNo+1%>"> > </a>

<form name="form1" action="ShowArticleFlat.jsp">
    <select name="pageNo" onchange="document.form1.submit()">
        <%
            for(int i = 1; i <= totalPages; i++){
        %>
            <option value=<%=i%><%=(pageNo == i) ? "selected":""%>>第<%=i%>页</option>
        <%
            }
        %>
    </select>
</form>
<form name="form2" action="ShowArticleFlat.jsp">
    <input type="text" size=4 name="pageNo" value="<%=pageNo%>">
    <input type="submit" value="go">
</form>
</body>
</html>