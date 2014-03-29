<%-- 
    Document   : book
    Created on : 2014-3-27, 10:06:04
    Author     : zsen
--%>

<%@page import="beans.BookInfo"%>
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
        <title>BOOKING PAGE</title>
        <link rel="stylesheet" href="dist/css/bootstrap.min.css">
        <link href="dist/css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
    </head>
    <body>
        <%if(session.getAttribute("id")==null)
        {
            response.sendRedirect("index.jsp");
        }
            
            ArrayList<BookInfo> alBookInfo=new ArrayList<BookInfo>();
            String name = "zhnx0249";
		String password = "oracle";
		String url = "jdbc:oracle:thin:@dilbert.humber.ca:1521:grok";
		
			Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
			Connection connection = DriverManager.getConnection(url, name,password);
			if (connection != null) {
				Statement statement = connection.createStatement();
				ResultSet rs=statement.executeQuery("SELECT * FROM JAVA_PROJECT_BOOKINFO WHERE USERID="+Integer.parseInt(session.getAttribute("id").toString()));
				while (rs.next()) {
                                        BookInfo bi=new BookInfo(rs.getInt(1)+"", rs.getInt(2)+"", rs.getInt(3)+"", rs.getDate(4).toString(), rs.getDate(5).toString());
					alBookInfo.add(bi);
                                }
			}
                        connection.close();
        %>
        <div class="container">
            <div class="row">
                <div class="col-md-8">
                    <table class="table table-bordered table-striped">
                     <tr><th>ROOM ID</th><th>START DATE</th><th>END DATE</th><th>EDIT</th><th>DELETE</th></tr>
                            <%
                                for(BookInfo bi:alBookInfo)
                                {
                                    out.print("<tr><td>"+bi.getRoomId()+"</td><td>"+bi.getStartDate()+"</td><td>$"+bi.getEndDate()+"</td><td><a href=\"book.jsp?bookID="+bi.getId()+"\" class=\"btn btn-default btn-xs\" role=\"button\">EDIT</a></td><td><a href=\"deleteBook.jsp?bookID="+bi.getId()+"\" class=\"btn btn-default btn-xs\" role=\"button\">DELETE</a></td></tr>");
                                }
                            %>
                    </table>
                </div>
                <div class="col-md-4">
                    <% if(request.getParameter("bookID")==null){ %>
                    <form method="post" action="addBook.jsp" role="form">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">ROOM ID</label>
                                    <input type="number" name="roomID" class="form-control" id="exampleInputEmail1" placeholder="ROOM ID">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">REQUEST</label>
                                    <input type="text" name="details" class="form-control" id="exampleInputEmail1" placeholder="REQUEST">
                                </div>
                                <hr/>
            <fieldset>
            <label for="dtp_input2" class="col-md-2 control-label">FROM</label>
            <div class="form-group">
                <div class="input-group date form_date col-md-8" data-date="" data-date-format="yyyy-mm-dd" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                    <input class="form-control" size="16" type="text" name="startDate" value="" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
					<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
                
				<input type="hidden" id="dtp_input2" value="" /><br/>
            </div>
            <label for="dtp_input2" class="col-md-2 control-label">TO</label>
            <div class="form-group">
                <div class="input-group date form_date col-md-8" data-date="" data-date-format="yyyy-mm-dd" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                    <input class="form-control" size="16" type="text" name="endDate" value="" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
					<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
                 
				<input type="hidden" id="dtp_input2" value="" /><br/>
            </div>
            </fieldset>
                                <button type="submit" class="btn btn-default">ADD</button>
                                <a href="index.jsp" class="btn btn-default" role="button">GO BACK TO MAIN PAGE</a>
                     </form>
                    <% }
                    else {
                    %>
                    <form method="post" action="editBook_01.jsp" role="form">
                        <input type="number" name="bookID" value="<% out.print(request.getParameter("bookID")); %>" hidden>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">ROOM ID :</label>
                                    <input type="number" name="roomID" class="form-control" id="exampleInputEmail1" placeholder="ROOM ID">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">REQUEST</label>
                                    <input type="text" name="details" class="form-control" id="exampleInputEmail1" placeholder="REQUEST">
                                </div>
                                <hr/>
            <fieldset>
            <label for="dtp_input2" class="col-md-2 control-label">FROM</label>
            <div class="form-group">
                <div class="input-group date form_date col-md-8" data-date="" data-date-format="yyyy-mm-dd" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                    <input class="form-control" size="16" type="text" name="startDate" value="" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
					<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
                
				<input type="hidden" id="dtp_input2" value="" /><br/>
            </div>
            <label for="dtp_input2" class="col-md-2 control-label">TO</label>
            <div class="form-group">
                <div class="input-group date form_date col-md-8" data-date="" data-date-format="yyyy-mm-dd" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                    <input class="form-control" size="16" type="text" name="endDate" value="" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
					<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
                 
				<input type="hidden" id="dtp_input2" value="" /><br/>
            </div>
            </fieldset>
                                <button type="submit" class="btn btn-default">EDIT</button>
                                <a href="index.jsp" class="btn btn-default" role="button">GO BACK TO MAIN PAGE</a>
                     </form>
                    <% } %>
                </div>
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
