
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jessicalopesc1/controllers/controllersRegistro.dart';
import 'package:jessicalopesc1/utils/CameraGalleryService.dart';
import 'package:jessicalopesc1/models/user.dart';
import 'package:jessicalopesc1/screens/PantallaPrincipal.dart';
import 'package:jessicalopesc1/screens/PantallaSecundaria.dart';
import 'package:jessicalopesc1/services/LogicaUsuarios.dart';
import 'package:jessicalopesc1/utils/Pantalla_constantes.dart';
import 'package:jessicalopesc1/utils/Validators.dart';
import 'package:jessicalopesc1/utils/button_styles.dart';

class Pantallaregistro extends StatefulWidget {
  const Pantallaregistro({super.key});

  @override
  State<Pantallaregistro> createState() => _PantallaregistroState();
}


class _PantallaregistroState extends State<Pantallaregistro> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _items = ["Zaragoza","Madrid","Barcelona","Toledo"];
  String? _opcionTrato = 'Sr';
  String photoPath ="";
  bool isChecked = false;
  String _nombre="";
  String _contrasena ="";
  String _contrasena2 ="";
  int _edad=0;
  String _nacimiento ="Zaragoza";

  void _validarUsuario(){
    final isFormValid = _formKey.currentState!.validate();
    if(isFormValid){
      if(isChecked){
        if(photoPath != "" && photoPath != null && photoPath.isEmpty!){
          if(Controllersregistro.userExiste(_nombre, _contrasena)){
            const snackBar = SnackBar(content: Text('El usuario introducido ya existe'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }else {
            User usuario =User(trato: _opcionTrato.toString(), nombre: _nombre, contrasena: _contrasena, edad: _edad, nacimiento: _nacimiento, imagen: photoPath!);
            LogicaUsuarios.anadirUsuario(usuario);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=> Pantallasecundaria(user: usuario,)),
              );
            }      
        }else{
          const snackBar = SnackBar(content: Text('Debe añadir una imagen'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } 
      }else{
        const snackBar = SnackBar(content: Text('Debe aceptar los términos y las condiciones'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }      
    }     
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:PantallaConstantes.fondoAppBar,
        title: Text("Registros"),
      ),
      body: Container(
        alignment: AlignmentGeometry.center,
        child: SingleChildScrollView(
          child:Form(
            key: _formKey,
            child:Column(
              children: [
                SizedBox(height: PantallaConstantes.separador),
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
                SizedBox(height: PantallaConstantes.separador,),
                SizedBox(
                  width: PantallaConstantes.ancho,
                  child:TextFormField(
                    decoration: const InputDecoration(
                       labelText: "Nombre",
                        border: OutlineInputBorder(),
                    ),
                   validator: (value) => Validators.validateEmpty(value),
                   onChanged: (value) => _nombre = value,
                  ), 
                ),
                SizedBox(height: PantallaConstantes.separador),
                SizedBox(
                  width: PantallaConstantes.ancho,
                  child:TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Contraseña",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => Validators.validateEmpty(value),
                    onChanged: (value) => _contrasena = value,
                  ), 
                ),
                SizedBox(height: PantallaConstantes.separador),
                SizedBox(
                  width: PantallaConstantes.ancho,
                  child:TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Repita la contraseña",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>  Validators.validatePassword(value,_contrasena),
                    onChanged: (value) => _contrasena2= value,
                  ), 
                ),
                SizedBox(height: PantallaConstantes.separador),
                SizedBox(
                  child: photoPath != ""
                    ? Image(
                        image: FileImage(File(photoPath)),
                        fit: BoxFit.fill,
                      )
                    : SizedBox(
                        height: PantallaConstantes.sepaadorPequeno,
                        child: Container(),
                      )
                ),
                SizedBox(
                  width: PantallaConstantes.ancho,
                  child: Row(
                   children: [
                      Text("Añadir imagen"),
                      SizedBox(width: PantallaConstantes.separador,),
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
                SizedBox(height: PantallaConstantes.separador,),
                SizedBox(
                  width: PantallaConstantes.ancho,
                  child:TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Edad",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => Validators.validateEdad(int.tryParse(value!)),
                    onChanged:(value) => _edad = int.parse(value),
                  ), 
                ),
                SizedBox(height: PantallaConstantes.separador),
                SizedBox(
                  width: PantallaConstantes.ancho,
                  child: DropdownButton<String>(
                    value: _nacimiento,
                    hint:  Text('Seleccione el lugar de nacimiento'),
                    items: _items.map((item){
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),  
                      );
                    } ).toList(),
                    onChanged: (String? newValue){
                      setState(() {
                        _nacimiento= newValue!;
                      });
                    }
                  )
                ),
                SizedBox(height: PantallaConstantes.separador),
                SizedBox(
                  width: PantallaConstantes.ancho,
                  child: Row(
                    children: [
                      Text("Aceptar terminos y condiciones"),
                      Checkbox(
                        value: isChecked, 
                        onChanged: (bool? value){
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(height: PantallaConstantes.separador),
                SizedBox(
                  width: PantallaConstantes.ancho,
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: Customstyles.botonesDefecto,
                        onPressed: _validarUsuario,       
                        child: Text("Aceptar"),
                      ),
                      SizedBox(height: PantallaConstantes.separador),
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
              ]              
            )
          ),
        ),
      ) ,
    );
  }
}