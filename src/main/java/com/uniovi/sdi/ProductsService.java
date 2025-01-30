package com.uniovi.sdi;
import java.util.LinkedList;
import java.util.List;
import com.db4o.Db4oEmbedded;
import com.db4o.ObjectContainer;

//Clase que hara operaciones con los Productos
public class ProductsService {

    //Base de datos de la que obtener los productos
    ObjectContainer db = null;

    //Devuelve lista de todos los productos de la BD
    public List<Product> getProducts() {
        List<Product> products = new LinkedList<Product>();
        db = null;
        try {
            db = Db4oEmbedded.openFile("bdProducts");
            List<Product> response = db.queryByExample(Product.class);
            // NO RETORNAR LA MISMA LISTA DE LA RESPUESTA
            products.addAll(response);
        } finally {
            assert db != null;
            db.close();
        }
        return products;
    }

    //Agregar un nuevo producto
    public void setNewProduct(Product newProduct) {
        db = null;
        try {
            db = Db4oEmbedded.openFile("bdProducts");
            db.store(newProduct);
        } finally {
            assert db != null;
            db.close();
        }
    }
}
