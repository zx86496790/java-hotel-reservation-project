<%-- 
    Document   : editBook
    Created on : 2014-3-31, 11:45:25
    Author     : zsen
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="beans.Room"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.BookInfo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
                        out.println(request.getParameter("bookID"));
                        connection.close();
                        boolean flag=false;
                        for(Room r:alRoom)
                        {
                            if(request.getParameter("roomID").equalsIgnoreCase(r.getRoomId()))
                            {
                                flag=true;
                            }
                        }
                        for(BookInfo bi:alBookInfo)
                        {
                            if(request.getParameter("bookID").equalsIgnoreCase(bi.getId()))
                            {
                               alBookInfo.remove(bi);
                            }
                        }
		%>
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                </div>
                <div class="col-md-4">
        <%out.println("hhh01");
            String roomID=request.getParameter("roomID");
            String details=request.getParameter("details");
            String bookStartDate=request.getParameter("startDate");
            String bookEndDate=request.getParameter("endDate");
            if(roomID.equalsIgnoreCase(""))
          {
                %>
                <div class="thumbnail">
                    <img src="dist/pics/error.gif" alt="...">
                    <div class="caption">
                        <h3>NO ROOM NUMBER</h3>
                        <p>YOU MUST INPUT A VALID ROOM NUMBER</p>
                        <p><a href="book.jsp" class="btn btn-primary btn-lg btn-block" role="button">GO BACK</a> </p>
                    </div>
                </div>
        <%
            }else if(flag==false)
            {
                        %>
               <div class="thumbnail">
                    <img src="dist/pics/error.gif" alt="...">
                    <div class="caption">
                        <h3>ROOM NUMBER ERROR</h3>
                        <p>THE ROOM YOU WANT TO ADD ALREADY EXISTS</p>
                        <p><a href="book.jsp" class="btn btn-primary btn-lg btn-block" role="button">GO BACK</a> </p>
                    </div>
                </div>
                        <%
            }else if(bookStartDate.equalsIgnoreCase("")||bookEndDate.equalsIgnoreCase(""))
            {
                        %>
               <div class="thumbnail">
                    <img src="dist/pics/error.gif" alt="...">
                    <div class="caption">
                        <h3>DATE IS MISSING</h3>
                        <p>START DATE OR END DATE IS MISSING</p>
                        <p><a href="book.jsp" class="btn btn-primary btn-lg btn-block" role="button">GO BACK</a> </p>
                    </div>
                </div>
                        <%
            }
            else 
            {                          SimpleDateFormat sdf=new SimpleDateFormat("yyyy-mm-dd");
                                       Date bookDateStart=null;
                                       Date bookDateEnd=null;
                                       bookDateStart=sdf.parse(bookStartDate);
                                       bookDateEnd=sdf.parse(bookEndDate);
                if(bookDateEnd.compareTo(bookDateStart)<=0){
                %>
                <div class="thumbnail">
                    <img src="dist/pics/error.gif" alt="...">
                    <div class="caption">
                        <h3>DATE WRONG</h3>
                        <p>END DATE MUST BE GREATER THAN START DATE</p>
                        <p><a href="book.jsp" class="btn btn-primary btn-lg btn-block" role="button">GO BACK</a> </p>
                    </div>
                </div>
                <%}
                else
                {out.println("hhh01");
                    for(BookInfo bi:alBookInfo)
                    {
                         Date bookInfoStartDate=sdf.parse(bi.getStartDate());
                         Date bookInfoEndDate=sdf.parse(bi.getEndDate());
                         if(bi.getRoomId().equalsIgnoreCase(request.getParameter("roomID"))){
                         if((bookDateStart.compareTo(bookInfoStartDate)>=0&&bookDateStart.compareTo(bookInfoEndDate)<=0)||(bookDateEnd.compareTo(bookInfoStartDate)>=0&&bookDateEnd.compareTo(bookInfoEndDate)<=0)||(bookDateStart.compareTo(bookInfoStartDate)>=0&&bookDateEnd.compareTo(bookInfoEndDate)<=0)||(bookDateStart.compareTo(bookInfoStartDate)<=0&&bookDateEnd.compareTo(bookInfoEndDate)>=0))
                         {
                              %>
                                <div class="thumbnail">
                                    <img src="dist/pics/error.gif" alt="...">
                                    <div class="caption">
                                    <h3>DATE HAS BEEN BOOKED</h3>
                                    <p>DURING THE PERIOD THE ROOM HAS BEEN BOOKED</p>
                                    <p><a href="book.jsp" class="btn btn-primary btn-lg btn-block" role="button">GO BACK</a> </p>
                                    </div>
                                </div>
                <%}
                         else
                         {out.print(request.getParameter("bookID"));out.println("hhh01");
                          //   connection = DriverManager.getConnection(url, name,password);
                           //  ArrayList<Integer> ar=new ArrayList<Integer>();
                         //    if (connection != null) {
                               
                         
                           //  }
				/*Statement statement = connection.createStatement();
                                //statement.executeUpdate("INSERT INTO JAVA_PROJECT_BOOKINFO VALUES(8,301,5,"+bookDateStart+","+bookDateEnd+"'afs')");
				//statement.executeUpdate("INSERT INTO JAVA_PROJECT_BOOKINFO VALUES("+maxID+1+","+Integer.parseInt(request.getParameter("roomID"))+","+Integer.parseInt(session.getAttribute("id").toString())+","+bookDateStart+","+bookDateEnd+",'"+request.getParameter("details")+"')");
				PreparedStatement pstmt = connection.prepareStatement("UPDATE JAVA_PROJECT_BOOKINFO set roomid=? , message=? ,startdate=? , enddate=? where bookid=?");
                                pstmt.setInt(5, Integer.parseInt(request.getParameter("bookID")));
                                pstmt.setInt(1, Integer.parseInt(roomID));
                                java.sql.Date ds=java.sql.Date.valueOf(bookStartDate);
                                java.sql.Date de=java.sql.Date.valueOf(bookEndDate);
                                pstmt.setDate(3, ds);
                                pstmt.setDate(4, de);
                                pstmt.setString(2, request.getParameter("details"));
                                pstmt.execute();
                                response.sendRedirect("book.jsp");*/
			}
                         }
                         }
                         
                    }
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
