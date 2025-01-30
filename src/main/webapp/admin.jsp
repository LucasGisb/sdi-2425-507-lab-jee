<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>  <!-- Se agrega la directiva "c" para usar JSTL con este prefijo -->
<%@ page language="java" import="com.uniovi.sdi.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <title>Página de administración</title>
    <meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"
            type="application/javascript"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
            type="application/javascript"></script>
</head>
<body>

<!-- < %
    //Script Codigo de java insertado en html. Se muestra al USER y de no haber se REDIRECCIONA a LOGIN.JSp
    String user = (String) request.getSession().getAttribute("user");
    System.out.println("Usuario en sesión: " + user);
    if (user == null || !user.equals("admin")) {
        // No hay usuario o no es admin
        response.sendRedirect("login.jsp");
    }
%> Se sustituye los scripts tradicionales por las etiquetas JSTL -->
<c:if test="${sessionScope.user != 'admin'}">
    <c:redirect url="/login.jsp"/>
</c:if>

<jsp:useBean id="product" class="com.uniovi.sdi.Product"/>  <!-- Obligatorio para poder usar BEANS. En este caso, mi Product  -->
<jsp:setProperty name="product" property="*"/> <!-- Trabajamos con todas las propiedades/atributos de este Bean Product -->

<!-- < %
    //Segundo script
    if (product.getName() != null) {  //este product es el Product generado al enviar el cuestionario/forms de mas abajo. Fue enviado por POST
        new ProductsService().setNewProduct(product); //ANADE el producto a la bd
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
%> Se sustituye los scripts tradicionales por las etiquetas JSTL -->
<c:if test="${product.name != null}">
    <jsp:useBean id="productsService" class="com.uniovi.sdi.ProductsService"/>
    <jsp:setProperty name="productsService" property="newProduct" value="${product}"/>
    <c:redirect url="/index.jsp"/>
</c:if>

<!-- Contenido -->
<div class="container" id="main-container">  <!-- <div class="container" id="contenedor-principal">  -->

    <!-- Un formulario que solicita: Nombre, Imagen URL y el precio del producto solicitado. Se envia por POST  -->

    <h2>Agregar producto a la tienda</h2>
    <form class="form-horizontal" method="post" action="admin.jsp">
        <div class="form-group">
            <label class="control-label col-sm-2" for="name">Nombre:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="name" name="name" required="true"/>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-2" for="image">URL imagen:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="image" name="image" required="true"/>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-2" for="price">Precio (€):</label>
            <div class="col-sm-10">
                <input type="number" step="0.01" class="form-control" id="price" name="price"
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