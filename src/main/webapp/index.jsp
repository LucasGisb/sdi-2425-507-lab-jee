<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>  <!-- NECESARIO PARA USAR JSTL -->

<%@ page import="com.uniovi.sdi.Product" %>
<%@ page import="com.uniovi.sdi.ProductsService" %>
<%@ page import="java.util.List" %>

<html lang="en">
<head>
    <title>Servlets</title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>

<body>

<!-- Contador del Numero de visistas recibidas en la pagina. Se muestra en el nav barra de navegacion superior. Antes script, ahora Bean -->
<jsp:useBean id="counter" class="com.uniovi.sdi.Counter"  scope="application"/>  <!-- IMP: Este SCOPE para que el contador sea comun entre todos los usuarios (es decir, de la aplicacion) -->
<jsp:setProperty name="counter" property="increase" value="1"/> <!-- Incrementa el contador de la pagina por 1-->

<!-- Barra de Navegación superior -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="collapse navbar-collapse" id="my-navbarColor02">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item ">
                <a class="nav-link" href="AddToShoppingCart">Carrito<span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item ">
                <a class="nav-link" href="login.jsp">Login<span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item ">
                <a class="nav-link" href="admin.jsp">Administrar productos<span class="sr-only">(current)</span></a>
            </li>
        </ul>
        <div class="nav navbar-right">
            <%-- <%=counter%> Visitas --%>
            <!-- Cambiado por el Bean siguiente -->
            <jsp:getProperty name="counter" property="total"/> Visitas
        </div>
    </div>
</nav>
<!-- Contenido -->
<div class="container" id="main-container">
    <h2>Productos</h2>
    <div class="row ">
            <!-- //Anterior script, ahora sustituido por JSTL
                //Por todos los productos de la BD obtenidos por ProductsService getProducts, los metemos en la pagina
                List<Product> listProducts = new ProductsService().getProducts();
                for(Product product : listProducts){
            -->
        <!-- Nueva manera de hacer el liistado usando JSTL -->
        <jsp:useBean id="productsService" class="com.uniovi.sdi.ProductsService"/>
        <c:forEach var="product" begin="0" items="${productsService.products}">

        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
            <div>
                <!-- <img src="< %=product.getImage() %>" alt="" />
                <div>< %=product.getName() %></div> -->
                    <!--Actualizacion ahora recorriendo con JSTL -->
                <img src="<c:out value="${product.image}"/>" alt=""/>
                <div><c:out value="${product.name}"/></div>

                <!-- <a href="AddToShoppingCart?product=< %=product.getName() %>" class="btn btn-default" > -->
                    <!-- < %=product.getPrice() %> € -->
                    <!--Actualizacion ahora recorriendo con JSTL -->
                <a href="AddToShoppingCart?product=<c:out value="${product.name}"/>"
                       class="btn btn-default">
                    <c:out value="${product.price}"/> €
                </a>
            </div>
        </div>
        <!-- < %  //el anterior codigo html se repite segun el for de este codigo java
            }
        %> -->
        </c:forEach>
    </div>
</div>
</body>
</html>