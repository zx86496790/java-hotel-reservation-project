<%-- 
    Document   : admin
    Created on : 2014-3-27, 10:29:52
    Author     : zsen
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
         <link href="dist/css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
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
                                <a href="index.jsp" class="btn btn-default" role="button">GO BACK TO MAIN PAGE</a>
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
                                <a href="index.jsp" class="btn btn-default" role="button">GO BACK TO MAIN PAGE</a>
                            </form>
                              <% } %>
                        </div>
                    </div>
                        <div class="row">
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
                            <form class="form-inline" role="form" method="post" action="admin.jsp">
            <fieldset>
            <div class="form-group">
                <label for="dtp_input2" class="col-md-2 control-label">START DATE</label>
                <div class="input-group date form_date col-md-5" data-date="" data-date-format="yyyy-mm-dd" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                    <input class="form-control" size="16" type="text" name="startDate" value="" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
					<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
				<input type="hidden" id="dtp_input2" value="" /><br/>
            </div>
            <div class="form-group">
                <label for="dtp_input2" class="col-md-2 control-label">END DATE</label>
                <div class="input-group date form_date col-md-5" data-date="" data-date-format="yyyy-mm-dd" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                    <input class="form-control" size="16" type="text" name="endDate" value="" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
					<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
				<input type="hidden" id="dtp_input2" value="" /><br/>
            </div>
            </fieldset>
                                <div class="col-md-12"><button type="submit" class="btn btn-info">CHECK</button></div>
                            </form>
                            </div>
                            <div class="col-md-1"></div>
                        </div>
                        <hr/>
                        <div class="row">
                            <div class="col-md-3"></div>
                            <div class="col-md-6">
                              
                                <% 
                                   String startDate=request.getParameter("startDate");
                                   String endDate=request.getParameter("endDate");
                                   if(startDate!=null&&endDate!=null)
                                   {
                                      
                                       SimpleDateFormat sdf=new SimpleDateFormat("yyyy-mm-dd");
                                       Date dateStart=null;
                                       Date dateEnd=null;
                                       dateStart=sdf.parse(startDate);
                                       dateEnd=sdf.parse(endDate);
                                   if(dateEnd.compareTo(dateStart)>=0){
                                        %> <table class="table table-bordered table-striped">
                                            <tr><th>ROOM ID</th><th>START DATE</th><th>END DATE</th></tr>
                                      <% for(BookInfo bi:alBookInfo)
                                       {
                                            String bookStartDate=bi.getStartDate();
                                            String bookEndDate=bi.getEndDate();
                                            Date bookDateStart=sdf.parse(bookStartDate);
                                            Date bookDateEnd=sdf.parse(bookEndDate);
                                           if((dateStart.compareTo(bookDateStart)>=0&&dateStart.compareTo(bookDateEnd)<=0)||(dateEnd.compareTo(bookDateStart)>=0&&dateEnd.compareTo(bookDateEnd)<=0)||(dateStart.compareTo(bookDateStart)>=0&&dateEnd.compareTo(bookDateEnd)<=0)||(dateStart.compareTo(bookDateStart)<=0&&dateEnd.compareTo(bookDateEnd)>=0))
                                          {
                                               out.print("<tr><td>"+bi.getRoomId()+"</td><td>"+bi.getStartDate()+"</td><td>"+bi.getEndDate()+"</td></tr>");
                                           }
                                       }
                                         %></table><%
                                       }
                                   else
                                   {
                                       %>
                                       <div class="alert alert-danger">END DATE CANNOT BE LESS THAN START DATE</div>
                                       <%
                                   }
                                   }
                                %>
                                
                            </div>
                            <div class="col-md-3"></div>
                        </div>
                </div>
                
                 <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="dist/js/jquery-1.10.2.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="dist/js/bootstrap.min.js"></script>     
    <script type="text/javascript" src="dist/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
    <script type="text/javascript" src="dist/js/bootstrap-datetimepicker.fr.js" charset="UTF-8"></script>
    <script type="text/javascript">
    $('.form_datetime').datetimepicker({
        //language:  'fr',
        weekStart: 1,
        todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0,
        showMeridian: 1
    });
	$('.form_date').datetimepicker({
        language:  'fr',
        weekStart: 1,
        todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 2,
		forceParse: 0
    });
	$('.form_time').datetimepicker({
        language:  'fr',
        weekStart: 1,
        todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 1,
		minView: 0,
		maxView: 1,
		forceParse: 0
    });
</script>
    </body>
</html>
