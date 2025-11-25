import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jessicalopesc1/config/resources/Pantalla_constantes.dart';
import 'package:jessicalopesc1/config/utils/button_styles.dart';
import 'package:jessicalopesc1/config/utils/icon_styles.dart';
import 'package:jessicalopesc1/models/producto.dart';
import 'package:jessicalopesc1/models/user.dart';
import 'package:jessicalopesc1/services/LogicaProductos.dart';
import 'package:jessicalopesc1/widgets/DialogoProducto.dart';
import 'package:jessicalopesc1/widgets/drawerGeneral.dart';

class Pantallagestionproductos extends StatefulWidget {
  const Pantallagestionproductos({super.key ,required this.user});
  final UserOfMyApp user;
  @override
  State<Pantallagestionproductos> createState() => _PantallagestionproductosState();
}

class _PantallagestionproductosState extends State<Pantallagestionproductos> {
  List<Producto>productos=Logicaproductos.getListaProducos()!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(user: widget.user),
      appBar: AppBar(
        backgroundColor:PantallaConstantes.fondoAppBar,
        title: Text("Gestión productos"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            productos.isEmpty
                ? const Center(child: Text("No hay productos", style: PantallaConstantes.tamano,))
                : Expanded(
                    flex: 3,
                    child: ListView.builder(
                      itemCount: productos.length,
                      itemBuilder: (context, index) {
                        final producto = productos[index];
                        return Card(
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${producto.nombre}"),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      color: IconStyles.iconoEditar,
                                      onPressed: () async { 
                                        final actualizado = await DialogoEditarProducto().editarAnadirProducto(context, producto);
                                        if (actualizado != null) {
                                          setState(() {});
                                        }
                                      },
                                      icon: Icon(Icons.edit),
                                    ),
                                    SizedBox(
                                      width: PantallaConstantes.sepaadorPequeno,
                                    ),
                                    SizedBox(
                                      width: PantallaConstantes.sepaadorPequeno,
                                    ),
                                    IconButton(
                                      color: IconStyles.iconoEliminar,
                                      onPressed: (){
                                        Logicaproductos.eliminarProducto(producto)
                                        ? showDialog(
                                          context: context, 
                                          builder: (BuildContext context){
                                            return AlertDialog( title: Text("Producto eliminado correctamente"));
                                          }
                                        )
                                        : showDialog(
                                          context: context, 
                                          builder: (BuildContext context){
                                            return AlertDialog( 
                                              title: Text("Error al eliminar el producto"),
                                              actions: [
                                                ElevatedButton(
                                                   onPressed: () => Navigator.pop(context),
                                                    child: Text("Cerrar")
                                                )
                                              ],
                                            );
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
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Precio: ${producto.precio} €"),
                                Text("Stock: ${producto.stock}"),
                                Text("Descripción: ${producto.descripcion}"),
                              ],
                            ),
                            leading: SizedBox(
                              width: 100,
                              height: 120,
                              child: producto.imagen != ""
                                  ? kIsWeb
                                        ? Image.network(
                                            producto.imagen!,
                                            fit: BoxFit.fill,
                                          )
                                        : Image.file(
                                            File(producto.imagen!),
                                            fit: BoxFit.fill,
                                          )
                                  : Image.asset(producto.imagen),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            Column(
              children: [
                ElevatedButton(
                  style: Customstyles.botonesDefecto,
                  onPressed: () async {
                    final nuevo = await DialogoEditarProducto().editarAnadirProducto(context, Producto(nombre:"", imagen: "", descripcion: "", precio: 0 , stock: 0));
                    if (nuevo != null) {
                      setState(() {
                        productos.add(nuevo);
                      });
                    }
                  },
                  child: Text("Nuevo Producto"),
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