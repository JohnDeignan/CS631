<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href='http://fonts.googleapis.com/css?family=Arizonia' rel='stylesheet' type='text/css'>
        <link href="https://fonts.googleapis.com/css?family=Josefin+Sans" rel="stylesheet">
        <title>Hulton Hotels</title>
        <style>
            #gobutton {
                color: #ffffff;
                background: rgba(0,0,0,0);
                border: solid 3px #ffffff;
                font-size: 125%;
                font-family: 'Josefin Sans', sans-serif;
                display:block;
                height: 150%;
                width: 150%;
                margin: 0 auto;
                border-radius:25px;
            }

            #gobutton:hover{
                border-color: #b1b1b1;
                color: #b1b1b1;
            }

            #centered {
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
            }

            #center {
                position: fixed;
                top: 70%;
                left: 50%;
                transform: translate(-50%, -50%);
            }

            #cent {
                position: fixed;
                top: 58%;
                left: 50%;
                transform: translate(-50%, -50%);
            }

            body {
                background-image: url("http://findmombasahotels.com/wp-content/uploads/2013/05/Night2.jpg");
                background-repeat: no-repeat;
                font-family: 'Josefin Sans', sans-serif;
                color: #ffffff;
            }

            p {
                font-size: 20px;
                text-align: center;
                font-family: 'Josefin Sans', sans-serif;
                color: #ffffff;
            }
        </style>
    </head>
    <body>
        <div id="centered">
            <p>Thank you for taking the time to leave a review.</p>
            <p>Please enter your email and select from one of the review categories below: <p/><br/>
        </div>        
        <div id="cent" style="height: 2em;">
            <form action="selectRev.jsp">
                <span >Email:</span>            
                <input type="text" name="email" style= "width: 150px;"> 
                <br/>
                <br/><input id="gobutton" type="submit" value="GO" />
            </form>
        </div><br/>
    </body>
</html>
