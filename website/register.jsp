<%@page import="java.sql.*"%>
<%@page language = "java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="style.css">
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
                background-repeat: no-repeat;
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
                text-align: right;
            }

            h1 {
                text-align: center;
                font: 400 70px/1 'Arizonia', Helvetica, sans-serif;
                color: #ffffff;
                text-shadow: 4px 4px 0px rgba(0,0,0,0.1);
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

            #centered {
                position: fixed;
                top: 30%;
                left: 50%;
                transform: translate(-50%, -50%);
            }
        </style>        
    </head>
    <body>   
        <h1>Hulton</h1>
        <div  id="centered" style="width: 340px; height: 200px; padding: 20px; font-size:18px">
            <form action="insertCust.jsp" name="testform">
                <div class = "pair"><br/>
                    <div style="height: 2em;">
                        <input id="name" name="name" type="text" style="float: right; width: 200px;">
                        <span style="float: left;">Name</span>
                    </div><br/>
                    <div style="height: 2em;">
                        <input id="email" name="email" type="text" style="float: right; width: 200px;">
                        <span style="float: left;">Email:</span>
                    </div><br/>
                    <div style="height: 2em;">
                        <input id="street" name="street" type="text" style="float: right; width: 200px;">
                        <span style="float: left;">Street Address:</span>
                    </div><br/>
                    <div style="height: 2em;">
                        <input id="city" name="city" type="text" style="float: right; width: 200px;">
                        <span style="float: left;">City:</span>
                    </div><br/>
                    <div style="height: 2em;">
                        <input id="state" name="state" type="text" style="float: right; width: 200px;">
                        <span style="float: left;">State:</span>
                    </div><br/>
                    <div style="height: 2em;">
                        <input id="zip" name="zip" type="text" style="float: right; width: 200px;">
                        <span style="float: left;">Zip:</span>
                    </div><br/>
                    <div style="height: 2em;">
                        <input id="country" name="country" type="text" style="float: right; width: 200px;">
                        <span style="float: left;">Country:</span>
                    </div><br/>                    
                    <div style="height: 2em;">
                        <input id="phonenum" name="phonenum" type="text" style="float: right; width: 200px;">
                        <span style="float: left;">Phone Number:</span>
                    </div>
                </div><br/><br/>
                <input id="gobutton" name="send" type="submit" value="GO"/>              
            </form>            
        </div>
    </body>
</html>
