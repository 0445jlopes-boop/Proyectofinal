import 'package:flutter/material.dart';
import 'package:jessicalopesc1/config/resources/Pantalla_constantes.dart';
import 'package:jessicalopesc1/config/utils/button_styles.dart';
import 'package:jessicalopesc1/models/user.dart';
import 'package:jessicalopesc1/screens/Admin/PantallaGestionInventario.dart';
import 'package:jessicalopesc1/screens/Admin/PantallaGestionPedidos.dart';
import 'package:jessicalopesc1/screens/Admin/PantallaGestionProductos.dart';
import 'package:jessicalopesc1/screens/Admin/PantallaGestionUsuarios.dart';
import 'package:jessicalopesc1/widgets/drawerGeneral.dart';

class Pantallasecundariaadmin extends StatefulWidget {
  const Pantallasecundariaadmin({super.key, required this.user});
  final User user;
  @override
  State<Pantallasecundariaadmin> createState() => _PantallasecundariaadminState();
}

class _PantallasecundariaadminState extends State<Pantallasecundariaadmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(user: widget.user),
      appBar: AppBar(
        backgroundColor:PantallaConstantes.fondoAppBar,
        title: Text("Administrador"),
      ),
      body: Container(
        alignment: AlignmentGeometry.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                style: Customstyles.botonesDefecto,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Pantallagestionusuarios(),
                  ),
                ),
                child: Row(
                  children: [Icon(Icons.person_2), Text("Gestión de Usuarios")],
                ),
              ),
              SizedBox(height: PantallaConstantes.separador,),
              ElevatedButton(
                style: Customstyles.botonesDefecto,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Pantallagestionproductos(),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.shopping_bag),
                    Text("Gestión de Productos"),
                  ],
                ),
              ),
              SizedBox(height: PantallaConstantes.separador,),
              ElevatedButton(
                style: Customstyles.botonesDefecto,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Pantallagestionpedidos(),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.shopping_cart),
                    Text("Gestión de Pedidos"),
                  ],
                ),
              ),
              SizedBox(height: PantallaConstantes.separador,),
              ElevatedButton(
                style: Customstyles.botonesDefecto,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Pantallagestioninventario(),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.inventory),
                    Text("Gestión de Inventario"),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
      
    );
  }
}