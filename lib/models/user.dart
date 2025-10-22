class User{
  String trato;
  String nombre;
  String contrasena;
  int edad;
  String nacimiento;
  String imagen;

  User({
    required this.trato,
    required this.nombre,
    required this.contrasena,
    required this.edad,
    required this.nacimiento,
    required this.imagen
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

}