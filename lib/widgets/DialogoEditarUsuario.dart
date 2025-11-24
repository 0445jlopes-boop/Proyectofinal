import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jessicalopesc1/config/resources/Pantalla_constantes.dart';
import 'package:jessicalopesc1/config/utils/CameraGalleryService.dart';
import 'package:jessicalopesc1/config/utils/ValidatorsUser.dart';
import 'package:jessicalopesc1/config/utils/button_styles.dart';
import 'package:jessicalopesc1/models/user.dart';

class DialogoEditarUsuario {
  final _formKey = GlobalKey<FormState>();
  final List<String>? _items = ["Zaragoza","Madrid","Barcelona","Toledo"];
  
  void _validarUsuario(UserOfMyApp user, BuildContext context) {
    final isFormValid = _formKey.currentState!.validate();

    if (isFormValid) {
      if (user.isAdmin) {
        user.imagen = "assets/images/logo.png";
      }
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("HECHO!"),
          content: Text(
            "Las modificaciones en el usuario se han realizado correctamente",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cerrar"),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Los campos introducidos no son correctos"),
          content: Text(
            "Revise los datos que ha modificado y asegúrese de que no los ha dejado vacíos o ha introducido tipos de datos no correspondientes",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cerrar"),
            ),
          ],
        ),
      );
    }
  }

  void editarUsuario(BuildContext context, UserOfMyApp user){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return 
        SingleChildScrollView(
          child:AlertDialog(
              title: const Text("Editar Usuario"),
              content: Form(child: Column(
                children: [
                  Row(
                    children: [
                      Text("Trato"),
                      SizedBox(width: PantallaConstantes.sepaadorPequeno,),
                          Text("Sr."),
                          Radio(
                            value: "Sr",
                            groupValue: user.trato,
                            onChanged: (value) {
                              user.setTrato(value!);
                            },
                          ),
                          SizedBox(width: 5,),
                          Text("Sra."),
                          Radio(

                            value: "Sra",
                            groupValue: user.trato,
                            onChanged: (value) {
                             user.setTrato(value!);
                            },
                         ),
                    ],
                  ),
                  SizedBox(height: PantallaConstantes.separador,),
                SizedBox(
                  width: PantallaConstantes.ancho,
                  child:TextFormField(
                    decoration: const InputDecoration(
                       labelText: "Nombre",
                        border: OutlineInputBorder(),
                    ),
                    initialValue: user.nombre,
                   validator: (value) => ValidatorsUsers.validateEmpty(value),
                   onChanged: (value) {
                      user.setNombre(value!);
                    }
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
                    initialValue: user.contrasena,
                    validator: (value) => ValidatorsUsers.validateEmpty(value),
                    onChanged: (value) {
                      user.setContrasena(value!);
                    },
                  ), 
                ),
                SizedBox(height: PantallaConstantes.separador),
                SizedBox(
                width: 120,
                height: 120,
                child:user.imagen != ""
                    ? kIsWeb
                        ? Image.network(
                          user.imagen!,
                          fit: BoxFit.fill
                        )
                        : Image.file(
                          File(user.imagen!),
                          fit: BoxFit.fill,
                        )
                    : Image.asset(user.imagen,),
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
                          user.setImagen(path!);
                        }
                      ),
                      ElevatedButton(
                        child: const Icon(Icons.camera_alt),
                        onPressed: () async {
                          final path = await CameraGalleryService().takePhoto();
                          if (path == null) return;
                          user.setImagen(path!);
                           
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
                    initialValue: user.edad.toString(),
                    validator: (value) => ValidatorsUsers.validateEdad(int.tryParse(value!)),
                    onChanged:(value) {
                      user.setEdad(int.parse(value));
                    },
                  ), 
                ),
                SizedBox(height: PantallaConstantes.separador),
                SizedBox(
                  width: PantallaConstantes.ancho,
                  child: DropdownButton<String>(
                    value: user.nacimiento,
                    hint:  Text('Seleccione el lugar de nacimiento'),
                    items: _items!.map((item){
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),  
                      );
                    } ).toList(),
                    onChanged: (String? newValue){
                      user.setNacimiento(newValue!);
                    }
                  )
                ),
                SizedBox(height: PantallaConstantes.separador),
                SizedBox(
                  width: PantallaConstantes.ancho,
                  child: Row(
                    children: [
                      Text("Usuario administrador"),
                      Checkbox(
                        value: user.isAdmin, 
                        onChanged: (bool? value){
                          user.setAdmin(value!);
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
                        onPressed: (){
                          _validarUsuario(user,context);
                        },       
                        child: Text("Aceptar"),
                      ),
                      SizedBox(height: PantallaConstantes.separador),
                      ElevatedButton(
                        style: Customstyles.botonesDefecto,
                        onPressed: (){
                          Navigator.pop(context);
                        }, 
                        child: Text("Cancelar")
                      )
                    ],
                  ),
                )
                ],
              )), 
             )
        );
      }
    );
  }
}