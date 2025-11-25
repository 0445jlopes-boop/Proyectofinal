import 'package:flutter/material.dart';
import 'package:jessicalopesc1/config/resources/Pantalla_constantes.dart';
import 'package:jessicalopesc1/config/utils/button_styles.dart';
import 'package:jessicalopesc1/config/utils/icon_styles.dart';
import 'package:jessicalopesc1/models/pedido.dart';
import 'package:jessicalopesc1/models/user.dart';
import 'package:jessicalopesc1/services/LogicaPedidos.dart';
import 'package:jessicalopesc1/widgets/DialogoPedido.dart';
import 'package:jessicalopesc1/widgets/DialogoProducto.dart';
import 'package:jessicalopesc1/widgets/drawerGeneral.dart';

class Pantallagestionpedidos extends StatefulWidget {
  const Pantallagestionpedidos({super.key, required this.user});
  final UserOfMyApp user;
  @override
  State<Pantallagestionpedidos> createState() => _PantallagestionpedidosState();
}

class _PantallagestionpedidosState extends State<Pantallagestionpedidos> {
  @override
  Widget build(BuildContext context) {
    final pedidos = LogicaPedidos.getPedidos();

    return Scaffold(
      drawer: CustomDrawer(user: widget.user),
      appBar: AppBar(
        backgroundColor: PantallaConstantes.fondoAppBar,
        title: Text("Gestión Pedidos"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            pedidos.isEmpty
                ? const Center(
                    child: Text(
                      "No hay pedidos",
                      style: PantallaConstantes.tamano,
                    ),
                  )
                : Expanded(
                    flex: 3,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: pedidos.length,
                      itemBuilder: (context, index) {
                        final Pedido p = pedidos[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Pedido #${p.id} del comprador ${p.user.nombre}",
                                  style: PantallaConstantes.negria,
                                ),
                               Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      color: IconStyles.iconoEditar,
                                      onPressed: () async {
                                        final nuevoEstado = await Dialogopedido.editarEstado(context, p);
                                        if (nuevoEstado != null) {
                                          setState(() {
                                            p.setEstado(nuevoEstado);
                                          });
                                        }
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                    ],
                                )
                              ]
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(p.descripcion),
                                  const SizedBox(height: 6),
                                  Text(
                                    "Total: ${p.total.toStringAsFixed(2)} €",
                                  ),
                                  Text("Estado: ${p.estado}"),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            Column(
              children: [
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
