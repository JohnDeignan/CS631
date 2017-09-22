<%@page import="java.sql.*"%>
<%@page language = "java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <%
            String URL = "jdbc:mysql://localhost:3306/hoteldb";
            String USER = "root";
            String PASS = "jdeignan1";
            String initcid = "";   

            try {
                Connection connection = null;
                PreparedStatement select = null;
                ResultSet resultSet = null;

                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USER, PASS);
                String query = "SELECT MAX(CID) FROM CUSTOMER";
                select = connection.prepareStatement(query);
                resultSet = select.executeQuery();
                while (resultSet.next()) {
                    initcid = resultSet.getString("MAX(CID)");
                }

            } catch (SQLException e) {
                out.println(e);
            }
            
            int initialcid = Integer.parseInt(initcid);
            initialcid++;
            String cid = String.format("%08d", initialcid);

            try {
                Connection connection = null;
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USER, PASS);
                Statement customer;
                customer = connection.createStatement();

                String name = request.getParameter("name").toUpperCase();
                String email = request.getParameter("email").toUpperCase();
                String street = request.getParameter("street");
                String city = request.getParameter("city");
                String state = request.getParameter("state");
                String country = request.getParameter("country");
                String zip = request.getParameter("zip");
                String phonenum = request.getParameter("phonenum");
                String address = street.toUpperCase() + ", " + city.toUpperCase() + ", " + state.toUpperCase() + ", " + zip.toUpperCase() + ", " + country.toUpperCase();
                
                String query = "INSERT INTO CUSTOMER (CID, CUSTNAME, CUSTADDRESS, PHONENUM, EMAIL) "
                        + "VALUES ('" + cid + "','" + name + "','" + address + "','"
                        + phonenum + "','" + email + "');";
                customer.executeUpdate(query);

            } catch (SQLException e) {
                out.println(e);
            }

            boolean condition = true;
            if (condition) {
                response.sendRedirect("index.jsp");
                return;
            }
        %>
    </body>
</html>
