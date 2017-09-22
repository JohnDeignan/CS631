<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hulton Hotels</title>
    </head>
    <body>
        <%
            String rating = request.getParameter("rating");
            String text = request.getParameter("textarea");
            String cid = request.getParameter("cid");
            String hotelid = request.getParameter("id");
            String temprid = "";
            String rid = "";

            String URL = "jdbc:mysql://localhost:3306/hoteldb";
            String USER = "root";
            String PASS = "jdeignan1";

            String roomno = request.getParameter("roomnum");
            String btype = request.getParameter("btype");
            String stype = request.getParameter("stype");

            if (roomno != null) {
                try {
                    Connection connection = null;
                    PreparedStatement select = null;
                    ResultSet resultSet = null;

                    Class.forName("com.mysql.jdbc.Driver");
                    connection = DriverManager.getConnection(URL, USER, PASS);
                    String query = "SELECT MAX(RREVRID) FROM ROOM_REVIEW";
                    select = connection.prepareStatement(query);
                    resultSet = select.executeQuery();
                    while (resultSet.next()) {
                        temprid = resultSet.getString("MAX(RREVRID)");
                    }
                    int intrid = Integer.parseInt(temprid);
                    intrid++;
                    rid = String.format("%010d", intrid);

                } catch (SQLException e) {
                    out.println(e);
                }
                try {
                    Connection connection = null;
                    Class.forName("com.mysql.jdbc.Driver");
                    connection = DriverManager.getConnection(URL, USER, PASS);

                    String query = "INSERT INTO ROOM_REVIEW (RREVRID, RREVRATING, RREVTEXT, RREVCID, RREVHOTELID"
                            + ", RREVROOMNO) VALUES ('" + rid + "','" + rating + "', ?,'" + cid + "','"
                            + hotelid + "','" + roomno + "');";
                    PreparedStatement st = connection.prepareStatement(query);
                    st.setString(1, text);
                    st.executeUpdate();
                } catch (SQLException e) {
                    out.println(e);
                }
            }
            if (btype != null) {
                try {
                    Connection connection = null;
                    PreparedStatement select = null;
                    ResultSet resultSet = null;

                    Class.forName("com.mysql.jdbc.Driver");
                    connection = DriverManager.getConnection(URL, USER, PASS);
                    String query = "SELECT MAX(BREVRID) FROM BREAKFAST_REVIEW";
                    select = connection.prepareStatement(query);
                    resultSet = select.executeQuery();
                    while (resultSet.next()) {
                        temprid = resultSet.getString("MAX(BREVRID)");
                    }
                    int intrid = Integer.parseInt(temprid);
                    intrid++;
                    rid = String.format("%010d", intrid);

                } catch (SQLException e) {
                    out.println(e);
                }
                try {
                    Connection connection = null;
                    Class.forName("com.mysql.jdbc.Driver");
                    connection = DriverManager.getConnection(URL, USER, PASS);
                    String btypefull = btype + "-" + hotelid;

                    String query = "INSERT INTO BREAKFAST_REVIEW (BREVRID, BREVRATING, BREVTEXT, BREVCID, BREVHOTELID"
                            + ", BREVTYPE) VALUES ('" + rid + "','" + rating + "', ?,'" + cid + "','"
                            + hotelid + "','" + btypefull + "');";
                    PreparedStatement st = connection.prepareStatement(query);
                    st.setString(1, text);
                    st.executeUpdate();
                } catch (SQLException e) {
                    out.println(e);
                }
            }
            if (stype != null) {
                try {
                    Connection connection = null;
                    PreparedStatement select = null;
                    ResultSet resultSet = null;

                    Class.forName("com.mysql.jdbc.Driver");
                    connection = DriverManager.getConnection(URL, USER, PASS);
                    String query = "SELECT MAX(SREVRID) FROM SERVICE_REVIEW";
                    select = connection.prepareStatement(query);
                    resultSet = select.executeQuery();
                    while (resultSet.next()) {
                        temprid = resultSet.getString("MAX(SREVRID)");
                    }
                    int intrid = Integer.parseInt(temprid);
                    intrid++;
                    rid = String.format("%010d", intrid);

                } catch (SQLException e) {
                    out.println(e);
                }
                try {
                    Connection connection = null;
                    Class.forName("com.mysql.jdbc.Driver");
                    connection = DriverManager.getConnection(URL, USER, PASS);

                    String query = "INSERT INTO SERVICE_REVIEW (SREVRID, SREVRATING, SREVTEXT, SREVCID, SREVHOTELID"
                            + ", SREVTYPE) VALUES ('" + rid + "','" + rating + "', ?,'" + cid + "','"
                            + hotelid + "','" + stype + "');";
                    PreparedStatement st = connection.prepareStatement(query);
                    st.setString(1, text);
                    st.executeUpdate();
                } catch (SQLException e) {
                    out.println(e);
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
