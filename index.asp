<%@LANGUAGE = VBScript%>
<html>
<head>
<title>La mia prima pagina ASP</title>
</head>
<body>

<%="Benvenuti nel mondo ASP!"%>
<p>The time is @DateTime.Now</p>

<%
Dim conn
Set conn = Server.CreateObject("ADODB.Connection")
conn.Open ""

' Verifica lo stato della connessione
If conn.State = 1 Then
    Response.Write "Connessione al database stabilita con successo."
Else
    Response.Write "Errore durante la connessione al database."
End If
%>


</body>
</html>