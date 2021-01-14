<%-- 
    Document   : studentApplyCollege
    Created on : Jan 13, 2021, 9:25:55 PM
    Author     : Yeoh Kai Xiang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="bean.User" %>

<c:if test="${sessionScope.user == null}">
    <c:redirect url="/notAuthorized.jsp" />   
</c:if>

<jsp:useBean id="user" class="bean.User" scope="session" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Apply College</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <sql:setDataSource
        var="collegeApplicationData"
        driver="com.mysql.jdbc.Driver"
        url="jdbc:mysql://localhost/college_application?allowMultiQueries=true"
        user="root" password=""
    />
        <sql:query dataSource="${collegeApplicationData}" var="listRoom">
            SELECT * from room where collegeID=?;
            <sql:param value="${param.cid}" />
        </sql:query>
       
        <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
         <div class="container">
            <a class="navbar-brand" href="#">CRAS </a>

            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
               <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarCollapse">

               <ul class="navbar-nav mr-auto">
                  <li class="nav-item ">
                    <a class="nav-link active" href="studentHome.jsp">Home </a>
                  </li>
               </ul>
                
                <div class="form-inline mt-2 mt-md-0">
                   <a class="btn btn-danger my-2 my-sm-0"  href="LogoutServlet"> Logout </a>
               </div>

            </div>
         </div>
      </nav>
        
        <main role="main" class="container">
            <nav aria-label="breadcrumb">
               <ol class="breadcrumb">
                  <li class="breadcrumb-item"><a href="studentHome.jsp">Home</a></li>
                  <li class="breadcrumb-item active" aria-current="page">View Room</li>
               </ol>
            </nav>
            <div class="card">
               <div class="container">
                   
                   <div class="row justify-content-md-center">
                       <div class="col col-md-6">
                           <h3>View Room List</h3>                           
                        <table class="table-light table-bordered">
                    <thead class="table-primary text-center">
                        <tr>
                            <th>Room ID</th>
                            <th>Room Name</th>
                            <th>Room Type</th>
                            <th>Capacity</th>
                            <th>Occupied</th>
                            <th>Operation</th>
                        </tr>
                    </thead>
                    <tbody class="table-secondary text-center">
                        <c:forEach items="${listRoom.rows}" var="room">
                            <form action="StudentApplyCollegeRoomServlet" method="POST">
                            <c:if test="${room.capacity - room.occupied > 0}" >
                                <tr>                           
                                    <td><c:out value="${room.roomID}" /></td>  
                                    <td><c:out value="${room.roomName}" /></td>  
                                    <td><c:out value="${room.roomType}" /></td>
                                    <td><c:out value="${room.capacity}" /></td>
                                    <td><c:out value="${room.occupied}" /></td>
                                    <td> <button type="submit" class="btn btn-primary align-content-center">Apply</button></td>
                                </tr>
                            </c:if>
                            <input type="hidden" name="occupied" value="${room.occupied}">
                            <input type="hidden" name="rid"  id="roomID" value="${room.roomID}">
                            </form>
                        </c:forEach>
                    </tbody>
                </table>
                           
                        </div>  
                    </div>
               </div>
            </div>  
           
        </main>
    </body>
</html>