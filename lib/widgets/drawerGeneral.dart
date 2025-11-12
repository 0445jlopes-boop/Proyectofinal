import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jessicalopesc1/config/resources/Pantalla_constantes.dart';
import 'package:jessicalopesc1/models/user.dart';
import 'package:jessicalopesc1/screens/User/PantallaPerfil.dart';
import 'package:jessicalopesc1/screens/PantallaPrincipal.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key, required this.user});
  final User user;
  @override
  State<CustomDrawer> createState() => __CustomDrawerState();
}

class __CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 65,
            color: PantallaConstantes.fondoAppBar,
            child: DrawerHeader(
              child: Row(
                children: [
                  Text("Menú")
                ],
              )
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Pantalla Principal"),
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => PantallaPrincipal())
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Mi Perfil"),
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => Pantallaperfil(user: widget.user) )
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Salir"),
            onTap: () {
              SystemNavigator.pop();
            },
          )
        ],
      ),
    );
  }
}