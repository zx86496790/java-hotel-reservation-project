<%-- 
    Document   : index
    Created on : 2014-3-26, 22:12:41
    Author     : zsen
--%>

<%@page import="beans.Room"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.BookInfo"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HOTEL RESERVATION SYSTEM</title>
    </head>
    <body>
        <% 
                ArrayList<BookInfo> alBookInfo=new ArrayList<BookInfo>();
                ArrayList<Room> alRoom=new ArrayList<Room>();
                String name = "zhnx0249";
		String password = "oracle";
		String url = "jdbc:oracle:thin:@dilbert.humber.ca:1521:grok";
		
			Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
			Connection connection = DriverManager.getConnection(url, name,password);
			if (connection != null) {
				Statement statement = connection.createStatement();
				ResultSet rs = statement.executeQuery("SELECT * FROM JAVA_PROJECT_BOOKINFO");
				while (rs.next()) {
                                        BookInfo bi=new BookInfo(rs.getInt(1)+"", rs.getInt(2)+"", rs.getInt(3)+"", rs.getDate(4).toString(), rs.getDate(5).toString());
					alBookInfo.add(bi);
                                }
                                rs=statement.executeQuery("SELECT * FROM JAVA_PROJECT_ROOM");
				while (rs.next()) {
                                        Room r=new Room(rs.getInt(1)+"", rs.getInt(2)+"", rs.getDouble(3), rs.getString(4));
					alRoom.add(r);
                                }
			}
                        for(BookInfo bi : alBookInfo)
                        {
                            out.print(bi.toString()+"<br/>");
                        }
                        for(Room r : alRoom)
                        {
                            out.print(r.toString()+"<br/>");
                        }
		ServletContext sc=getServletContext();
                if(request.getSession().isNew())
                {%>
                <a href="login.jsp">login</a>
                    <%
                }
		%>
                
    </body>
</html>
