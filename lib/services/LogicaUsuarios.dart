import 'package:jessicalopesc1/models/user.dart';

class LogicaUsuarios {
  static final List<User> _listaUsuarios = [
    User(
      trato: "Sra",
      nombre: "admin",
      contrasena: "admin",
      edad: 18,
      nacimiento: "Zaragoza",
      imagen: 'assets/images/logo.png',
      isAdmin: true
    ),
    User(
      trato: "Sr", 
      nombre: "Jessica", 
      contrasena: "Jessica", 
      edad: 18, 
      nacimiento: "Zaragoza", 
      imagen: 'assets/images/logo.png',
      isAdmin: false
    ),
     User(
      trato: "Sr", 
      nombre: "Gian", 
      contrasena: "Gian", 
      edad: 19, 
      nacimiento: "Zaragoza", 
      imagen: 'assets/images/logo.png',
      isAdmin: false
    )
  ];
  static void anadirUsuario(User usuario){
    _listaUsuarios.add(usuario);
  }
  static List<User> getListaUsuarios(){
    return _listaUsuarios;
  }

  
}