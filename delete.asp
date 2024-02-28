<%@LANGUAGE = VBScript%>
<!--#include file="connection.asp"-->

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

'ElseIf userPage = "purchases" Then

ElseIf userPage = "users" Then

  SQL = "DELETE FROM users WHERE id = '" & request.querystring("id") &"'"
  db_connection.Execute(SQL)

Else
  SQL = "SELECT * FROM purchases WHERE user_id = '" & request.querystring("user_id") &"' AND product_id = '" & request.querystring("product_id") &"' AND quantity = '1'"
  Set product_quantity = db_connection.Execute(SQL)
  If not product_quantity.EOF Then
  SQL = "DELETE FROM purchases WHERE user_id = '" & request.querystring("user_id") &"' AND product_id = '" & request.querystring("product_id") &"'"
  db_connection.Execute(SQL)
  Else

  SQL = "SELECT * FROM purchases WHERE user_id = '" & request.querystring("user_id") &"' AND product_id = '" & request.querystring("product_id") &"'"
  product_quantity = db_connection.Execute(SQL)
  
  Dim new_value 
  new_value = product_quantity("quantity")
  new_value = new_value - 1

  SQL = "UPDATE purchases SET quantity='"& new_value &"' WHERE user_id = '" & request.querystring("user_id") &"' AND product_id = '" & request.querystring("product_id") &"'"
  db_connection.Execute(SQL)
  End If
End If



' Chiudo la connessione
db_connection.Close
Set db_connection = Nothing

' Conferma a video
Response.Write "<p>Record deleted</p>"
Response.Redirect userCurrentPage
%>