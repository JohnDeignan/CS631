<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Date" import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager" import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement" import="java.sql.Connection"%>
<%@page import="java.io.*" import="java.lang.*"%>
<%@page import="java.text.DateFormat" import="java.text.SimpleDateFormat" import="java.util.Calendar"%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="offersStyle.css">
        <link href='http://fonts.googleapis.com/css?family=Arizonia' rel='stylesheet' type='text/css'>
        <link href='//fonts.googleapis.com/css?family=Caveat' rel='stylesheet'>
        <link href="https://fonts.googleapis.com/css?family=Josefin+Sans" rel="stylesheet">
        <title>Hulton Hotels</title>
        <style>
            input[type=text] {
                width: 300px;
                box-sizing: border-box;
                border: 2px solid #ccc;
                border-radius: 4px;
                font-size: 12px;
                background-color: white;
                background-position: 10px 10px; 
                background-repeat: no-repeat;
                padding: 4px 20px 4px 60px;
            }
            .pair  {
                border-radius: 10px 6px 6px 6px;
                background-color: rgba(7, 10, 33, .7);
                border-color: #ffffff;
                color: #ffffff;       
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

            #centered {
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
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
        </style>
    </head>
    <body>    
        <%
            String price = request.getParameter("rprice");
            String room = request.getParameter("rnum");
            String id = request.getParameter("hotelid");
            String maxcap = request.getParameter("cap");
            String checkin = request.getParameter("checkin");
            String checkout = request.getParameter("checkout");
            String subcheckin = checkin;
            String subcheckout = checkout;

            String checkinyear = checkin.substring(0, 4);
            int yearin = Integer.parseInt(checkinyear);
            String checkinmonth = checkin.substring(5, 7);
            int monthin = Integer.parseInt(checkinmonth);
            String checkinday = checkin.substring(8, 10);
            int dayin = Integer.parseInt(checkinday);

            String checkoutyear = checkout.substring(0, 4);
            int yearout = Integer.parseInt(checkoutyear);
            String checkoutmonth = checkout.substring(5, 7);
            int monthout = Integer.parseInt(checkoutmonth);
            String checkoutday = checkout.substring(8, 10);
            int dayout = Integer.parseInt(checkoutday);

            Calendar cal1 = new GregorianCalendar();
            Calendar cal2 = new GregorianCalendar();

            cal1.set(yearin, monthin, dayin);
            cal2.set(yearout, monthout, dayout);

            int totalDays = (int) ((cal2.getTime().getTime() - cal1.getTime().getTime()) / (1000 * 60 * 60 * 24));
            int cap = Integer.parseInt(maxcap);
            int total = totalDays * cap;
            String maxbreak = String.valueOf(total);
            String days = String.valueOf(totalDays);

            String URL = "jdbc:mysql://localhost:3306/hoteldb";
            String USER = "root";
            String PASS = "jdeignan1";

            Connection connection = null;
            Connection connection1 = null;
            PreparedStatement selectBreakfast = null;
            PreparedStatement selectService = null;
            ResultSet resultBreakfast = null;
            ResultSet resultService = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USER, PASS);
                connection1 = DriverManager.getConnection(URL, USER, PASS);
                String breakfast = "SELECT BTYPE, BDESCRIPTION, BPRICE FROM BREAKFAST, HOTEL WHERE BREAKHOTELID=? GROUP BY BTYPE";
                String service = "SELECT STYPE, SPRICE FROM SERVICE, HOTEL WHERE SERVHOTELID=? GROUP BY STYPE;";
                selectBreakfast = connection.prepareStatement(breakfast);
                selectService = connection1.prepareStatement(service);
                selectBreakfast.setString(1, id);
                selectService.setString(1, id);
                resultBreakfast = selectBreakfast.executeQuery();
                resultService = selectService.executeQuery();

        %>
        <div id="centered">
            <p> Select Desired Offers: </p>
            <form action="finalize.jsp"><table>            
                    <tbody>
                        <tr>
                            <th>Breakfast type:</th>
                            <th>Description:</th>
                            <th>Price:</th>
                        </tr>
                        <% while (resultBreakfast.next()) {
                                int i = 0;
                                String bType = resultBreakfast.getString("BTYPE");
                                String btshort = bType.substring(0, bType.length() - 7);
                                String bDesc = resultBreakfast.getString("BDESCRIPTION");
                                String bPrice = resultBreakfast.getString("BPRICE");
                        %>
                        <tr>
                            <td><%=btshort%></td>
                            <td><%=bDesc%></td>
                            <td><%=bPrice%> per order</td>              
                            <td>
                                <select name="numOrders">
                                    <% while (i < total) {
                                    %>
                                    <option value="<%=i%>"><%=i%></option>
                                    <% i++;
                                        }
                                    %>
                                </select>
                                <input type="hidden" name="bType" value="<%=bType%>"/>
                                <input type="hidden" name="bPrice" value="<%=bPrice%>"/>
                            </td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
                <p style="text-align: center; font-size: 12px;  border-radius: 10px 6px 6px 6px; background-color: rgb(7, 10, 33); border-color: #ffffff; color: #ffffff;">
                    Number of breakfast orders cannot exceed: <%=total%> total***</p>
                <table>            
                    <tbody>
                        <tr>
                            <th>Service type:</th>
                            <th>Price:</th>
                        </tr>
                        <% while (resultService.next()) {
                                int i = 0;

                                String sType = resultService.getString("STYPE");
                                String sPrice = resultService.getString("SPRICE");
                                String stshort = sType.substring(0, sType.length() - 7);
                        %>
                        <tr>
                            <td><%=stshort%></td>
                            <td><%=sPrice%></td>              
                            <td>
                                <input type="checkbox" name="sType" value="<%=sType%>"/>
                            </td>
                        </tr>
                        <% }%>
                    </tbody>                    
                </table> <br/><br/>   
                <form action="finalize.jsp">
                    <input id="gobutton" type="submit" value="GO"/>
                    <input type="hidden" name="price" value="<%=price%>"/>
                    <input type="hidden" name="room" value="<%=room%>"/>
                    <input type="hidden" name="id" value="<%=id%>"/>
                    <input type="hidden" name="checkin" value="<%=subcheckin%>"/>    
                    <input type="hidden" name="checkout" value="<%=subcheckout%>"/> 
                    <input type="hidden" name="days" value="<%=days%>"/> 
                    <input type="hidden" name="total" value="<%=maxbreak%>"/> 
                </form>
            </form>
            <%
                } catch (SQLException e) {
                    out.println(e);
                }%>
        </div>
    </body>
</html>
