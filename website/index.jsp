<%@page import="java.sql.*"%>
<%@page language = "java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href='http://fonts.googleapis.com/css?family=Arizonia' rel='stylesheet' type='text/css'>
        <link href="https://fonts.googleapis.com/css?family=Josefin+Sans" rel="stylesheet">
        <style>
            input[type=text] {
                width: 400px;
                box-sizing: border-box;
                border: 2px solid #ccc;
                border-radius: 4px;
                font-size: 16px;
                background-color: white;
                background-position: 10px 10px; 
                background-repeat: no-repeat;
                padding: 12px 20px 12px 40px;
            }
            input[type=date] {
                width: 225px;
                height:40px;
                box-sizing: border-box;
                border: 2px solid #ccc;
                border-radius: 4px;
                font-size: 16px;
                background-color: white;
                background-position: 10px 10px; 
                background-repeat: no-repeat;
                padding: 12px 20px 12px 40px;
            }
            #gobutton {
                color: #ffffff;
                background: rgba(0,0,0,0);
                border: solid 3px #ffffff;
                font-size: 125%;
                font-family: 'Josefin Sans', sans-serif;
                display:block;
                width: 50%;
                margin: 0 auto;
                border-radius:25px;
            }

            #gobutton:hover{
                border-color: #b1b1b1;
                color: #b1b1b1;
            }

            #revbutton {
                position:fixed;
                left: 30%;
                transform: translate(-50%, -50%);
                bottom: 25px;
                color: #ffffff;
                background: rgba(0,0,0,0);
                border: transparent;
                font-size: 125%;
                font-family: 'Josefin Sans', sans-serif;
                display:block;
                width: 50%;
                margin: 0 auto;
                border-radius:25px;
            }

            #revbutton:hover{
                text-decoration: underline;
            }

            #regbutton {
                position:fixed;
                left: 70%;
                transform: translate(-50%, -50%);
                bottom: 25px;
                color: #ffffff;
                background: rgba(0,0,0,0);
                border: transparent;
                font-size: 125%;
                font-family: 'Josefin Sans', sans-serif;
                display:block;
                width: 50%;
                margin: 0 auto;
                border-radius:25px;
            }

            h2{
                text-align: center;
            }

            #regbutton:hover{
                text-decoration: underline;
            }

            #centered {
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
            }

            body {
                background-image: url("http://findmombasahotels.com/wp-content/uploads/2013/05/Night2.jpg");
                background-repeat: no-repeat;
                font-family: 'Josefin Sans', sans-serif;
                color: #ffffff;
            }

            h1 {
                text-align: center;
                font: 400 70px/1 'Arizonia', Helvetica, sans-serif;
                color: #ffffff;
                text-shadow: 4px 4px 0px rgba(0,0,0,0.1);
            }

            p1 {
                position: fixed;
                top: 25%;
                left: 50%;
                transform: translate(-50%, -50%);
                color: #ffffff;
                font-size: 130%;
            }

            p2 {
                position:fixed;
                bottom: 50px;
                left: 30%;
                transform: translate(-50%, -50%);
                text-align: center;
                font-family: 'Josefin Sans', sans-serif;
                color: #ffffff;
                font-size: 130%;
            }

            p3 {
                position:fixed;
                bottom: 50px;
                left: 70%;
                transform: translate(-50%, -50%);
                text-align: center;
                font-family: 'Josefin Sans', sans-serif;
                color: #ffffff;
                font-size: 130%;
            }

            select {
                -webkit-appearance: none;  
                -moz-appearance: none; 
                border: 0 !important; 

                font-family: 'Josefin Sans', sans-serif;
                color: black;
                -webkit-border-radius: 5px;
                border-radius:15px;
                font-size: 16px;
                padding: 10px;
                cursor: pointer;

                background: #ffffff url(drop-down-arrow.png) no-repeat right;
                background-size: 40px 37px;
            }
        </style>
        <title>Hulton Hotels</title>
    </head>
    <body>
        <h1>Hulton</h1>
        <h2>Hulton Hotels offer a wide variety of offers and services 
            at select locations.</h2>        
        <div id="centered">
            Destination:
            <br/>       
            <form action="rooms.jsp">
                <%
                    String URL = "jdbc:mysql://localhost:3306/hoteldb";
                    String USER = "root";
                    String PASS = "jdeignan1";

                    Connection connection = null;
                    PreparedStatement selectLocations = null;
                    ResultSet resultSet = null;

                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        connection = DriverManager.getConnection(URL, USER, PASS);
                        String query = "SELECT STATE, COUNTRY FROM HOTEL GROUP BY STATE";
                        selectLocations = connection.prepareStatement(query);
                        resultSet = selectLocations.executeQuery();
                %>  
                <select name="location">
                    <% while (resultSet.next()) {
                            String states = resultSet.getString("State");
                            states = states.substring(0, 1).toUpperCase() + states.substring(1).toLowerCase();
                            String country = resultSet.getString("Country");
                            country = country.substring(0, 1).toUpperCase() + country.substring(1).toLowerCase();
                            String together = states + ", " + country;
                    %>
                    <option value="<%=together%>"><%=together%></option><br/><br/>
                    <% } %>
                </select>
                <br/>
                <br/>Check-In Date:
                <br/><input type="date" name="checkin"><br/>
                <br/>Check-Out Date:
                <br/><input type="date" name="checkout"><br/>
                <br/><input id="gobutton" type="submit" value="GO"/>
            </form>
        </div>
        <%
            } catch (SQLException e) {
                out.println(e);
            }%>
    <p3>First time staying with us? </p3><br/>
    <form action ="register.jsp">
        <input id="regbutton" type="submit" 
               value="Click here to register now."/>
    </form>
    <p2>Stayed at one of our resorts recently?</p2><br/>
    <form action ="review.jsp">
        <input id="revbutton" type="submit" 
               value="Click here to give us a review."/>
    </form>
</body>
</html>
