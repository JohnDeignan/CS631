<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href='http://fonts.googleapis.com/css?family=Arizonia' rel='stylesheet' type='text/css'>
        <link href="https://fonts.googleapis.com/css?family=Josefin+Sans" rel="stylesheet">
        <link rel="stylesheet" href="jquery.rating.css">
        <script src="jquery.js"></script>
        <script src="jquery.rating.js"></script>        
        <title>Hulton Hotels</title>
        <style>
            input[type=submit] {
                color: #ffffff;
                background: rgba(0,0,0,0);
                border: solid 3px #ffffff;
                font-size: 100%;
                width: 60px;
                height: 40px;
                font-family: 'Josefin Sans', sans-serif;
                border-radius:25px;
            }
            textarea#styled {
                width: 800px;
                height: 240px;
                border: 3px solid #cccccc;
                padding: 5px;
                font-family: Tahoma, sans-serif;
                background-image: url(bg.gif);
                background-position: bottom right;
                background-repeat: no-repeat;
            }
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
            #centered {
                position: fixed;
                top: 40%;
                left: 50%;
                transform: translate(-50%, -50%);
            }
            p1 {
                border-radius: 6px 6px 6px 6px;
                background-color: rgba(7, 10, 33, 0.6);
                border-color: #ffffff;
                color: #ffffff;
            }
            p2 {
                border-radius: 6px 6px 6px 6px;
                background-color: rgba(7, 10, 33, 0.6);
                border-color: #ffffff;
                color: #ffffff;
            }
        </style>
    </head>
    <body>
        <h1>Hulton</h1>
        <%
            String roomnum = request.getParameter("roomno");
            String cid = request.getParameter("cid");
            String id = request.getParameter("id");

            if (roomnum != null) {
                
        %>
        <div id="centered">
            <p1>Share your thoughts on this room:</p1> <br/>            
            <form action="insertRev.jsp">
                <textarea name="textarea" id="styled" onfocus="this.value = ''; setbg('#e5fff3');" onblur="setbg('white')">Enter your comment here...</textarea><br/>
                <br/><p2>Submit your review by pressing the button you would rate this room on a scale from 1 to 10:</p2><br/>
                <br/><input type="submit" value="1" name="rating"/>
                <input type="submit" value="2" name="rating"/>
                <input type="submit" value="3" name="rating"/>
                <input type="submit" value="4" name="rating"/>
                <input type="submit" value="5" name="rating"/>
                <input type="submit" value="6" name="rating"/>
                <input type="submit" value="7" name="rating"/>
                <input type="submit" value="8" name="rating"/>
                <input type="submit" value="9" name="rating"/>
                <input type="submit" value="10" name="rating"/>
                <input type="hidden" name="cid" value="<%=cid%>"/>
                <input type="hidden" name="id" value="<%=id%>"/>
                <input type="hidden" name="roomnum" value="<%=roomnum%>"/>
            </form>
        </div>
        <%            }
            if (request.getParameter("btype") != null) {
                String reviewtype = request.getParameter("btype");
                String btype = reviewtype;
        %>
        <div id="centered">
            <p>Share your thoughts on our <%=reviewtype%> breakfast:</p> <br/>
            <form action="insertRev.jsp">
                <textarea name="textarea" id="styled" onfocus="this.value = ''; setbg('#e5fff3');" onblur="setbg('white')">Enter your comment here...</textarea><br/>
                <br/><p2>Submit your review by pressing the button you would rate this room on a scale from 1 to 10:</p2><br/>
                <br/><input type="submit" value="1" name="rating"/>
                <input type="submit" value="2" name="rating"/>
                <input type="submit" value="3" name="rating"/>
                <input type="submit" value="4" name="rating"/>
                <input type="submit" value="5" name="rating"/>
                <input type="submit" value="6" name="rating"/>
                <input type="submit" value="7" name="rating"/>
                <input type="submit" value="8" name="rating"/>
                <input type="submit" value="9" name="rating"/>
                <input type="submit" value="10" name="rating"/>
                <input type="hidden" name="cid" value="<%=cid%>"/>
                <input type="hidden" name="id" value="<%=id%>"/>
                <input type="hidden" name="btype" value="<%=btype%>"/>
            </form>
        </div>
        <%
            }
            if (request.getParameter("stype") != null) {
                String reviewtype = request.getParameter("stype");
                String stype = reviewtype;
        %>
        <div id="centered">
            <p>Share your thoughts on our <%=reviewtype.substring(0, reviewtype.length() - 7)%> service:</p> <br/>
            <form action="insertRev.jsp">
                <textarea name="textarea" id="styled" onfocus="this.value = ''; setbg('#e5fff3');" onblur="setbg('white')">Enter your comment here...</textarea><br/>
                <br/><p2>Submit your review by pressing the button you would rate this room on a scale from 1 to 10:</p2><br/>
                <br/><input type="submit" value="1" name="rating"/>
                <input type="submit" value="2" name="rating"/>
                <input type="submit" value="3" name="rating"/>
                <input type="submit" value="4" name="rating"/>
                <input type="submit" value="5" name="rating"/>
                <input type="submit" value="6" name="rating"/>
                <input type="submit" value="7" name="rating"/>
                <input type="submit" value="8" name="rating"/>
                <input type="submit" value="9" name="rating"/>
                <input type="submit" value="10" name="rating"/>
                <input type="hidden" name="cid" value="<%=cid%>"/>
                <input type="hidden" name="id" value="<%=id%>"/>
                <input type="hidden" name="stype" value="<%=stype%>"/>
            </form>
        </div>
        <%
            }
        %>
    </body>
</html>
