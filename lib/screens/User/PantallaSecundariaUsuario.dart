import 'package:flutter/material.dart';
import 'package:jessicalopesc1/models/user.dart';
import 'package:jessicalopesc1/screens/PantallaPrincipal.dart';
import 'package:jessicalopesc1/config/resources/Pantalla_constantes.dart';
import 'package:jessicalopesc1/config/utils/button_styles.dart';
import 'package:jessicalopesc1/widgets/drawerGeneral.dart';

class Pantallasecundariausuario extends StatefulWidget {
  const Pantallasecundariausuario({super.key, required this.user});
  final UserOfMyApp user;

  @override
  State<Pantallasecundariausuario> createState() => _PantallasecundariausuarioState();
}

class _PantallasecundariausuarioState extends State<Pantallasecundariausuario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(user: widget.user,),
      appBar: AppBar(
        backgroundColor:PantallaConstantes.fondoAppBar,
        title: Text("Bienvenido "+widget.user.nombre),
        
      ),
      body: Container(
        alignment: AlignmentGeometry.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                  style: Customstyles.botonesDefecto,
                  onPressed: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context)=> PantallaPrincipal())                  
                    );
                  }, 
                  child: Row(
                    children: [
                      Icon(Icons.home),
                      SizedBox(width: 5,),
                      Text("Pantalla principal")
                    ],
                  )
              ) 
            ]
        ),
        ),
      ), 

    );
  }
}