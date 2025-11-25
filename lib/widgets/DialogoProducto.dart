import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jessicalopesc1/config/resources/Pantalla_constantes.dart';
import 'package:jessicalopesc1/config/utils/CameraGalleryService.dart';
import 'package:jessicalopesc1/config/utils/button_styles.dart';
import 'package:jessicalopesc1/models/producto.dart';
import 'package:jessicalopesc1/config/utils/ValidatorsProductos.dart';

class DialogoEditarProducto {
  final _formKey = GlobalKey<FormState>();

  Future<Producto?> editarAnadirProducto(BuildContext context, Producto producto) {
    Producto temp = Producto(nombre: producto.nombre, descripcion: producto.descripcion, imagen: producto.imagen, precio: producto.precio, stock: producto.stock,);

    return showDialog<Producto>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return SingleChildScrollView(
              child: AlertDialog(
                title: Text(
                  producto.nombre == ""
                      ? "Añadir producto"
                      : "Editar producto",
                ),
                content: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: PantallaConstantes.ancho,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Nombre",
                            border: OutlineInputBorder(),
                          ),
                          initialValue: temp.nombre,
                          validator: (value) => ValidatorsProductos.validateEmpty(value),
                          onChanged: (value) {
                            setStateDialog(() => temp.setNombre(value));
                          },
                        ),
                      ),
                      SizedBox(height: PantallaConstantes.separador),
                      SizedBox(
                        width: PantallaConstantes.ancho,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Descripcion",
                            border: OutlineInputBorder(),
                          ),
                          initialValue: temp.descripcion,
                          validator: (value) => ValidatorsProductos.validateEmpty(value),
                          onChanged: (value) {
                            setStateDialog(() => temp.setDescripcion(value));
                          },
                        ),
                      ),
                      SizedBox(height: PantallaConstantes.separador),
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: temp.imagen != ""
                            ? (kIsWeb
                                ? Image.network(temp.imagen!, fit: BoxFit.fill)
                                : Image.file(File(temp.imagen!), fit: BoxFit.fill))
                            : Image.asset(temp.imagen),
                      ),
                      SizedBox(
                        width: PantallaConstantes.ancho,
                        child: Row(
                          children: [
                            Text("Añadir imagen"),
                            SizedBox(width: PantallaConstantes.separador),
                            ElevatedButton(
                              child: const Icon(Icons.image),
                              onPressed: () async {
                                final path = await CameraGalleryService().selectPhoto();
                                if (path == null) return;
                                setStateDialog(() => temp.setImagen(path));
                              },
                            ),
                            ElevatedButton(
                              child: const Icon(Icons.camera_alt),
                              onPressed: () async {
                                final path = await CameraGalleryService().takePhoto();
                                if (path == null) return;
                                setStateDialog(() => temp.setImagen(path));
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: PantallaConstantes.separador),
                      SizedBox(
                        width: PantallaConstantes.ancho,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Stock",
                            border: OutlineInputBorder(),
                          ),
                          initialValue: temp.stock.toString(),
                          validator: (value) => ValidatorsProductos.validateStock(int.tryParse(value!)),
                          onChanged: (value) {
                            setStateDialog(() => temp.setStock(int.parse(value)));
                          },
                        ),
                      ),
                      SizedBox(height: PantallaConstantes.separador),
                      SizedBox(
                        width: PantallaConstantes.ancho,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Precio",
                            border: OutlineInputBorder(),
                          ),
                          initialValue: temp.precio.toString(),
                          validator: (value) => ValidatorsProductos.validatePrecio(double.tryParse(value!)),
                          onChanged: (value) {
                            setStateDialog(() => temp.setPrecio(double.parse(value)));
                          },
                        ),
                      ),
                      SizedBox(height: PantallaConstantes.separador),
                      SizedBox(
                        width: PantallaConstantes.ancho,
                        child: ElevatedButton(
                          style: Customstyles.botonesDefecto,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (temp.nombre != producto.nombre) {
                                producto.setNombre(temp.nombre);
                              }
                              if (temp.descripcion != producto.descripcion) {
                                producto.setDescripcion(temp.descripcion);
                              }
                              if (temp.imagen != producto.imagen) {
                                producto.setImagen(temp.imagen);
                              }
                              if (temp.precio != producto.precio) {
                                producto.setPrecio(temp.precio);
                              }
                              if (temp.stock != producto.stock) {
                                producto.setStock(temp.stock);
                              }

                              Navigator.pop(context, producto);
                            }
                          },
                          child: Text(
                            producto.nombre == "" ? "Añadir Producto" : "Aceptar",
                          ),
                        ),
                      ),
                      SizedBox(height: PantallaConstantes.separador),
                      SizedBox(
                        width: PantallaConstantes.ancho,
                        child: ElevatedButton(
                          style: Customstyles.botonesDefecto,
                          onPressed: () => Navigator.pop(context, null),
                          child: Text("Cancelar"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
