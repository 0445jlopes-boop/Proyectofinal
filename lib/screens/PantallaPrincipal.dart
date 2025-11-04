import 'package:flutter/material.dart';
import 'package:jessicalopesc1/controllers/controllersRegistro.dart';
import 'package:jessicalopesc1/screens/PantallaRegistro.dart';
import 'package:jessicalopesc1/screens/PantallaSecundaria.dart';
import 'package:jessicalopesc1/utils/Pantalla_constantes.dart';
import 'package:jessicalopesc1/utils/Validators.dart';
import 'package:jessicalopesc1/utils/button_styles.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {

  String _nombre="";
  String _contrasena ="";
  final _formKey = GlobalKey<FormState>();

  void _validarUsuario(){
    final isFormValid = _formKey.currentState!.validate();
    if(isFormValid){
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (contxt) => Pantallasecundaria(user: Controllersregistro.extraerUsuario(_nombre, _contrasena)))
      );
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