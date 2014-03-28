<%-- 
    Document   : admin
    Created on : 2014-3-27, 10:29:52
    Author     : zsen
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="beans.Room"%>
<%@page import="beans.BookInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ADMIN PAGE</title>
        <link rel="stylesheet" href="dist/css/bootstrap.min.css">
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
                        connection.close();
		%>
                <div class="container">
                    <div class="row">
                        <div class="col-md-8">
                        <table class="table table-bordered table-striped">
                            <tr><th>ROOM ID</th><th>FLOOR</th><th>PRICE</th><th>DETAILS</th><th>EDIT</th><th>DELETE</th></tr>
                            <%
                                for(Room r:alRoom)
                                {
                                    out.print("<tr><td>"+r.getRoomId()+"</td><td>"+r.getFloor()+"</td><td>$"+r.getPrice()+"</td><td>"+r.getSpecification()+"</td><td><a href=\"admin.jsp?roomID="+r.getRoomId()+"\" class=\"btn btn-default btn-xs\" role=\"button\">EDIT</a></td><td><a href=\"delete.jsp?roomID="+r.getRoomId()+"\" class=\"btn btn-default btn-xs\" role=\"button\">DELETE</a></td></tr>");
                                }
                            %>
                        </table>
                        </div>
                        <div class="col-md-4">
                            <% 
                                if(request.getParameter("roomID")==null){ 
                            %>
                            <form method="post" action="add.jsp" role="form">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">ROOM ID</label>
                                    <input type="text" name="roomID" class="form-control" id="exampleInputEmail1" placeholder="ROOM ID">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">FLOOR</label>
                                    <input type="text" name="floor" class="form-control" id="exampleInputEmail1" placeholder="FLOOR">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">PRICE</label>
                                    <input type="text" name="price" class="form-control" id="exampleInputEmail1" placeholder="PRICE">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">DETAILS</label>
                                    <input type="text" name="details" class="form-control" id="exampleInputEmail1" placeholder="DETAILS">
                                </div>
                                <button type="submit" class="btn btn-default">ADD TO RECORD</button>
                            </form>
                              <% }else {
                                    String roomID="";
                                    String floor="";
                                    double price=0;
                                    String specification="";
                                    for(Room r:alRoom)
                                    {
                                        if(request.getParameter("roomID").equalsIgnoreCase(r.getRoomId()))
                                        {
                                            roomID=r.getRoomId();
                                            floor=r.getFloor();
                                            price=r.getPrice();
                                            specification=r.getSpecification();
                                        }
                                    }
                              %>
                              <form method="post" action="edit.jsp" role="form">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">ROOM ID</label>
                                    <label  id="exampleInputEmail1"><% out.print(roomID); %></label>
                                    <input type="hidden" class="form-control" name="roomID" id="exampleInputEmail1" value="<% out.print(roomID); %>">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">FLOOR</label>
                                    <input type="number" class="form-control" name="floor" id="exampleInputEmail1" value="<% out.print(floor); %>">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">PRICE</label>
                                    <input type="number" class="form-control" name="price" id="exampleInputEmail1" value="<% out.print(price); %>">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">DETAILS</label>
                                    <input type="text" class="form-control" name="details" id="exampleInputEmail1" value="<% out.print(specification); %>">
                                </div>
                                <button type="submit" class="btn btn-default">UPDATE RECORD</button>
                            </form>
                              <% } %>
                        </div>
                    </div>
                </div>
                
                 <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="dist/js/jquery-1.10.2.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="dist/js/bootstrap.min.js"></script>     
    </body>
</html>
