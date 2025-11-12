import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jessicalopesc1/models/user.dart';
import 'package:jessicalopesc1/config/resources/Pantalla_constantes.dart';

class Pantallaperfil extends StatefulWidget {
  const Pantallaperfil({super.key, required this.user});
  final User user;

  @override
  State<Pantallaperfil> createState() => _PantallaperfilState();
}

class _PantallaperfilState extends State<Pantallaperfil> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PantallaConstantes.fondoAppBar,
        title: Text("Perfil"),
      ),
      body: Container(
        alignment: AlignmentGeometry.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: PantallaConstantes.ancho,
                child: Column(
                  children: [
                    Text("Su trato es: "+widget.user.trato),
                    SizedBox(height: PantallaConstantes.sepaadorPequeno,),
                    Text("Su nombre es: "+widget.user.nombre),
                    SizedBox(height: PantallaConstantes.sepaadorPequeno,),
                    Text("Su contraseña es: "+widget.user.contrasena),
                    SizedBox(height: PantallaConstantes.sepaadorPequeno,),
                    widget.user.imagen != null ?
                     Center(
                      child: SizedBox(
                        height: 350,
                        child: kIsWeb
                          ? Image.network(
                            widget.user.imagen!,
                            width: 200,
                            height: 100,
                            fit: BoxFit.fill,
                          )
                          : Image.file(
                            File(widget.user.imagen!),
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                      ) ,
                     ): SizedBox(),
                    SizedBox(height: PantallaConstantes.sepaadorPequeno,),
                    Text("Su edad es: "+widget.user.edad.toString()),
                    SizedBox(height: PantallaConstantes.sepaadorPequeno,),
                    Text("Su lugar de nacimiento es: "+widget.user.nacimiento),
                  ],
                ),
              )
            ]
          ),
        )
      ),
    );
  }
}