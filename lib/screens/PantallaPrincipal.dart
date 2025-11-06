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
  final TextEditingController _controladorTextFormField = TextEditingController(); //Esto permite borrar y asignar texto a un Text form field, lo suaremos para motrar la contraseña en el alrt dialog


  void _validarUsuario(){
    final isFormValid = _formKey.currentState!.validate();
    if(isFormValid && Controllersregistro.userExiste(_nombre, _contrasena)){
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (contxt) => Pantallasecundaria(user: Controllersregistro.extraerUsuario(_nombre, _contrasena)))
      );
    }else{
      const snackBar = SnackBar(content: Text('Este usuario no existe'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _olvidasteContrasena(BuildContext context){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text("Recuperar contraseña"),
          content:  TextField(
            controller: _controladorTextFormField ,
            decoration: InputDecoration(
              labelText: "Nombre de usuaio",
            ),
          ),
          actions: [
            TextButton(
              onPressed: (){
                _controladorTextFormField.clear();
                Navigator.pop(context);
              }, 
              child: const Text("Cancelar")
            ),
            ElevatedButton(
              onPressed: (){
                final usuario = _controladorTextFormField.text.trim();
                final contrasena = Controllersregistro.extraerContrasena(usuario);
                if(contrasena != null){
                  showDialog(
                    context: context, 
                    builder: (_)  => AlertDialog(
                      title: const Text("Contraseña encontrada:"),
                      content: Text("Su contraseña es: $contrasena"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context), 
                          child: const Text("Cerrar")
                        )
                      ],
                    ) 
                  );
                }else{
                  showDialog(
                    context: context, 
                    builder: (_)  => AlertDialog(
                      title: const Text("Contraseña no encontrada:"),
                      content: Text("Su contraseña no se ha podido enontrar ya que no hay una contraseña asociada al nombre indicado"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context), 
                          child: const Text("Cerrar")
                        )
                      ],
                    ) 
                  );
                }
              },
              child: Text("Recuperar contraseña"),
            )
          ],
        );
      }
    );
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
                        onPressed: () => _olvidasteContrasena(context) , 
                        child: Text("¿Olvidaste tu contraseña?")
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