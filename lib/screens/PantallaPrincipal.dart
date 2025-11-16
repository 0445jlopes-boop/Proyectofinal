import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jessicalopesc1/controllers/controllersRegistro.dart';
import 'package:jessicalopesc1/controllers/user_controller.dart';
import 'package:jessicalopesc1/screens/User/PantallaRegistro.dart';
import 'package:jessicalopesc1/screens/Admin/PantallaSecundariaAdmin.dart';
import 'package:jessicalopesc1/screens/User/PantallaSecundariaUsuario.dart';
import 'package:jessicalopesc1/config/resources/Pantalla_constantes.dart';
import 'package:jessicalopesc1/config/utils/Validators.dart';
import 'package:jessicalopesc1/config/utils/button_styles.dart';
import 'package:jessicalopesc1/services/LogicaUsuarios.dart';
import 'package:jessicalopesc1/widgets/Dialogo.dart';
import 'package:jessicalopesc1/models/user.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {

  String _nombre="";
  String _contrasena ="";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controladorTextFormField = TextEditingController(); //Esto permite borrar y asignar texto a un Text form field, lo suaremos para motrar la contraseña en el alrt dialog

  void _iniciarGoogle(UserCredential userCredential){
    if(Controllersregistro.userExiste(UserController.nombre!, "")){
       Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => Pantallasecundariausuario(user: Controllersregistro.extraerUsuario(UserController.nombre!, "")))
        );
    }else if(Controllersregistro.userExiste(UserController.nombre!, "")!= true){
      UserOfMyApp usuario = UserOfMyApp(trato: "Sr", nombre: UserController.nombre!, contrasena: "", edad: 18, nacimiento: "Zaragoza", imagen: UserController.foto!, isAdmin: false);
      LogicaUsuarios.anadirUsuario(usuario);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=> Pantallasecundariausuario(user: usuario,)),
      );
    }else{
      const snackBar = SnackBar(content: Text('Error al iniciar con Google'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);      
    }
  }

  void _validarUsuario(){
    final isFormValid = _formKey.currentState!.validate();
    if(isFormValid && Controllersregistro.userExiste(_nombre, _contrasena)){
      if(Controllersregistro.extraerUsuario(_nombre, _contrasena).isAdmin){
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => Pantallasecundariaadmin(user: Controllersregistro.extraerUsuario(_nombre, _contrasena)))
        );

      }else{
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => Pantallasecundariausuario(user: Controllersregistro.extraerUsuario(_nombre, _contrasena)))
        );
      }
      
      
    }else{
      const snackBar = SnackBar(content: Text('Este usuario no existe'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:PantallaConstantes.fondoAppBar,
        title: Text("Pantalla Principal"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        alignment: AlignmentGeometry.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/images/logo.png'),
              SizedBox(height: PantallaConstantes.separador),
              SizedBox(
                width: PantallaConstantes.ancho,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        child:TextFormField(
                          decoration: const InputDecoration(
                           labelText: "Nombre",
                           border: OutlineInputBorder(),
                          ),         
                          validator: (value) =>  Validators.validateEmpty(value),                 
                          onChanged: (value) => _nombre = value,                          
                        ), 
                      ),
                      SizedBox(
                        child:TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: "Contraseña",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>  Validators.validateEmpty(value),
                          onChanged: (value) => _contrasena = value,
                        ), 
                      ),
                      SizedBox(height: PantallaConstantes.sepaadorPequeno,),
                      TextButton(
                        onPressed: () => Dialogo.olvidasteContrasena(context), 
                        child: Text("¿Olvidaste tu contraseña?")
                      ),
                      SizedBox(height: PantallaConstantes.separador),
                      ElevatedButton(
                        style: Customstyles.botonesDefecto,
                        onPressed: () async{
                          final userCredential; 
                          if(kIsWeb){
                            userCredential = await UserController.signInWithGoogleWeb();
                          }else{
                            userCredential = await UserController.loginGoogle();
                          }
                          _iniciarGoogle(userCredential);

                        },
                        child: Text("Acceder con Google")
                      ),
                      SizedBox(height: PantallaConstantes.separador),
                      ElevatedButton(
                        style: Customstyles.botonesDefecto,
                        onPressed: _validarUsuario, 
                        child: Text("Iniciar Sesión")
                      ),
                      SizedBox(height: PantallaConstantes.separador),
                      ElevatedButton(
                        style: Customstyles.botonesDefecto,
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=> const Pantallaregistro()),
                          );
                        },
                        child: Text("Registrarse")
                      ),
                    ],
                  )
                ),
              )
              
            ],
          ),
        ),
      )
    );
  }
}