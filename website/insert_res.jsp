<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.*"%>
<%@page language = "java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <%
            String URL = "jdbc:mysql://localhost:3306/hoteldb";
            String USER = "root";
            String PASS = "jdeignan1";

            String cid = "";
            String address = "";
            String invoice = "";
            String invoiceno = "";
            String cnum = request.getParameter("ccnum");
            String rcnum = "";
            int inv = 0;

            try {
                Connection connection = null;
                PreparedStatement select = null;
                ResultSet resultSet = null;

                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USER, PASS);
                String query = "SELECT MAX(INVOICENO) FROM RESERVATION";
                select = connection.prepareStatement(query);
                resultSet = select.executeQuery();
                while (resultSet.next()) {
                    invoiceno = resultSet.getString("MAX(INVOICENO)");
                }
                inv = Integer.parseInt(invoiceno);
                inv++;
                invoice = String.format("%010d", inv);
            } catch (SQLException e) {
                out.println(e);
            }
            
            try {
                Connection connection = null;
                PreparedStatement select = null;
                ResultSet resultSet = null;
                String email = request.getParameter("email").toUpperCase().trim();

                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USER, PASS);
                String query = "SELECT CID, CUSTADDRESS FROM CUSTOMER WHERE EMAIL=?";
                select = connection.prepareStatement(query);
                select.setString(1, email);
                resultSet = select.executeQuery();
                while (resultSet.next()) {
                    cid = resultSet.getString("CID");
                    address = resultSet.getString("CUSTADDRESS");
                }

            } catch (SQLException e) {
                out.println(e);
            }

            try {
                Connection connection = null;
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USER, PASS);
                Statement customer;
                customer = connection.createStatement();

                String cnumber = request.getParameter("ccnum").trim();
                String ctype = request.getParameter("ctype").trim().toUpperCase();
                String seccode = request.getParameter("sc").trim();
                String expdate = request.getParameter("expdate").trim();
                String name = request.getParameter("ccname").trim().toUpperCase();

                String query = "INSERT INTO CREDIT_CARD (CNUMBER, CTYPE, CARDADDRESS, CCODE, EXPDATE, CARDNAME) "
                        + "VALUES ('" + cnumber + "','" + ctype + "','" + address + "','" + seccode + "','"
                        + expdate + "','" + name + "');";
                customer.executeUpdate(query);

            } catch (SQLException e) {
                out.println(e);
            }

            try {
                Connection connection = null;
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USER, PASS);
                Statement customer;
                customer = connection.createStatement();

                java.sql.Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
                String ccnum = request.getParameter("ccnum");

                String query = "INSERT INTO RESERVATION (INVOICENO, RESCID, RESCNUMBER, RESDATEMADE) "
                        + "VALUES ('" + invoice + "','" + cid + "','" + cnum + "', NOW());";
                customer.executeUpdate(query);

            } catch (SQLException e) {
                out.println(e);
            }

            try {
                Connection connection = null;
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USER, PASS);
                Statement customer;
                customer = connection.createStatement();

                String hotelid = request.getParameter("id").trim();
                String roomno = request.getParameter("room").trim();
                String checkin = request.getParameter("checkin");
                String checkout = request.getParameter("checkout");
                checkin = checkin + "-" + roomno;
                checkout = checkout + "-" + roomno;

                String query = "INSERT INTO ROOM_RESERVATION (INVOICENO, RESHOTELID, RESROOMNO, CHECKINDATE, CHECKOUTDATE) "
                        + "VALUES ('" + invoice + "','" + hotelid + "','" + roomno + "','" + checkin + "','" + checkout + "');";
                customer.executeUpdate(query);

            } catch (SQLException e) {
                out.println(e);
            }

            String[] btype = request.getParameterValues("btype");
            String[] numorders = request.getParameterValues("numorders");
            String id = request.getParameter("id");
            String roomno = request.getParameter("room");
            String checkin = request.getParameter("checkin");
            checkin = checkin + "-" + roomno;

            for (int i = 0; i < numorders.length; i++) {
                int order = Integer.parseInt(numorders[i]);
                if (order != 0) {
                    try {
                        Connection connection = null;
                        Class.forName("com.mysql.jdbc.Driver");
                        connection = DriverManager.getConnection(URL, USER, PASS);
                        Statement customer;
                        customer = connection.createStatement();

                        String query = "INSERT INTO RRESV_BREAKFAST (RESBTYPE, RESBHOTELID, RESBROOMNO, RESBCHECKINDATE, NOOFORDERS) "
                                + "VALUES ('" + btype[i] + "','" + id + "','" + roomno + "','" + checkin + "','" + numorders[i] + "');";
                        customer.executeUpdate(query);

                    } catch (SQLException e) {
                        out.println(e);
                    }
                }
            }
            
            if (request.getParameterValues("stype") != null) {
                String[] stype = request.getParameterValues("stype");
                for (int i = 0; i < stype.length; i++) {
                    try {
                        Connection connection = null;
                        Class.forName("com.mysql.jdbc.Driver");
                        connection = DriverManager.getConnection(URL, USER, PASS);
                        Statement customer;
                        customer = connection.createStatement();

                        String query = "INSERT INTO RRESV_SERVICE (RESSTYPE, RESSHOTELID, RESSROOMNO, RESSCHECKINDATE) "
                                + "VALUES ('" + stype[i] + "','" + id + "','" + roomno + "','" + checkin + "');";
                        customer.executeUpdate(query);

                    } catch (SQLException e) {
                        out.println(e);
                    }

                }
            }

            boolean condition = true;
            if (condition) {
                response.sendRedirect("done.jsp");
                return;
            }
        %>
    </body>
</html>
