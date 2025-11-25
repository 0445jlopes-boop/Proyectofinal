import 'package:flutter/material.dart';
import 'package:jessicalopesc1/config/resources/Pantalla_constantes.dart';
import 'package:jessicalopesc1/models/pedido.dart';

class Dialogopedido {
  static Future<String?> editarEstado(BuildContext context, Pedido p) async {
    final List<String> _estados = ["Pedido","Producción","Reparto","Entregado"];

    String estadoTemporal = p.estado;

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text("Editar estado del pedido ${p.id}"),
              content: SizedBox(
                width: PantallaConstantes.ancho,
                child: DropdownButton<String>(
                  value: estadoTemporal,
                  hint: const Text('Seleccione el nuevo estado'),
                  items: _estados.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setStateDialog(() {
                      estadoTemporal = newValue!;
                    });
                  },
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, estadoTemporal);
                  },
                  child: const Text("Cerrar"),
                )
              ],
            );
          },
        );
      },
    );
  }
}
