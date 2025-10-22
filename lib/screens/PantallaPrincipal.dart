import 'package:flutter/material.dart';
import 'package:jessicalopesc1/controllers/controllersRegistro.dart';
import 'package:jessicalopesc1/screens/PantallaRegistro.dart';
import 'package:jessicalopesc1/screens/PantallaSecundaria.dart';
import 'package:jessicalopesc1/utils/button_styles.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {

  String _nombre="";
  String _contrasena ="";

  void _validarUsuario(){

     if(_nombre == "" || _nombre.isEmpty){
      const snackBar = SnackBar(content: Text('Nombre no valido'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }else if(_contrasena == "" || _contrasena.isEmpty){
      const snackBar = SnackBar(content: Text('Contraseña no valida'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      
    }else{
      if(Controllersregistro.userExiste(_nombre, _contrasena)){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=> Pantallasecundaria(user: Controllersregistro.extraerUsuario(_nombre, _contrasena),)),
        );
      } else {
        const snackBar = SnackBar(content: Text('El usuario introducido no existe'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
       
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.blueGrey,
        title: Text("Pantalla Principal"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        alignment: AlignmentGeometry.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/images/logo.png'),
              SizedBox(height: 20),
              SizedBox(
                width: 400,
                child:TextFormField(
                decoration: const InputDecoration(
                    labelText: "Nombre",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _nombre = value,
                ), 
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 400,
                child:TextFormField(
                decoration: const InputDecoration(
                    labelText: "Contraseña",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _contrasena = value,
                ), 
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                style: Customstyles.botonesDefecto,
                onPressed: _validarUsuario, 
                child: Text("Iniciar Sesión")
              ),
              SizedBox(height: 20,),
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
          ),
        ),
      )
    );
  }
}