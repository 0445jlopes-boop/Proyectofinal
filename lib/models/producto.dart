

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
  void setNombre(String nombre){
    this.nombre=nombre;
  }
  void setImagen(String imagen){
    this.imagen =imagen;
  }
  void setDescripcion(String descripcion){
    this.descripcion =descripcion;
  }
  void setStock(int stock){
    this.stock= stock;
  }
  void setPrecio(double precio){
    this.precio= precio;
  }
}