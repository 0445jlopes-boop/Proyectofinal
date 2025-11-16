import 'package:flutter/material.dart';
import 'package:jessicalopesc1/config/resources/Pantalla_constantes.dart';
import 'package:jessicalopesc1/config/utils/button_styles.dart';
import 'package:jessicalopesc1/config/utils/icon_styles.dart';
import 'package:jessicalopesc1/models/user.dart';
import 'package:jessicalopesc1/screens/Admin/PantallaRegistroAdmin.dart';
import 'package:jessicalopesc1/services/LogicaUsuarios.dart';
import 'package:jessicalopesc1/widgets/drawerGeneral.dart';

class Pantallagestionusuarios extends StatefulWidget {
  const Pantallagestionusuarios({super.key, required this.user});
  final UserOfMyApp user;
  @override
  State<Pantallagestionusuarios> createState() => _PantallagestionusuariosState();
}

class _PantallagestionusuariosState extends State<Pantallagestionusuarios> {
  List<UserOfMyApp>users=LogicaUsuarios.getListaUsuarios()!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(user: widget.user),
      appBar: AppBar(
        title: Text("Gestión usuarios"),
      ),
      body: Row(
        children: [
          Column(
            children: [
              Expanded(
                flex: 3,
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index){
                    final user = users[index];
                    return ListTile(
                      title:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${user.nombre}"),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                color: IconStyles.iconoEditar,
                                onPressed: null,
                                icon: Icon(Icons.edit)
                              ),
                              SizedBox( width: PantallaConstantes.sepaadorPequeno),
                              IconButton(
                                color: IconStyles.iconoBloqueado,
                                onPressed: null,
                                icon: Icon(Icons.block)
                              ),
                              SizedBox( width: PantallaConstantes.sepaadorPequeno),
                              IconButton(
                                color: IconStyles.iconoEliminar,
                                onPressed: null,
                                icon: Icon(Icons.delete)
                              ),
                            ],
                          ),
                        ],
                      ),
                      leading: Image.asset(user.imagen),
                    );
                  }
                ),
              )
            ],
          ),
          Column(
            children: [
              ElevatedButton(
                style: Customstyles.botonesDefecto,
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Pantallaregistroadmin()) 
                  );
                }, 
                child: Text("Nuevo usuario")
              ),
              SizedBox(height: PantallaConstantes.sepaadorPequeno),
              ElevatedButton(
                style: Customstyles.botonesDefecto,
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("Volver")
              )
            ],
          )
        ],
      ),
    );
  }
}