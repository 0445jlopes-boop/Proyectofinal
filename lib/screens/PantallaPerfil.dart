import 'package:flutter/material.dart';
import 'package:jessicalopesc1/models/user.dart';

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
        backgroundColor: Colors.blueGrey,
        title: Text("Perfil"),
      ),
      body: Container(
        alignment: AlignmentGeometry.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 500,
                child: Column(
                  children: [
                    Text("Su trato es: "+widget.user.trato),
                    SizedBox(height: 5,),
                    Text("Su nombre es: "+widget.user.nombre),
                    SizedBox(height: 5,),
                    Text("Su contraseña es: "+widget.user.contrasena),
                    SizedBox(height: 5,),
                    Image.asset(widget.user.imagen),
                    SizedBox(height: 5,),
                    Text("Su edad es: "+widget.user.edad.toString()),
                    SizedBox(height: 5,),
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