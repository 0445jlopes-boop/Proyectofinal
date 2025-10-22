import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jessicalopesc1/controllers/controllersRegistro.dart';
import 'package:jessicalopesc1/models/CameraGalleryService.dart';
import 'package:jessicalopesc1/models/user.dart';
import 'package:jessicalopesc1/screens/PantallaPrincipal.dart';
import 'package:jessicalopesc1/screens/PantallaSecundaria.dart';
import 'package:jessicalopesc1/services/LogicaUsuarios.dart';
import 'package:jessicalopesc1/utils/button_styles.dart';

class Pantallaregistro extends StatefulWidget {
  const Pantallaregistro({super.key});

  @override
  State<Pantallaregistro> createState() => _PantallaregistroState();
}


class _PantallaregistroState extends State<Pantallaregistro> {

  
  String? _opcionTrato = 'Sr';
  String? photoPath;
  bool isChecked = false;
  String _nombre="";
  String _contrasena ="";
  String _contrasena2 ="";
  int _edad=0;
  String _nacimiento="";

  void _validarUsuario(){
    if(isChecked){
      if(_nombre == "" || _nombre.isEmpty){
        const snackBar = SnackBar(content: Text('Nombre no valido'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }else if(_contrasena == "" || _contrasena.isEmpty){
        const snackBar = SnackBar(content: Text('Contraseña no valida'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }else if(_contrasena2 == "" || _contrasena2.isEmpty){
        const snackBar = SnackBar(content: Text('Contraseña de repetición no valida'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }else if(_contrasena != _contrasena2){
        const snackBar = SnackBar(content: Text('Las contraseñas no coinciden'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }else if(_edad == 0 ){
        const snackBar = SnackBar(content: Text('Edad no válida'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }else if(_nacimiento == "" || _nacimiento.isEmpty){
        const snackBar = SnackBar(content: Text('Lugar de nacimineto no valido'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }else if(photoPath == "" || photoPath!.isEmpty){
        const snackBar = SnackBar(content: Text('Imagen no valida'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      else{
        if(Controllersregistro.userExiste(_nombre, _contrasena)){
          const snackBar = SnackBar(content: Text('El usuario introducido ya existe'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          User usuario =User(trato: _opcionTrato.toString(), nombre: _nombre, contrasena: _contrasena, edad: _edad, nacimiento: _nacimiento, imagen: photoPath!);
          LogicaUsuarios.anadirUsuario(usuario);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=> Pantallasecundaria(user: usuario,)),
          );
        }
      }
    }else{
    const snackBar = SnackBar(content: Text('Debe aceptar los términos y las condiciones'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
     
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.blueGrey,
        title: Text("Registros"),
      ),
      body: Container(
        alignment: AlignmentGeometry.center,
        child: SingleChildScrollView(
          child:Column(
            children: [
              SizedBox(height: 20,),
              SizedBox(
                width: 400,
                child: Row(
                  children: [
                    Text("Trato"),
                    SizedBox(width: 5,),
                    Text("Sr."),
                    Radio(
                      value: "Sr",
                      groupValue: _opcionTrato,
                      onChanged: (value) {
                        setState(() {
                          _opcionTrato = value;
                        });
                      },
                    ),
                    SizedBox(width: 5,),
                    Text("Sra."),
                    Radio(
                      value: "Sra",
                      groupValue: _opcionTrato,
                      onChanged: (value) {
                        setState(() {
                          _opcionTrato = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
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
              SizedBox(height: 20,),
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
              SizedBox(
                width: 400,
                child:TextFormField(
                decoration: const InputDecoration(
                    labelText: "Repita la contraseña",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _contrasena2= value,
                ), 
              ),
              SizedBox(height: 20,),
              SizedBox(
                height: 350,
                child: photoPath != null
                  ? Image(
                      image: FileImage(File(photoPath!)),
                      fit: BoxFit.fill,
                    )
                  : Container(),
              ),
              SizedBox(
                width: 400,
                child: Row(
                  children: [
                    Text("Añadir imagen"),
                    SizedBox(width: 20,),
                    ElevatedButton(
                      child: const Icon(Icons.image),
                      onPressed: () async {
                        final path = await CameraGalleryService().selectPhoto();
                        if (path == null) return;
                        setState(() {
                          photoPath = path;
                        });
                      }
                    ),
                    ElevatedButton(
                      child: const Icon(Icons.camera_alt),
                      onPressed: () async {
                        final path = await CameraGalleryService().takePhoto();
                        if (path == null) return;
                        setState(() {
                          photoPath = path;
                        });
                      }
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: 400,
                child:TextFormField(
                decoration: const InputDecoration(
                    labelText: "Edad",
                    border: OutlineInputBorder(),
                  ),
                  onChanged:(value) => _edad = int.parse(value),
                ), 
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: 400,
                child:TextFormField(
                decoration: const InputDecoration(
                    labelText: "Lugar de nacimiento",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _nacimiento = value,
                ), 
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: 400,
                child: Row(
                  children: [
                    Text("Aceptar terminos y condiciones"),
                    Checkbox(
                      value: isChecked, 
                      onChanged: (bool? value){
                        setState(() {
                          isChecked = value!;
                        });
                      }
                      )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: 400,
                child: Column(
                  children: [
                    ElevatedButton(
                      style: Customstyles.botonesDefecto,
                      onPressed: _validarUsuario,       
                      child: Text("Aceptar"),
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(
                      style: Customstyles.botonesDefecto,
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=> const PantallaPrincipal()),
                        );
                      }, 
                      child: Text("Cancelar")
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ) ,
    );
  }
}