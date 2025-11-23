import 'package:jessicalopesc1/models/producto.dart';

class Logicaproductos {

  static final List<Producto> _listaProductos =[
    Producto(
      nombre: "Producto 1", 
      imagen: 'assets/images/imgProducto.jpg', 
      descripcion: "Descripcion de producto 1", 
      precio: 23, 
      stock: 15
    ),
    Producto(
      nombre: "Producto 2", 
      imagen: 'assets/images/imgProducto2.jpg', 
      descripcion: "Descripcion de producto 2", 
      precio: 15.67, 
      stock: 10
    ),
    Producto(
      nombre: "Producto 3", 
      imagen: 'assets/images/imgProducto3.jpg', 
      descripcion: "Descripcion de producto 3", 
      precio: 15.67, 
      stock: 10
    ),
  ];
  static void anadirProducto(Producto producto) {
    _listaProductos.add(producto);
  }

  static List<Producto> getListaProducos() {
    return _listaProductos;
  }

  static bool eliminarProducto(Producto producto) {
    return _listaProductos.remove(producto);
  }
}
