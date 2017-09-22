<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page language = "java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="finalStyle.css">
        <link href='http://fonts.googleapis.com/css?family=Arizonia' rel='stylesheet' type='text/css'>
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
                background-repeat: no-repeat;
            }
            .pair  {
                border-radius: 10px 6px 6px 6px;
                background-color: rgba(7, 10, 33, .7);
                border-color: #ffffff;
                color: #ffffff;       
            }
            p1 {
                font-size: 140%;
                border-left: 6px solid white;
                border-right: 6px solid white;
                background-color: rgba(7, 10, 33, .9);
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

            h1 {
                text-align: center;
                font: 400 70px/1 'Arizonia', Helvetica, sans-serif;
                color: #ffffff;
                text-shadow: 4px 4px 0px rgba(0,0,0,0.1);
            }

            #centered {
                position: fixed;
                top: 30%;
                left: 50%;
                transform: translate(-50%, -50%);
            }

            body {
                background-image: url("http://findmombasahotels.com/wp-content/uploads/2013/05/Night2.jpg");
                background-repeat: no-repeat;
                font-family: 'Josefin Sans', sans-serif;
                color: #ffffff;
            }
        </style>        
    </head>
    <body>   
        <h1>Hulton</h1>
        <%
            String[] noOfBreakOrders = request.getParameterValues("numOrders");
            String[] btype = request.getParameterValues("bType");
            String[] bprice = request.getParameterValues("bPrice");
            String room = request.getParameter("room");
            String price = request.getParameter("price");
            String id = request.getParameter("id");
            String checkin = request.getParameter("checkin");
            String checkout = request.getParameter("checkout");
            String days = request.getParameter("days");
            String maxbreaks = request.getParameter("total");
            String[] stype;
            float totalPrice = 0;
            float servprice = 0;
            float totalbreakprice = 0;
            float roomprice = Float.parseFloat(price);
            int maxb = Integer.parseInt(maxbreaks);
            int tempb = 0;

            for (int i = 0; i < noOfBreakOrders.length; i++) {
                tempb += Integer.parseInt(noOfBreakOrders[i]);
            }

            if (tempb > maxb) {
                String url = request.getHeader("Referer");
                response.sendRedirect(url);
                return;
            }

            float numdays = Float.parseFloat(days);
            totalPrice += (roomprice * numdays);

            ArrayList<String> spricelist = new ArrayList<String>();

            String URL = "jdbc:mysql://localhost:3306/hoteldb";
            String USER = "root";
            String PASS = "jdeignan1";

            Connection connection = null;
            PreparedStatement select = null;
            ResultSet resultSet = null;

            if (request.getParameterValues("sType") != null) {
                try {
                    stype = request.getParameterValues("sType");
                    String[] sprice = new String[stype.length];
                    Class.forName("com.mysql.jdbc.Driver");
                    connection = DriverManager.getConnection(URL, USER, PASS);
                    for (int i = 0; i < stype.length; i++) {
                        String query = "SELECT SPRICE FROM SERVICE WHERE SERVHOTELID=? AND STYPE=?;";
                        select = connection.prepareStatement(query);
                        select.setString(1, id);
                        select.setString(2, stype[i]);
                        resultSet = select.executeQuery();
                        while (resultSet.next()) {
                            spricelist.add(resultSet.getString("SPRICE"));
                        }
                    }
                    sprice = new String[spricelist.size()];
                    sprice = spricelist.toArray(sprice);
                    for (int i = 0; i < sprice.length; i++) {
                        servprice = Float.parseFloat(sprice[i]);
                        totalPrice += servprice;
                    }

                } catch (SQLException e) {
                    out.println(e);
                }
            }

            for (int i = 0; i < btype.length; i++) {
                if (noOfBreakOrders[i] != "0") {
                    float orders = Float.parseFloat(noOfBreakOrders[i]);
                    float breakprice = Float.parseFloat(bprice[i]);
                    totalPrice += breakprice * orders;
                }
            }
        %>
        <div  id="centered" style="width: 420px; height: 200px; font-size:18px">
            <form action="insertRes.jsp" >
                <div class = "pair"><br/>
                    <div style="height: 2em;">
                        <input id="name" name="email" type="text" style="float: right; width: 200px;">
                        <span style="float: left;">Email:</span>
                    </div><br/>
                    <span style="float: left;">Credit Card Type:</span>
                    <div style="height: 2em; float: right; width: 200px;">                  
                        <select name="ctype">                            
                            <option value="visa">Visa</option>
                            <option value="mastercard">MasterCard</option>
                            <option value="discovery">Discovery</option>
                            <option value="americanexpress">American Express</option>
                            <option value="capitalone">Capital One</option>                        
                        </select>                          
                    </div><br/><br/>
                    <br/><span style="float: left;">Credit Card Number:</span>
                    <div style="height: 2em;">
                        <input id="ccn" name="ccnum" type="text" style="float: right; width: 200px;">                        
                    </div><br/>
                    <div style="height: 2em;">
                        <input id="sc" name="sc" type="text" style="float: right; width: 200px;">
                        <span style="float: left;">Security Code:</span>
                    </div><br/>
                    <div style="height: 2em;">
                        <input id="ccn" name="ccname" type="text" style="float: right; width: 200px;">
                        <span style="float: left;">Name on Card:</span>
                    </div><br/>
                    <div style="height: 2em;">
                        <input id="expdate" name="expdate" type="text" style="float: right; width: 200px;">
                        <span style="float: left;">Expiration Date (YYYY/MM):</span>
                    </div><br/>                    
                </div><br/><br/>
                <p1><strong> Total Price: $<%=totalPrice%> </strong></p1><br/>
                <br/><input id="gobutton" name="send" type="submit" value="GO"/>
                <input type="hidden" name="price" value="<%=price%>"/>
                <input type="hidden" name="room" value="<%=room%>"/>
                <input type="hidden" name="id" value="<%=id%>"/>
                <input type="hidden" name="checkin" value="<%=checkin%>"/>    
                <input type="hidden" name="checkout" value="<%=checkout%>"/> 
                <% for (int i = 0; i < btype.length; i++) {%>
                <input type="hidden" name="btype" value="<%=btype[i]%>"/> 
                <% } %>
                <% for (int i = 0; i < noOfBreakOrders.length; i++) {%>
                <input type="hidden" name="numorders" value="<%=noOfBreakOrders[i]%>"/> 
                <% } %>
                <% if (request.getParameterValues("sType") != null) {
                        stype = request.getParameterValues("sType");
                        for (int i = 0; i < stype.length; i++) {%>
                <input type="hidden" name="stype" value="<%=stype[i]%>"/> 
                <% }
                    }%>
            </form>            
        </div>
    </body>
</html>
