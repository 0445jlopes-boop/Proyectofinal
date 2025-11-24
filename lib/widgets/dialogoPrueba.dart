
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jessicalopesc1/config/resources/Pantalla_constantes.dart';
import 'package:jessicalopesc1/config/utils/CameraGalleryService.dart';
import 'package:jessicalopesc1/config/utils/ValidatorsProductos.dart';
import 'package:jessicalopesc1/config/utils/button_styles.dart';
import 'package:jessicalopesc1/models/producto.dart';
import 'package:jessicalopesc1/services/LogicaProductos.dart';

class DialogoPrueba extends StatefulWidget {
  const DialogoPrueba({super.key,required this.producto});
  final Producto producto;


  @override
  State<DialogoPrueba> createState() => _DialogoPruebaState();
}

class _DialogoPruebaState extends State<DialogoPrueba> {
  final _formKey = GlobalKey<FormState>();
  void _validarProducto(Producto producto, BuildContext context, bool nuevo) {
    final isFormValid = _formKey.currentState!.validate();

    if (isFormValid) {
      if (nuevo) {
        Navigator.pop(context);
        Logicaproductos.anadirProducto(producto);
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("HECHO!"),
            content: Text(
              "Se ha añadido el producto correctamente",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cerrar"),
              ),
            ],
          ),
        );
      } else {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("HECHO!"),
            content: Text(
              "Las modificaciones en el producto se han realizado correctamente",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cerrar"),
              ),
            ],
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Los campos introducidos no son correctos"),
          content: Text(
            "Revise los datos que ha modificado y asegúrese de que no los ha dejado vacíos o ha introducido tipos de datos no correspondientes",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cerrar"),
            ),
          ],
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: Text(
          widget.producto.nombre == "" ? "Añadir producto" : "Editar producto",
        ),
        content: Form(
          child: Column(
            children: [
              SizedBox(
                width: PantallaConstantes.ancho,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Nombre",
                    border: OutlineInputBorder(),
                  ),
                  initialValue: widget.producto.nombre,
                  validator: (value) =>
                      ValidatorsProductos.validateEmpty(value),
                  onChanged: (value) {
                    widget.producto.setNombre(value);
                  },
                ),
              ),
              SizedBox(height: PantallaConstantes.separador),
              SizedBox(
                width: PantallaConstantes.ancho,
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Descripcion",
                    border: OutlineInputBorder(),
                  ),
                  initialValue: widget.producto.descripcion,
                  validator: (value) =>
                      ValidatorsProductos.validateEmpty(value),
                  onChanged: (value) {
                    widget.producto.setDescripcion(value!);
                  },
                ),
              ),
              SizedBox(height: PantallaConstantes.separador),
              SizedBox(
                width: 120,
                height: 120,
                child: widget.producto.imagen != ""
                    ? kIsWeb
                        ? Image.network(
                          widget.producto.imagen!,
                          fit: BoxFit.fill
                        )
                        : Image.file(
                          File(widget.producto.imagen!),
                          fit: BoxFit.fill,
                        )
                    : Image.asset(widget.producto.imagen,),
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
                        setState(() {
                          widget.producto.setImagen(path!);
                        });
                      },
                    ),
                    ElevatedButton(
                      child: const Icon(Icons.camera_alt),
                      onPressed: () async {
                        final path = await CameraGalleryService().takePhoto();
                        if (path == null) return;
                        setState(() {widget.producto.setImagen(path!);});
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
                  initialValue: widget.producto.stock.toString(),
                  validator: (value) =>
                      ValidatorsProductos.validateStock(int.tryParse(value!)),
                  onChanged: (value) {
                    widget.producto.setStock(int.parse(value));
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
                  initialValue: widget.producto.precio.toString(),
                  validator: (value) => ValidatorsProductos.validatePrecio(
                    double.tryParse(value!),
                  ),
                  onChanged: (value) {
                    widget.producto.setPrecio(double.parse(value));
                  },
                ),
              ),
              SizedBox(height: PantallaConstantes.separador),
              widget.producto.nombre != ""
                  ? SizedBox(
                      width: PantallaConstantes.ancho,
                      child: Column(
                        children: [
                          ElevatedButton(
                            style: Customstyles.botonesDefecto,
                            onPressed: () {
                              _validarProducto(widget.producto, context, false);
                            },
                            child: Text("Aceptar"),
                          ),
                          SizedBox(height: PantallaConstantes.separador),
                          ElevatedButton(
                            style: Customstyles.botonesDefecto,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancelar"),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      width: PantallaConstantes.ancho,
                      child: Column(
                        children: [
                          ElevatedButton(
                            style: Customstyles.botonesDefecto,
                            onPressed: () {
                              _validarProducto(widget.producto, context, true);
                            },
                            child: Text("Añadir Producto"),
                          ),
                          SizedBox(height: PantallaConstantes.separador),
                          ElevatedButton(
                            style: Customstyles.botonesDefecto,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancelar"),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
