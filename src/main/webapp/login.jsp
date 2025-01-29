<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <title>Servlets</title>
  <meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1"/>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"
          type="application/javascript"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
          type="application/javascript"></script>
</head>

<!-- Usar < %  y % > para insertar codigo java en el html -->
<body>
<%
  //Codigo de java para el sistema de identificacion de usuario/contrasena
  String name = request.getParameter("name");
  String password = request.getParameter("password");
  //Nota seguridad: NUNCA HARDCODEAR UNA CONTRASENA EN UNA APLICACION REAL
  if(name !=  null && name.equals("admin") && password!=null && password.equals("admin")){
    //Caso de que sea un inicio valido, se guarda en sesion
    request.getSession().setAttribute("user","admin"); //Se asigna USER a: ADMIN
    response.sendRedirect("admin.jsp");  //Se ha iniciado el admin, SE REDIRECCIONA al archivo ADMIN.JSP
  }else{
    //Inicio no valido, se elimina de sesion
    request.getSession().setAttribute("user", null); //se pone a null el valor de USER
  }
%>

<!-- Contenido del body mas alla del codigo java:-->
<div class="container" id="main-container">
  <h2>Identificación de usuario</h2>
  <form class="form-horizontal" method="post" action="login.jsp">
    <div class="form-group">
      <label class="control-label col-sm-2" for="name">Nombre:</label>
      <div class="col-sm-10">
        <input type="text" class="form-control" id="name" name="name" required="true"/>
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="password">Password:</label>
      <div class="col-sm-10">
        <input type="password" class="form-control" id="password" name="password"
               required="true"/>
      </div>
    </div>
    <div class="form-group">
      <div class="col-sm-offset-2 col-sm-10">
        <button type="submit" class="btn btn-primary">Agregar</button>
      </div>
    </div>
  </form>
</div>
</body>
</html>

<!-- Asi hacemos un login en el que se piden obligatoriamente un Nombre de usuario y una Contrasena -->