<%@LANGUAGE = VBScript%>
<html>
<head>
    <title>KoalaCoding Co.</title>
    <link rel="stylesheet" href="styles.css" type="text/css" >
</head>
<body>

<header class="title">Welcome to KoalaCoding Co.</header>

<div class="big-login-container">
    <div class="small-login-container">
        <div class="login-title">Login:</div>
        <form method="get" action="login.asp" class="big-form-container">
            <div class="form-container">
                <div> Username: <input type="text" name="lusername" required></div> 
                <div> Password: <input type="text" name="lpassword" required></div> 
            </div>
            <input type="submit" value="Login">
        </form>
    </div>

    <div class="small-login-container">
        <div class="login-title">Sign in:</div>
        <form method="get" action="registration.asp" class="big-form-container">
            <div class="form-container">
                <div> Username: <input type="text" name="fusername" required></div> 
                <div> Password: <input type="text" name="fpassword" required></div> 
                <div> Name: <input type="text" name="fname" required></div> 
                <div> Surname: <input type="text" name="fsurname"></div> 
                <div> Company: <input type="text" name="fcompany"></div> 
            </div>
            <input type="submit" value="Sign in">
        </form>
    </div>
</div>


</body>
</html>
