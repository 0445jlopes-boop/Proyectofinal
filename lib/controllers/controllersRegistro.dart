import 'package:jessicalopesc1/models/user.dart';
import 'package:jessicalopesc1/services/LogicaUsuarios.dart';

class Controllersregistro {
  static bool userExiste(String nombre, String contrasena){
    bool esta = false;
    LogicaUsuarios.getListaUsuarios().forEach((usuario){
      if(usuario.getNombre()==nombre && usuario.getContrasena()==contrasena){
        esta= true;
      }
    });
    return esta;
  }
  static UserOfMyApp extraerUsuario(String nombre, String contrasena){
    for (var i = 0; i <= LogicaUsuarios.getListaUsuarios().length-1; i++) {
      if(LogicaUsuarios.getListaUsuarios()[i].getNombre()==nombre && LogicaUsuarios.getListaUsuarios()[i].getContrasena()==contrasena){
        return LogicaUsuarios.getListaUsuarios()[i];
      }
    }
    return UserOfMyApp(trato: "error", nombre: "error", contrasena: "error", edad: 0, nacimiento: "error", imagen: "assets\images\logo.png", isAdmin: false, isBlok: true);
  }
  static String? extraerContrasena(String nombre){
      for(var i = 0; i <= LogicaUsuarios.getListaUsuarios().length-1; i++){
        if(LogicaUsuarios.getListaUsuarios()[i].getNombre() == nombre){
          return LogicaUsuarios.getListaUsuarios()[i].getContrasena();
        }
      }
      return null;
  }
 
}
