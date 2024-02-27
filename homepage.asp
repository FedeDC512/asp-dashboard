<%@LANGUAGE = VBScript%>
<!--#include file="connessione.asp"-->
<%
Dim db_connection, db_recordset ' Variabili per la connessione e per il Recordset

' Creo un'istanza per la connessione ed una per il Recordset
Set db_connection = Server.CreateObject("ADODB.Connection")
Set db_recordset = Server.CreateObject("ADODB.Recordset")

db_connection.Open str_cn ' Apro la connessione al database

Dim SQL ' Creo la query SQL

Dim username, userSidebarPages, userCurrentPage
username = request.querystring("username")
userCurrentPage = request.querystring("page")
userSidebarPages = "homepage.asp?username=" & username & "&page="

If username = "" Then
Response.Redirect "index.asp"
End If
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
          <li><a href="<%=userSidebarPages%>users">Show Users</a></li>
          <li><a href="<%=userSidebarPages%>products">Show Products</a></li>
          <li><a href="<%=userSidebarPages%>purchases">Show Purchases</a></li>
          <li><a href="index.asp">Log Out</a></li>
        </ul>
      </div>
        <div class="card-list">
<%
If userCurrentPage = "products" Then
  SQL = "SELECT * FROM products"
  db_recordset.Open SQL, db_connection ' Apro il Recordset

  'mostra i prodotti
    If db_recordset.EOF = True Then
  %>
  <div class="card">No data found</div>
  <%
  Else
  While db_recordset.EOF = False
  %>
  <div class="card">
      <img src="https://source.unsplash.com/random/200x200?sig=<%=db_recordset("id")%>" alt="Random Image">
      <div>
        <b>ID:</b> <%=db_recordset("id")%> <br>
        <b>Name:</b> <%=db_recordset("p_name")%> <br>
        <b>Description:</b> <%=db_recordset("description")%> <br>
      </div>
      <a href="delete.asp?username=<%=username%>&page=<%=userCurrentPage%>&id=<%=db_recordset("id")%>" class="button">Delete</a>
  </div>

  <%
  db_recordset.MoveNext
  Wend
  End If
  
ElseIf userCurrentPage = "purchases" Then
  SQL = "SELECT * FROM users u INNER JOIN purchases o ON u.id = o.user_id INNER JOIN products p ON o.product_id = p.id"
  db_recordset.Open SQL, db_connection ' Apro il Recordset

  'mostra gli acquisti
    If db_recordset.EOF = True Then
  %>
  <div class="card">No data found</div>
  <%
  Else
  While db_recordset.EOF = False
  %>
  <div class="card">
      <img src="https://source.unsplash.com/random/200x200?sig=<%=db_recordset("product_id")%>" alt="Random Image">
      <div>
        <b>User ID:</b> <%=db_recordset("user_id")%> <br>
        <b>Product ID:</b> <%=db_recordset("product_id")%> <br>
        <b>Quantity:</b> <%=db_recordset("quantity")%> <br>
        <b>This meand that: </b><%=db_recordset("username")%> (<%=db_recordset("name")%> <%=db_recordset("surname")%>) has purchased <%=db_recordset("quantity")%> of <%=db_recordset("p_name")%><br>
      </div>
      <a href="" class="button greenbutton">Order</a>
  </div>

  <%
  db_recordset.MoveNext
  Wend
  End If

Else
  SQL = "SELECT * FROM users"
  ' Apro il Recordset
  db_recordset.Open SQL, db_connection

  If db_recordset.EOF = True Then
  %>
  <div class="card">No data found</div>
  <%
  Else
  While db_recordset.EOF = False
  %>
  <div class="card">
      <img src="https://source.unsplash.com/random/200x200?sig=<%=db_recordset("id")%>" alt="Random Image">
      <div>
        <b>ID:</b> <%=db_recordset("id")%> <br>
        <b>Username:</b> <%=db_recordset("username")%> <br>
        <b>Name:</b> <%=db_recordset("name")%> <br>
        <b>Surname:</b> <%=db_recordset("surname")%> <br>
        <b>Company:</b> <%=db_recordset("company")%> <br>
      </div>
      <a href="delete.asp?username=<%=username%>&page=<%=userCurrentPage%>&id=<%=db_recordset("id")%>" class="button">Delete</a>
  </div>

  <%
  db_recordset.MoveNext
  Wend
  End If

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