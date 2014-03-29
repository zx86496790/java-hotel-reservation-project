<%-- 
    Document   : edit
    Created on : 2014-3-27, 22:05:40
    Author     : zsen
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>EDIT ROOM RESULT</title>
        <link rel="stylesheet" href="dist/css/bootstrap.min.css">
    </head>
    <body>
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
            }else
            { %>
                            <div class="thumbnail">
                                <img src="dist/pics/done.jpg" alt="...">
                                <div class="caption">
                                    <h3>DONE</h3>
                                    <p>YOU HAVE UPDATED THE RECORD</p>
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
