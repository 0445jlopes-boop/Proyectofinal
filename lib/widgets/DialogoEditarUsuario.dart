import 'package:flutter/material.dart';
import 'package:jessicalopesc1/config/resources/Pantalla_constantes.dart';
import 'package:jessicalopesc1/config/utils/Validators.dart';
import 'package:jessicalopesc1/models/user.dart';

class DialogoEditarUsuario {
  final _formKey = GlobalKey<FormState>();
  final List<String> _items = ["Zaragoza","Madrid","Barcelona","Toledo"];


  static void editarUsuario(BuildContext context, UserOfMyApp user){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return 
        SingleChildScrollView(
          child:
            user.isAdmin
            ?
             AlertDialog(
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
                   validator: (value) => Validators.validateEmpty(value),
                   onChanged: (value) =>  = value,
                  ), 
                ),
                ],
              )), 
             )
            :
             AlertDialog(
              
            ),
        );
      }
    );
  }
}