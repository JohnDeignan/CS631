<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href='http://fonts.googleapis.com/css?family=Arizonia' rel='stylesheet' type='text/css'>
        <link href="https://fonts.googleapis.com/css?family=Josefin+Sans" rel="stylesheet">
        <title>Hulton Hotels</title>
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
    </head>
    <body>
        <%
            String email = request.getParameter("email");
            String[] rooms;
            String[] roomtype;
            String[] state;
            String[] country;
            String[] id;
            String[] btype;
            String[] bhotel;
            String[] stype;
            String[] shotel;
            String cid = "";

            ArrayList<String> roomlist = new ArrayList<String>();
            ArrayList<String> roomtypelist = new ArrayList<String>();
            ArrayList<String> statelist = new ArrayList<String>();
            ArrayList<String> countrylist = new ArrayList<String>();
            ArrayList<String> hotellist = new ArrayList<String>();
            ArrayList<String> btypelist = new ArrayList<String>();
            ArrayList<String> breakhotellist = new ArrayList<String>();
            ArrayList<String> stypelist = new ArrayList<String>();
            ArrayList<String> servhotellist = new ArrayList<String>();

            String URL = "jdbc:mysql://localhost:3306/hoteldb";
            String USER = "root";
            String PASS = "jdeignan1";

            try {
                Connection connection = null;
                PreparedStatement select = null;
                ResultSet resultSet = null;
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USER, PASS);
                String query = "SELECT CID FROM CUSTOMER WHERE EMAIL=?;";
                select = connection.prepareStatement(query);
                select.setString(1, email);
                resultSet = select.executeQuery();
                while (resultSet.next()) {
                    cid = resultSet.getString("CID");
                }
            } catch (SQLException e) {
                out.println(e);
            }

            try {
                Connection connection = null;
                PreparedStatement select = null;
                ResultSet resultSet = null;
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USER, PASS);
                String query1 = "SELECT RESROOMNO, RESHOTELID FROM ROOM_RESERVATION, RESERVATION, CUSTOMER WHERE "
                        + "EMAIL=? AND CID=RESCID AND ROOM_RESERVATION.INVOICENO=RESERVATION.INVOICENO;";
                select = connection.prepareStatement(query1);
                select.setString(1, email);
                resultSet = select.executeQuery();
                while (resultSet.next()) {
                    roomlist.add(resultSet.getString("RESROOMNO"));
                    hotellist.add(resultSet.getString("RESHOTELID"));
                }
                rooms = new String[roomlist.size()];
                rooms = roomlist.toArray(rooms);
                id = new String[hotellist.size()];
                id = hotellist.toArray(id);

                for (int i = 0; i < rooms.length; i++) {
                    try {
                        connection = null;
                        select = null;
                        resultSet = null;
                        Class.forName("com.mysql.jdbc.Driver");
                        connection = DriverManager.getConnection(URL, USER, PASS);
                        String query2 = "SELECT RTYPE, COUNTRY, STATE FROM ROOM, HOTEL WHERE ROOMNO=? AND ROOMHOTELID=HOTELID";
                        select = connection.prepareStatement(query2);
                        select.setString(1, rooms[i]);
                        resultSet = select.executeQuery();
                        while (resultSet.next()) {
                            countrylist.add(resultSet.getString("COUNTRY"));
                            statelist.add(resultSet.getString("STATE"));
                            roomtypelist.add(resultSet.getString("RTYPE"));
                        }
                    } catch (SQLException e) {
                        out.println(e);
                    }
                }
                roomtype = new String[roomtypelist.size()];
                roomtype = roomtypelist.toArray(roomtype);
                state = new String[statelist.size()];
                state = statelist.toArray(state);
                country = new String[countrylist.size()];
                country = countrylist.toArray(country);

        %>
        <h1>Hulton</h1>
    </body>
    <div id="centered">
        <table>
            <tbody>
                <% for (int i = 0; i < rooms.length; i++) {
                        String together = state[i] + " , " + country[i];
                        String roomnum = rooms[i].substring(rooms[i].length() - 3);
%>
                <tr>
                    <td><%=together%></td>
                    <td><%=roomnum%></td>
                    <td><%=roomtype[i]%></td>
                    <td>
                        <form action="writerev.jsp">
                            <input  id="resbutton" type="submit" value="REVIEW"/>
                            <input type="hidden" name="roomno" value="<%=rooms[i]%>"/>
                            <input type="hidden" name="id" value="<%=id[i]%>"/>
                            <input type="hidden" name="cid" value="<%=cid%>"/>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <%
            try {
                connection = null;
                select = null;
                resultSet = null;
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USER, PASS);
                String query3 = "SELECT RESSHOTELID, RESSTYPE FROM RRESV_SERVICE, ROOM_RESERVATION, RESERVATION WHERE"
                        + " RESCID=? AND ROOM_RESERVATION.INVOICENO=RESERVATION.INVOICENO AND RESROOMNO=RESSROOMNO AND"
                        + " CHECKINDATE=RESSCHECKINDATE";
                select = connection.prepareStatement(query3);
                select.setString(1, cid);
                resultSet = select.executeQuery();
                while (resultSet.next()) {
                    servhotellist.add(resultSet.getString("RESSHOTELID"));
                    stypelist.add(resultSet.getString("RESSTYPE"));
                }
                stype = new String[stypelist.size()];
                stype = stypelist.toArray(stype);
                shotel = new String[servhotellist.size()];
                shotel = servhotellist.toArray(shotel);
        %>
        <table>
            <tbody>
                <% for (int i = 0; i < stype.length; i++) {
                        String onlyserve = stype[i].substring(0, stype[i].length() - 7);
                %>
                <tr>
                    <td><%=onlyserve%></td>
                    <td>
                        <form action="writerev.jsp">
                            <input  id="resbutton" type="submit" value="REVIEW"/>
                            <input type="hidden" name="stype" value="<%=stype[i]%>"/>
                            <input type="hidden" name="id" value="<%=shotel[i]%>"/>
                            <input type="hidden" name="cid" value="<%=cid%>"/>
                        </form>
                    </td>
                </tr>
                <% }
                    } catch (SQLException e) {
                        out.println(e);
                    }%>
            </tbody>
        </table>
        <%
            try {
                connection = null;
                select = null;
                resultSet = null;
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USER, PASS);
                String query4 = "SELECT RESBHOTELID, RESBTYPE FROM RRESV_BREAKFAST, ROOM_RESERVATION, RESERVATION WHERE"
                        + " RESCID=? AND ROOM_RESERVATION.INVOICENO=RESERVATION.INVOICENO AND RESROOMNO=RESBROOMNO AND"
                        + " CHECKINDATE=RESBCHECKINDATE";
                select = connection.prepareStatement(query4);
                select.setString(1, cid);
                resultSet = select.executeQuery();
                while (resultSet.next()) {
                    breakhotellist.add(resultSet.getString("RESBHOTELID"));
                    btypelist.add(resultSet.getString("RESBTYPE"));
                }
                btype = new String[btypelist.size()];
                btype = btypelist.toArray(btype);
                bhotel = new String[breakhotellist.size()];
                bhotel = breakhotellist.toArray(bhotel);
        %>
        <table>
            <tbody>
                <% for (int i = 0; i < btype.length; i++) {
                        String[] breakfast = btype[i].split("-");
                        String onlybreak = breakfast[0];
                %>
                <tr>
                    <td><%=onlybreak%> Breakfast</td>
                    <td>
                        <form action="writerev.jsp">
                            <input  id="resbutton" type="submit" value="REVIEW"/>
                            <input type="hidden" name="btype" value="<%=onlybreak%>"/>
                            <input type="hidden" name="id" value="<%=bhotel[i]%>"/>
                            <input type="hidden" name="cid" value="<%=cid%>"/>
                        </form>
                    </td>
                </tr>
                <% }
                        } catch (SQLException e) {
                            out.println(e);
                        }
                    } catch (SQLException e) {
                        out.println(e);
                    }%>
            </tbody>
        </table>
    </div>
</html>
