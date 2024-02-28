<%@LANGUAGE = VBScript%>
<!--#include file="connection.asp"-->

<%
Dim username, userPage, userCurrentPage
username = request.querystring("username")
userPage = request.querystring("page")
product_id = request.querystring("id")
userCurrentPage = "homepage.asp?username=" & username & "&page=" & userPage

Dim db_connection ' Variabile per la connessione
' Creo un'istanza per la connessione
Set db_connection = Server.CreateObject("ADODB.Connection")
db_connection.Open str_cn ' Apro la connessione al database
Dim SQL ' Creo la query di cancellazione


SQL = "SELECT * FROM purchases p INNER JOIN users u ON p.user_id = u.id WHERE username = '" & request.querystring("username") &"'"
Set get_user_id = db_connection.Execute(SQL)
Dim user_id
user_id = get_user_id("user_id")
SQL = "SELECT * FROM purchases WHERE user_id = '" & user_id &"' AND product_id = '" & product_id &"'"
Set product_quantity = db_connection.Execute(SQL)

If not product_quantity.EOF Then
    Dim new_value 
    new_value = product_quantity("quantity")
    new_value = new_value + 1
    SQL = "UPDATE purchases SET quantity='"& new_value &"' WHERE user_id = '" & user_id &"' AND product_id = '" & product_id &"'"
    db_connection.Execute(SQL)
Else
    SQL = "INSERT INTO purchases (`user_id`, `product_id`, `quantity`) VALUES ('" & user_id &"', '" & product_id &"', '1')"
    db_connection.Execute(SQL)
End If




' Chiudo la connessione
db_connection.Close
Set db_connection = Nothing

' Conferma a video
Response.Write "<p>Record added</p>"
Response.Redirect userCurrentPage
%>