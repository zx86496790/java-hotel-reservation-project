<%-- 
    Document   : index
    Created on : 2014-3-26, 22:12:41
    Author     : zsen
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
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
                        /*for(BookInfo bi : alBookInfo)
                        {
                            out.print(bi.toString()+"<br/>");
                        }
                        for(Room r : alRoom)
                        {
                            out.print(r.toString()+"<br/>");
                        }*/
                        connection.close();
		%>
                
                <div class="container">
                    <div class="row">
                        <div class="col-md-8">
                            <div id="myCarousel" class="carousel slide" data-ride="carousel">
                            <!-- Indicators -->
                                <ol class="carousel-indicators">
                                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                                    <li data-target="#myCarousel" data-slide-to="1"></li>
                                    <li data-target="#myCarousel" data-slide-to="2"></li>
                                </ol>
                                <div class="carousel-inner">
                                    <div class="item active">
                                        <img src="dist/pics/1.jpg" alt="First slide">
                                    </div>
                                    <div class="item">
                                        <img src="dist/pics/2.jpg" alt="Second slide">
                                    </div>
                                    <div class="item">
                                        <img src="dist/pics/3.jpg" alt="Third slide">
                                    </div>
                                </div>
                                <a class="left carousel-control" href="#myCarousel" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a>
                                <a class="right carousel-control" href="#myCarousel" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
                            </div><!-- /.carousel -->
                        </div>
                        <div class="col-md-4">
                <% 
                if(request.getSession().getAttribute("userLevel")==null)
                {%>
                <form  role="form" method="post" action="login.jsp">
                    <div class="form-group">
                        <label for="exampleInputEmail1">Name</label>
                        <input type="text" class="form-control" id="exampleInputEmail1" name="userName" placeholder="Name">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">Password</label>
                        <input type="password" class="form-control" id="exampleInputPassword1" name="userPwd" placeholder="Password">
                    </div>
                    <button type="submit" class="btn btn-default">Submit</button>
                </form>
                <%
                }
                else if(Integer.parseInt(request.getSession().getAttribute("userLevel").toString())==1)
                {%>
                <form  role="form" method="post" action="login.jsp">
                    <div class="form-group">
                        <label for="exampleInputEmail1">Name</label>
                        <input type="text" class="form-control" id="exampleInputEmail1" name="userName" placeholder="<% out.print(session.getAttribute("userName").toString()); %>">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">User Level</label>
                        <input type="password" class="form-control" id="exampleInputPassword1" name="userPwd" placeholder="ADMIN">
                    </div>
                    <a href="admin.jsp" class="btn btn-info" role="button">Admin Page</a>
                    <a href="destroy.jsp" class="btn btn-info" role="button">Logout</a>
                </form>
                <%
                } else if(Integer.parseInt(request.getSession().getAttribute("userLevel").toString())==2)
                {%>
                <form  role="form" method="post" action="login.jsp">
                    <div class="form-group">
                        <label for="exampleInputEmail1">Name</label>
                        <input type="text" class="form-control" id="exampleInputEmail1" name="userName" placeholder="<% out.print(session.getAttribute("userName").toString()); %>">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">User Level</label>
                        <input type="password" class="form-control" id="exampleInputPassword1" name="userPwd" placeholder="REGULAR USER">
                    </div>
                    <a href="book.jsp" class="btn btn-info" role="button">User Page</a>
                    <a href="destroy.jsp" class="btn btn-info" role="button">Logout</a>
                </form>
                <%
                }
		%>
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2444.161338395607!2d-79.38705699999988!3d43.64256601595129!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x882b34d68bf33a9b%3A0x15edd8c4de1c7581!2sCN+Tower!5e1!3m2!1szh-CN!2sca!4v1395935391847" width="400" height="280" frameborder="0" style="border:0">   
                </iframe>
                        </div>
                    </div>
                <div class="row">
                    <div class="col-md-8">
                        <table class="table table-bordered table-striped">
                            <tr><th>ROOM ID</th><th>FLOOR</th><th>PRICE</th><th>DETAILS</th></tr>
                            <%
                                for(Room r:alRoom)
                                {
                                    out.print("<tr><td>"+r.getRoomId()+"</td><td>"+r.getFloor()+"</td><td>$"+r.getPrice()+"</td><td>"+r.getSpecification()+"</td></tr>");
                                }
                            %>
                        </table>
                    </div>
                    <div class="col-md-4">
                        <table class="table table-bordered table-striped">
                            <tr><th>Booked Rooms</th></tr>
                            <%
                                SimpleDateFormat sdf=new SimpleDateFormat("yy-MM-dd");
                                java.sql.Date date1=null;
                                java.sql.Date date2=null;
                                for(BookInfo bi :alBookInfo){
                                try{
                                    date1=new java.sql.Date((sdf.parse(bi.getStartDate())).getTime());
                                    date2=new java.sql.Date((sdf.parse(bi.getEndDate())).getTime());
                                    }
                                catch(Exception e)
                                {
                                }
                                    Date date03=new Date();
                                    java.sql.Date date3=new java.sql.Date((sdf.parse(sdf.format(date03))).getTime());
                                    if(((date3.compareTo(date1))>0)&&((date3.compareTo(date2)<0))){
                                    out.print("<tr><td>"+bi.getRoomId()+"</td></tr>");
                                    }
                                }
                            %>
                        </table>
                    </div>
                </div>
                </div>
                
             <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="dist/js/jquery-1.10.2.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="dist/js/bootstrap.min.js"></script>     
    </body>
</html>
