class UserOfMyApp{
  String trato;
  String nombre;
  String contrasena;
  int edad;
  String nacimiento;
  String imagen;
  bool isAdmin;

  UserOfMyApp({
    required this.trato,
    required this.nombre,
    required this.contrasena,
    required this.edad,
    required this.nacimiento,
    required this.imagen,
    required this.isAdmin
  });
 

  String getNombre(){
    return nombre;
  }
  String getTrato(){
    return trato;
  }
  String getContrasena(){
    return contrasena;
  }
  int getEdad(){
    return edad;
  }
  String getNacimiento(){
    return nacimiento;
  }
  String getImagen(){
    return imagen;
  }
  bool getIsAdmin(){
    return isAdmin;
  }

  void setTrato(String _trato){
    this.trato = _trato;
  }

}