<%@page import="java.sql.*" import="java.io.*" import="java.lang.*" import="java.util.*"%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href='http://fonts.googleapis.com/css?family=Arizonia' rel='stylesheet' type='text/css'>
        <link href="https://fonts.googleapis.com/css?family=Josefin+Sans" rel="stylesheet">
        <style>
            p2 {
                font-size: 140%;
                border-left: 6px solid white;
                border-right: 6px solid white;
                background-color: rgba(7, 10, 33, 0.6);
            }
            h1{
                text-align: center;
                font: 400 70px/1 'Arizonia', Helvetica, sans-serif;
                color: #ffffff;
                text-shadow: 4px 4px 0px rgba(0,0,0,0.1);
            }

            p {
                border-left: 6px solid lightblue;
                background-color: lightgrey;
            }

            body {    
                background-image: url("http://findmombasahotels.com/wp-content/uploads/2013/05/Night2.jpg");
                background-repeat: no-repeat;
                font-family: 'Josefin Sans', sans-serif;
                color: #ffffff;
                font-size: 130%;
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
                top: 40%;
                left: 50%;
                transform: translate(-50%, -50%);
            }

            #bottomtable {
                position: absolute;
                bottom: 2px;
                left: 50%;
                transform: translate(-50%, -50%);
                text-align: center;
                font-family: 'Josefin Sans', sans-serif;
                color: #ffffff;
                font-size: 80%;
            }
        </style>
        <title>Hulton Hotels</title>
    </head>
    <body>    
        <%
            String country;
            String state;
            String maxcap;
            String hotelid = "";
            String[] temp;
            String[] discroomno;
            String[] discount;
            String[] discountroomtype;
            String[] discountmaxcap;

            ArrayList<String> discroomlist = new ArrayList<String>();
            ArrayList<String> discountlist = new ArrayList<String>();
            ArrayList<String> discountrtype = new ArrayList<String>();
            ArrayList<String> discountcap = new ArrayList<String>();

            String rtype = request.getParameter("roomtype");
            String place = request.getParameter("place");
            String checkin = request.getParameter("checkin");
            String checkout = request.getParameter("checkout");

            String URL = "jdbc:mysql://localhost:3306/hoteldb";
            String USER = "root";
            String PASS = "jdeignan1";

            temp = place.split(",");
            state = temp[0].trim();
            country = temp[1].trim();
            rtype = rtype.trim();

            Connection connection = null;
            Connection connection1 = null;
            Connection connection2 = null;
            PreparedStatement selectRoom = null;
            PreparedStatement selectDisc = null;
            PreparedStatement selectID = null;
            ResultSet resultRoom = null;
            ResultSet resultDisc = null;
            ResultSet resultID = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USER, PASS);
                connection1 = DriverManager.getConnection(URL, USER, PASS);
                connection2 = DriverManager.getConnection(URL, USER, PASS);

                String hotel = "SELECT HOTELID FROM HOTEL WHERE COUNTRY=? AND STATE=?;";
                selectID = connection.prepareStatement(hotel);
                selectID.setString(1, country);
                selectID.setString(2, state);
                resultID = selectID.executeQuery();
                while (resultID.next()) {
                    hotelid = resultID.getString("HOTELID");
                }

                String room = "SELECT ROOMNO, FLOOR, CAPACITY, RPRICE FROM ROOM, HOTEL "
                        + "WHERE COUNTRY=? AND STATE=? AND RTYPE=? AND HOTELID=ROOMHOTELID;";
                String disc = "SELECT DISCROOMNO, DISCOUNT, RTYPE, CAPACITY FROM ROOM, HOTEL, DISCOUNTED_ROOM WHERE COUNTRY=? AND STATE=? "
                        + " AND HOTELID=DISCROOMHOTELID AND ROOMNO=DISCROOMNO GROUP BY DISCROOMNO;";
                selectRoom = connection1.prepareStatement(room);
                selectDisc = connection2.prepareStatement(disc);
                selectRoom.setString(1, country);
                selectRoom.setString(2, state);
                selectRoom.setString(3, rtype);
                selectDisc.setString(1, country);
                selectDisc.setString(2, state);
                resultRoom = selectRoom.executeQuery();
                resultDisc = selectDisc.executeQuery();

                while (resultDisc.next()) {
                    discroomlist.add(resultDisc.getString("DISCROOMNO"));
                    discountlist.add(resultDisc.getString("DISCOUNT"));
                    discountrtype.add(resultDisc.getString("RTYPE"));
                    discountcap.add(resultDisc.getString("CAPACITY"));
                }

                discroomno = new String[discroomlist.size()];
                discroomno = discroomlist.toArray(discroomno);
                discount = new String[discountlist.size()];
                discount = discountlist.toArray(discount);
                discountroomtype = new String[discountrtype.size()];
                discountroomtype = discountrtype.toArray(discountroomtype);
                discountmaxcap = new String[discountcap.size()];
                discountmaxcap = discountcap.toArray(discountmaxcap);
        %>
        <h1><%=state%> room selections:</h1>
        <div id="centered">
            <table>            
                <tbody>
                    <tr>
                        <th>Room number:</th>
                        <th>Floor number</th>
                        <th>Capacity:</th>
                    </tr>
                <form action="offers.jsp">
                    <%
                        while (resultRoom.next()) {
                            String roomno = resultRoom.getString("ROOMNO");
                            String roomsub = roomno.substring(roomno.length() - 3);
                            String floor = resultRoom.getString("FLOOR");
                            String cap = resultRoom.getString("CAPACITY");
                            String rprice = resultRoom.getString("RPRICE");
                    %>
                    <tr>
                        <td><%=roomsub%></td>
                        <td><%=floor%></td>
                        <td><%=cap%></td>
                        <td>
                            <form action="offers.jsp">
                                <input  id="resbutton" type="submit" value="SELECT"/>
                                <input type="hidden" name="rnum" value="<%=roomno%>"/>
                                <input type="hidden" name="hotelid" value="<%=hotelid%>"/>
                                <input type="hidden" name="cap" value="<%=cap%>"/>
                                <input type="hidden" name="rprice" value="<%=rprice%>"/>
                                <input type="hidden" name="checkin" value="<%=checkin%>"/>
                                <input type="hidden" name="checkout" value="<%=checkout%>"/>
                            </form>
                        </td>
                    </tr>
                    <% }%>
                </form>                 
                </tbody>
            </table>
        </div><br />
        <div id="bottomtable">
            <table>  
                <% if (discroomno.length == 0) {
                %>
                <p1> No discounts available at this time. </p1>
                    <% } else { %>
                <tbody>
                <p2>   Discounts are available for the following rooms:   </p2>
                <tr>
                    <th>Room number:</th>
                    <th>Type of room:</th>
                    <th>Capacity:</th>
                    <th>Discounted price per night:</th>
                </tr>
                <form action="offers.jsp">
                    <%
                        for (int x = 0; x < discroomno.length; x++) {
                    %>
                    <tr>
                        <td><%=discroomno[x].substring(discroomno[x].length() - 3)%></td>
                        <td><%=discountroomtype[x]%></td>
                        <td><%=discountmaxcap[x]%></td>
                        <td><%=discount[x]%></td>                        
                        <td>
                            <form action="offers.jsp">
                                <input  id="resbutton" type="submit" value="SELECT"/>
                                <input type="hidden" name="rprice" value="<%=discount[x]%>"/>
                                <input type="hidden" name="rnum" value="<%=discroomno[x]%>"/>
                                <input type="hidden" name="cap" value="<%=discountmaxcap[x]%>"/>
                                <input type="hidden" name="hotelid" value="<%=hotelid%>"/>
                                <input type="hidden" name="checkin" value="<%=checkin%>"/>
                                <input type="hidden" name="checkout" value="<%=checkout%>"/>
                            </form>
                        </td>
                    </tr>
                    <% }
                        }%>
                </form> 
                <% } catch (SQLException e) {
                        out.println(e);
                    }%>
                </tbody>
            </table>
        </div><br />
    </body>
</html>
