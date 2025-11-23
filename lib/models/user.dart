class UserOfMyApp{
  String trato;
  String nombre;
  String contrasena;
  int edad;
  String nacimiento;
  String imagen;
  bool isAdmin;
  bool isBlok;

  UserOfMyApp({
    required this.trato,
    required this.nombre,
    required this.contrasena,
    required this.edad,
    required this.nacimiento,
    required this.imagen,
    required this.isAdmin,
    required this.isBlok
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
  bool getIsBlok(){
    return isBlok;
  }

  void setTrato(String _trato){
    this.trato = _trato;
  }
  void setNombre(String _nombre){
    this.nombre = _nombre;
  }
  void setContrasena(String _contrasena){
    this.contrasena = _contrasena;
  }
  void setEdad(int _edad){
    this.edad = _edad;
  }
  void setNacimiento(String _nacimiento){
    this.nacimiento = _nacimiento;
  }
  void setImagen(String _imagen){
    this.imagen = _imagen;
  }
  void setAdmin(bool _isAdmin){
    this.isAdmin = _isAdmin;
  }
  void setIsBlok(bool _isBlok){
    this.isBlok = _isBlok;
  }


}