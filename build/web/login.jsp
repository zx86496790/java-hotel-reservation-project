<%-- 
    Document   : login
    Created on : 2014-3-26, 23:11:14
    Author     : zsen
--%>


<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
              <%
                ArrayList<User> alUser=new ArrayList<User>();
                String name = "zhnx0249";
		String password = "oracle";
		String url = "jdbc:oracle:thin:@dilbert.humber.ca:1521:grok";
		
			Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
			Connection connection = DriverManager.getConnection(url, name,password);
			if (connection != null) {
				Statement statement = connection.createStatement();
				ResultSet rs = statement.executeQuery("SELECT * FROM JAVA_PROJECT_USER");
				while (rs.next()) {
                                        User u=new User(rs.getInt(1)+"", rs.getInt(2), rs.getString(3), rs.getString(4));
					alUser.add(u);
                                }
                               boolean flag=false;
                               for(User u:alUser)
                               {
                                   String userName=request.getParameter("userName");
                                   String userPwd=request.getParameter("userPwd");
                                   if(userName.equalsIgnoreCase(u.getName())&&userPwd.equalsIgnoreCase(u.getPassword()))
                                   {
                                      flag=true;
                                      session.setAttribute("id", u.getId());
                                      session.setAttribute("userLevel", u.getLevel());
                                      session.setAttribute("userName", u.getName());
                                      session.setAttribute("userPwd", u.getPassword());
                                   }
                               }
                               if(flag==false)
                               {
                                   out.println("user not exist");
                               }
                               else
                               {
                                   if(Integer.parseInt(session.getAttribute("userLevel").toString())==1)
                                   {
                                       response.sendRedirect("admin.jsp");
                                   }
                                   else
                                   {
                                       response.sendRedirect("book.jsp");
                                   }
                                   out.println(session.getAttribute("id").toString());
                               }
			}
                        else
                        {
                            out.println("DB ERROR");
                        }
        %>
    </body>
</html>
