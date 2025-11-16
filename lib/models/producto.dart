import 'dart:ffi';

class Producto {
  String nombre;
  String imagen;
  String descripcion;
  double precio;
  int stock;
  Producto({
    required this.nombre,
    required this.imagen,
    required this.descripcion,
    required this.precio,
    required this.stock,
  });

  String getNombre(){
    return nombre;
  }
  String getImagen(){
    return imagen;
  }
  String getDescripcion(){
    return descripcion;
  }
  int getStock(){
    return stock;
  }
  double getPrecio(){
    return precio;
  }
  void setNombre(){
    this.nombre=nombre;
  }
  void setImagen(){
    this.imagen =imagen;
  }
  void setDescripcion(){
    this.descripcion =descripcion;
  }
  void setStock(){
    this.stock= stock;
  }
  void setPrecio(){
    this.precio= precio;
  }
}