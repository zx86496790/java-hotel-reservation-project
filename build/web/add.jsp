<%-- 
    Document   : add
    Created on : 2014-3-27, 23:37:52
    Author     : zsen
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.Room"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ADD ROOM RESULT</title>
        <link rel="stylesheet" href="dist/css/bootstrap.min.css">
    </head>
    <body>
        <% 
                ArrayList<Room> alRoom=new ArrayList<Room>();
                String name = "zhnx0249";
		String password = "oracle";
		String url = "jdbc:oracle:thin:@dilbert.humber.ca:1521:grok";
		
			Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
			Connection connection = DriverManager.getConnection(url, name,password);
			if (connection != null) {
				Statement statement = connection.createStatement();
				ResultSet rs=statement.executeQuery("SELECT * FROM JAVA_PROJECT_ROOM");
				while (rs.next()) {
                                        Room r=new Room(rs.getInt(1)+"", rs.getInt(2)+"", rs.getDouble(3), rs.getString(4));
					alRoom.add(r);
                                }
			}
                        connection.close();
                        boolean flag=false;
                        for(Room r:alRoom)
                        {
                            if(request.getParameter("roomID").equalsIgnoreCase(r.getRoomId()))
                            {
                                flag=true;
                            }
                        }
		%>
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                </div>
                <div class="col-md-4">
        <%
            String roomID=request.getParameter("roomID");
            String floor=request.getParameter("floor");
            double price=0;
            if(request.getParameter("price").equalsIgnoreCase("")==false){
            price=Double.parseDouble(request.getParameter("price"));
            }
            String details=request.getParameter("details");
            if(roomID.equalsIgnoreCase(""))
            {
                %>
                <div class="thumbnail">
                    <img src="dist/pics/error.gif" alt="...">
                    <div class="caption">
                        <h3>NO ROOM NUMBER</h3>
                        <p>YOU MUST INPUT A VALID ROOM NUMBER</p>
                        <p><a href="admin.jsp" class="btn btn-primary btn-lg btn-block" role="button">GO BACK</a> </p>
                    </div>
                </div>
        <%
            }
            else if(floor.equalsIgnoreCase(""))
            {
                %>
                <div class="thumbnail">
                    <img src="dist/pics/error.gif" alt="...">
                    <div class="caption">
                        <h3>NO FLOOR NUMBER</h3>
                        <p>YOU MUST INPUT A VALID FLOOR NUMBER</p>
                        <p><a href="admin.jsp" class="btn btn-primary btn-lg btn-block" role="button">GO BACK</a> </p>
                    </div>
                </div>
                <%
            }
            else if(price<=0)
            {
                %>
                <div class="thumbnail">
                    <img src="dist/pics/error.gif" alt="...">
                    <div class="caption">
                        <h3>WRONG PRICE</h3>
                        <p>YOU MUST INPUT A VALID PRICE</p>
                        <p><a href="admin.jsp" class="btn btn-primary btn-lg btn-block" role="button">GO BACK</a> </p>
                    </div>
                </div>
                <%
            }else if(flag==true)
            {
                
                        %>
               <div class="thumbnail">
                    <img src="dist/pics/error.gif" alt="...">
                    <div class="caption">
                        <h3>ROOM NUMBER ERROR</h3>
                        <p>THE ROOM YOU WANT TO ADD ALREADY EXISTS</p>
                        <p><a href="admin.jsp" class="btn btn-primary btn-lg btn-block" role="button">GO BACK</a> </p>
                    </div>
                </div>
                        <%
            }else{

			connection = DriverManager.getConnection(url, name,password);
			if (connection != null) {
				Statement statement = connection.createStatement();
				int count = statement.executeUpdate("INSERT INTO JAVA_PROJECT_ROOM VALUES ("+roomID+","+floor+","+price+",'"+details+"')");
			}
                        connection.close();
                        %>
                        <div class="thumbnail">
                                <img src="dist/pics/done.jpg" alt="...">
                                <div class="caption">
                                    <h3>DONE</h3>
                                    <p>YOU HAVE ADDED THE RECORD</p>
                                    <p><a href="admin.jsp" class="btn btn-primary btn-lg btn-block" role="button">GO BACK</a> </p>
                                </div>
                            </div>
                        <%
            }
        %>

                </div>
                <div class="col-md-4">
                </div>
            </div>
        </div>
        
           <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="dist/js/jquery-1.10.2.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="dist/js/bootstrap.min.js"></script>
    </body>
</html>
