<%@LANGUAGE = VBScript%>
<!--#include file="connessione.asp"-->
<%
Dim db_connection, db_recordset ' Variabili per la connessione e per il Recordset

' Creo un'istanza per la connessione ed una per il Recordset
Set db_connection = Server.CreateObject("ADODB.Connection")
Set db_recordset = Server.CreateObject("ADODB.Recordset")

db_connection.Open str_cn ' Apro la connessione al database

Dim SQL ' Creo la query SQL
SQL = "SELECT * FROM users WHERE username = '"&request.querystring("lusername")&"' AND password = '"&request.querystring("lpassword")&"'"

' Apro il Recordset
db_recordset.Open SQL, db_connection
%>

<html>
<head>
    <title>Login Page</title>
    <link rel="stylesheet" href="styles.css" type="text/css" >
</head>
<body>
<div class="big-login-container">
<div class = "login-page-container"> 

<%
' Verifico che la tabella contenga dati

' Se non ne contiene lancio un messaggio di avviso
If db_recordset.EOF = True Then
%>
<p>The entered data does not match any registered user, please sign in!</p>
<a href="index.asp">
  <button>Sign in</button>
</a>

<%
' Se invece ne contiene visualizzo i dati in funzione
' della query SQL specificata
Else
%>

<div>The user is correctly registered!</div>

<div>
    <b>ID:</b> <%=db_recordset("id")%> <br>
    <b>Username:</b> <%=db_recordset("username")%> <br>
    <b>Name:</b> <%=db_recordset("name")%> <br>
    <b>Surname:</b> <%=db_recordset("surname")%> <br>
    <b>Company:</b> <%=db_recordset("company")%> <br>
</div>

<%
Dim username, userHomepage
username = db_recordset("username")
userHomepage = "homepage.asp?username=" & Server.URLEncode(username)
%>

<a href= "<%= userHomepage%>">
  <button>Homepage</button>
</a>

<%
End If
%>
</div>
</div>

</body>
</html>


<%
' Chiudo il Recordset
db_recordset.Close
Set db_recordset = Nothing

' Chiudo la connessione
db_connection.Close
Set db_connection = Nothing
%>
