
import 'package:jessicalopesc1/models/user.dart';

class LogicaUsuarios {
  static final List<UserOfMyApp> _listaUsuarios = [
    UserOfMyApp(
      trato: "Sra",
      nombre: "admin",
      contrasena: "admin",
      edad: 18,
      nacimiento: "Zaragoza",
      imagen: 'assets/images/logo.png',
      isAdmin: true,
      isBlok: false
    ),
    UserOfMyApp(
      trato: "Sr", 
      nombre: "Jessica", 
      contrasena: "Jessica", 
      edad: 18, 
      nacimiento: "Zaragoza", 
      imagen: 'assets/images/logo.png',
      isAdmin: false,
      isBlok: false
    ),
    UserOfMyApp(
      trato: "Sr", 
      nombre: "Gian", 
      contrasena: "Gian", 
      edad: 19, 
      nacimiento: "Zaragoza", 
      imagen: 'assets/images/logo.png',
      isAdmin: false,
      isBlok: false
    ),
    UserOfMyApp(
      trato: "Sr", 
      nombre: "a", 
      contrasena: "a", 
      edad: 19, 
      nacimiento: "Zaragoza", 
      imagen: 'assets/images/logo.png',
      isAdmin: false,
      isBlok: false
    )
  ];


  static void anadirUsuario(UserOfMyApp usuario){
    _listaUsuarios.add(usuario);
  }
   static List<UserOfMyApp> getListaUsuarios(){
    return _listaUsuarios;
  }
  static bool eliminarUsuario(UserOfMyApp usuario){

    return _listaUsuarios.remove(usuario);
    
  }
 



  
}