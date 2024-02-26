<%@LANGUAGE = VBScript%>
<!--#include file="connessione.asp"-->
<%
Dim db_connection, db_recordset ' Variabili per la connessione e per il Recordset

' Creo un'istanza per la connessione ed una per il Recordset
Set db_connection = Server.CreateObject("ADODB.Connection")
Set db_recordset = Server.CreateObject("ADODB.Recordset")

db_connection.Open str_cn ' Apro la connessione al database

Dim SQL ' Creo la query SQL
SQL = "SELECT * FROM users"

' Apro il Recordset
db_recordset.Open SQL, db_connection

Dim username
username = request.querystring("username")
%>

<html>
  <head>
    <title>Homepage</title>
    <link rel="stylesheet" href="styles.css" type="text/css" >
  </head>
  <body class="homepage-body">
    <div class="homepage-title">
      <%= username%>'s Homepage
    </div>

    <div class="middle-page">
      <div class="sidebar">
        <ul>
          <li><a href="#">link one</a></li>
          <li><a href="#">link two</a></li>
          <li><a href="#">ink three</a></li>
          <li><a href="#">link four</a></li>
        </ul>
      </div>
        <div class="card-list">
<%
If db_recordset.EOF = True Then
%>
<div class="card">Nessun dato trovato</div>
<%
Else
While db_recordset.EOF = False
%>
<div class="card">
    <img src="https://picsum.photos/200" alt="Random Image" width="190" height="190">
    <b>ID:</b> <%=db_recordset("id")%> <br>
    <b>Username:</b> <%=db_recordset("username")%> <br>
    <b>Name:</b> <%=db_recordset("name")%> <br>
    <b>Surname:</b> <%=db_recordset("surname")%> <br>
    <b>Company:</b> <%=db_recordset("company")%> <br>
</div>

<%
db_recordset.MoveNext
Wend

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