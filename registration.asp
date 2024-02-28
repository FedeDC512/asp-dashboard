<%@LANGUAGE = VBScript%>
<!--#include file="connection.asp"-->

<%
Dim db_connection ' Variabile per la connessione

' Creo un'istanza per la connessione
Set db_connection = Server.CreateObject("ADODB.Connection")

db_connection.Open str_cn ' Apro la connessione al database

Dim SQL ' Creo la INSERT in SQL
SQL = "INSERT INTO users (username, password, name, surname, company) VALUES ('"&request.querystring("fusername")&"', '"&request.querystring("fpassword")&"', '"&request.querystring("fname")&"', '"&request.querystring("fsurname")&"','"&request.querystring("fcompany")&"')"

db_connection.Execute(SQL)

' Chiudo la connessione
db_connection.Close
Set db_connection = Nothing

' Rimando alla pagina di lettura dei dati
Response.Redirect "homepage.asp"
%>