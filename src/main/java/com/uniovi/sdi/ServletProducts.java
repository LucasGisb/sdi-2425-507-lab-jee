package com.uniovi.sdi;

import com.db4o.Db4oEmbedded;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;


//Servlet que simula el Carrito de la Tienda de productos
@WebServlet(name = "ServletProducts", value = "/products") //URL y peticion a llamar

public class ServletProducts extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {

        //Obtengo los productos de la BD (no de la sesion)
        ProductsService productsService = new ProductsService();
        List<Product> storeProducts = productsService.getProducts();

        request.setAttribute("storeProducts", storeProducts);

        getServletContext().getRequestDispatcher("/products-view.jsp").forward(request, response);
    }

    //Metodos auxiliares para la llamada doGet:

}
