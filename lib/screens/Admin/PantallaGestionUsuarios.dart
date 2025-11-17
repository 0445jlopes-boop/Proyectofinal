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
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            users.isEmpty
                ? const Center(child: Text("No hay usuarios"))
                : Expanded(
                    flex: 3,
                    child: ListView.builder(
                      itemCount: users.length - 1,
                      itemBuilder: (context, index) {
                        final user = users[index + 1];
                        return Card(
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${user.nombre}"),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      color: IconStyles.iconoEditar,
                                      onPressed: (){
                                        
                                        setState(() {});
                                      },
                                      icon: Icon(Icons.edit),
                                    ),
                                    SizedBox(
                                      width: PantallaConstantes.sepaadorPequeno,
                                    ),
                                    IconButton(
                                      color: IconStyles.iconoBloqueado,
                                      onPressed: null,
                                      icon: Icon(Icons.block),
                                    ),
                                    SizedBox(
                                      width: PantallaConstantes.sepaadorPequeno,
                                    ),
                                    IconButton(
                                      color: IconStyles.iconoEliminar,
                                      onPressed: (){
                                        LogicaUsuarios.eliminarUsuario(user)
                                        ? showDialog(
                                          context: context, 
                                          builder: (BuildContext context){
                                            return AlertDialog( title: Text("Usuario eliminado correctamente"));
                                          }
                                        )
                                        : showDialog(
                                          context: context, 
                                          builder: (BuildContext context){
                                            return AlertDialog( title: Text("Error al eliminar el suruario"));
                                          }
                                        );
                                        setState(() {});
                                      },
                                      icon: Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            leading: Image.asset(users[index].getImagen()),
                          ),
                        );
                      },
                    ),
                  ),
            Column(
              children: [
                ElevatedButton(
                  style: Customstyles.botonesDefecto,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Pantallaregistroadmin(),
                      ),
                    );
                  },
                  child: Text("Nuevo usuario"),
                ),
                SizedBox(height: PantallaConstantes.sepaadorPequeno),
                ElevatedButton(
                  style: Customstyles.botonesDefecto,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Volver"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
