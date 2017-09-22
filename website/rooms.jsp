<%@page import="java.sql.*" import="java.io.*" import="java.lang.*" import="java.util.*"%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href='http://fonts.googleapis.com/css?family=Arizonia' rel='stylesheet' type='text/css'>
        <link href="https://fonts.googleapis.com/css?family=Josefin+Sans" rel="stylesheet">
        <title>Hulton Hotels</title>
        <style>
            h1{
                text-align: center;
                font: 400 70px/1 'Arizonia', Helvetica, sans-serif;
                color: #ffffff;
                text-shadow: 4px 4px 0px rgba(0,0,0,0.1);
            }

            body {    
                background-image: url("http://findmombasahotels.com/wp-content/uploads/2013/05/Night2.jpg");
                background-repeat: no-repeat;
                font-family: 'Josefin Sans', sans-serif;
                color: #ffffff;
                font-size: 130%;
            }

            table {
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                width: 75%;
            }

            tr {
                border-radius: 6px 6px 6px 6px;
                background-color: rgba(7, 10, 33, 0.6);
                border-color: #ffffff;
                color: #ffffff;
            }

            td {
                background-color: rgba(7, 10, 33, 0.6);
                color: #ffffff;
                padding: 8px;
                text-align: left;
            }

            #resbutton {
                color: #ffffff;
                background: rgba(0,0,0,0);
                border: solid 3px #ffffff;
                font-size: 60%;
                font-family: 'Josefin Sans', sans-serif;
                display:block;
                width: 100%;
                margin: 0 auto;
                border-radius:25px;
            }

            #resbutton:hover{
                border-color: #b1b1b1;
                color: #b1b1b1;
            }

            #centered {
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
            }
        </style>
    </head>
    <body>    
        <%
            String place;
            String country;
            String state;
            String[] temp;
            place = request.getParameter("location");
            String checkin = request.getParameter("checkin");
            String checkout = request.getParameter("checkout");

            temp = place.split(",");
            state = temp[0].trim();
            country = temp[1].trim();

            String URL = "jdbc:mysql://localhost:3306/hoteldb";
            String USER = "root";
            String PASS = "jdeignan1";

            Connection connection = null;
            PreparedStatement select = null;
            ResultSet resultSet = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USER, PASS);
                String query = "SELECT RTYPE, RDESCRIPTION, MIN(RPRICE), CAPACITY FROM ROOM, hotel WHERE COUNTRY=? AND STATE=? AND HOTELID=ROOMHOTELID GROUP BY RTYPE;";
                select = connection.prepareStatement(query);
                select.setString(1, country);
                select.setString(2, state);
                resultSet = select.executeQuery();
        %>
        <h1><%=state%></h1>        
        <table>            
            <tbody>
                <tr>
                    <th>Type of Room:</th>
                    <th>Description:</th>
                    <th>Maximum Persons:</th>
                    <th>Starting at:</th>
                </tr>
            <form action="roomreservation.jsp">
                <% while (resultSet.next()) {
                        String roomType = resultSet.getString("RTYPE");
                        String rDesc = resultSet.getString("RDESCRIPTION");
                        String rPrice = resultSet.getString("MIN(RPRICE)");
                        String capacity = resultSet.getString("CAPACITY");
                %>
                <tr>
                    <td><%=roomType%></td>
                    <td><%=rDesc%></td>
                    <td><%=capacity%></td>
                    <td><%=rPrice%> per night</td>                
                    <td>
                        <form action="roomreservation.jsp">
                            <input  id="resbutton" type="submit" value="RESERVE"/>
                            <input type="hidden" name="roomtype" value="<%=roomType%>"/>
                            <input type="hidden" name="place" value="<%=place%>"/>
                            <input type="hidden" name="price" value="<%=rPrice%>"/>
                            <input type="hidden" name="checkin" value="<%=checkin%>"/>
                            <input type="hidden" name="checkout" value="<%=checkout%>"/>
                        </form>
                    </td>
                </tr>
            </form>
            <% }
                } catch (SQLException e) {
                    out.println(e);
                }%>
        </tbody>
    </table>
</body>
</html>
