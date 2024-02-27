<%@LANGUAGE = VBScript%>
<!--#include file="connessione.asp"-->

<%
Dim username, userPage, userCurrentPage
username = request.querystring("username")
userPage = request.querystring("page")
userCurrentPage = "homepage.asp?username=" & username & "&page=" & userPage

Dim db_connection ' Variabile per la connessione
' Creo un'istanza per la connessione
Set db_connection = Server.CreateObject("ADODB.Connection")
db_connection.Open str_cn ' Apro la connessione al database
Dim SQL ' Creo la query di cancellazione


If userPage = "products" Then
  SQL = "DELETE FROM products WHERE id = '" & request.querystring("id") &"'"
  db_connection.Execute(SQL)

ElseIf userPage = "purchases" Then

Else

  SQL = "DELETE FROM users WHERE id = '" & request.querystring("id") &"'"
  db_connection.Execute(SQL)

End If



' Chiudo la connessione
db_connection.Close
Set db_connection = Nothing

' Conferma a video
Response.Write "<p>Record deleted</p>"
Response.Redirect userCurrentPage
%>