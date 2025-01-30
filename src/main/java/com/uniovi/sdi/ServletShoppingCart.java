package com.uniovi.sdi;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;


//Servlet que simula el Carrito de la Tienda de productos
@WebServlet(name = "ServletShoppingCart", value = "/AddToShoppingCart")

public class ServletShoppingCart extends HttpServlet {



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
        HttpSession session = request.getSession();
        HashMap<String, Integer> cart =
                (HashMap<String, Integer>) session.getAttribute("cart");
        // No hay carrito, creamos uno y lo insertamos en sesión
        if (cart == null) {
            cart = new HashMap<String, Integer>();
            session.setAttribute("cart", cart);
        }
        //se busca en el carrito segun la peticion del usuario
        String product = request.getParameter("product");
        if (product != null) {
            addToShoppingCart(cart, product);
        }

        // Retornar la Vista con parámetro "selectedItems"
        request.setAttribute("selectedItems", cart);
        getServletContext().getRequestDispatcher("/cart.jsp").forward(request, response);

        /* Eliminado para aplicar Modelo-Vista-Controlador
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<HTML>");
        out.println("<HEAD><TITLE>Tienda SDI: Cesta de la compra</TITLE></HEAD>");
        out.println("<BODY>");
        out.println(shoppingCartToHtml(cart) + "<br>");
        out.println("<a href=\"index.jsp\">Volver</a></BODY></HTML>");
         */
    }

    //Metodos auxiliares para la llamada doGet:

    //addToShoppingCart.- Anade al HashMap que representa el Carrito de la compra el producto en cuestion (identificado por productKey)
    private void addToShoppingCart(HashMap<String, Integer> cart, String productKey) {  //porductKey = Nombre del producto a buscar/introducir
        if(cart.get(productKey) == null){ //Caso de que no haya ningun elemento del tipo requesteado
            cart.put(productKey, 1); //Se anade el nuevo prodcuto, ESTE 1 ES LA KEY DEL TIPO DE PRODUCTO. Al ser nuevo, se le pone 1, de ir anadiendose mas de este tipo serian 2,3,4...
        }else{
            int productCount = cart.get(productKey); //miramos cuantos elementos hay del tipo requesteado
            cart.put(productKey, productCount+1); //Anadimos con el key que le corresponde al nuevo elemento
        }
    }

    //Paso el contenido del Carrito hashMap a un formato HTML
    private String shoppingCartToHtml(HashMap<String, Integer> cart) {
        StringBuilder shoppingCartToHtml = new StringBuilder();
        //Por cada producto anado una linea html
        for(String key : cart.keySet()) {
            shoppingCartToHtml.append("<p>[").append(key).append("],").append(cart.get(key)).append("unidades</p>");
        }
        return shoppingCartToHtml.toString();
    }

    //

}
