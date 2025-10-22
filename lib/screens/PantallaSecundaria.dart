import 'package:flutter/material.dart';
import 'package:jessicalopesc1/models/user.dart';
import 'package:jessicalopesc1/screens/PantallaPrincipal.dart';
import 'package:jessicalopesc1/utils/button_styles.dart';
import 'package:jessicalopesc1/widgets/drawerGeneral.dart';

class Pantallasecundaria extends StatefulWidget {
  const Pantallasecundaria({super.key, required this.user});
  final User user;

  @override
  State<Pantallasecundaria> createState() => _PantallasecundariaState();
}

class _PantallasecundariaState extends State<Pantallasecundaria> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(user: widget.user,),
      appBar: AppBar(
        backgroundColor:Colors.blueGrey,
        title: Text("Pagina Secundaria"),
        
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