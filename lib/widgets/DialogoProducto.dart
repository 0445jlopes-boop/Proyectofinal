import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jessicalopesc1/config/resources/Pantalla_constantes.dart';
import 'package:jessicalopesc1/config/utils/CameraGalleryService.dart';
import 'package:jessicalopesc1/config/utils/button_styles.dart';
import 'package:jessicalopesc1/models/producto.dart';
import 'package:jessicalopesc1/config/utils/ValidatorsProductos.dart';
import 'package:jessicalopesc1/services/LogicaProductos.dart';

class DialogoEditarProducto {
  final _formKey = GlobalKey<FormState>();

  void _validarProducto(Producto producto, BuildContext context, bool nuevo) {
    final isFormValid = _formKey.currentState!.validate();

    if (isFormValid && (!producto.imagen.isEmpty || producto.imagen != null)) {
      if (nuevo) {
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
  void editarAnadirProdcuto(BuildContext context, Producto producto){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return 
        SingleChildScrollView(
          child:AlertDialog(
              title: Text(
                producto.nombre == ""
                ? "Añadir producto"
                : "Editar producto",
              ),
              content: Form(child: Column(
                children: [
                SizedBox(
                  width: PantallaConstantes.ancho,
                  child:TextFormField(
                    decoration: const InputDecoration(
                       labelText: "Nombre",
                        border: OutlineInputBorder(),
                    ),
                    initialValue: producto.nombre,
                   validator: (value) => ValidatorsProductos.validateEmpty(value),
                   onChanged: (value) {
                      producto.setNombre(value);
                    }
                  ), 
                ),
                SizedBox(height: PantallaConstantes.separador),
                SizedBox(
                  width: PantallaConstantes.ancho,
                  child:TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Descripcion",
                      border: OutlineInputBorder(),
                    ),
                    initialValue: producto.descripcion,
                    validator: (value) => ValidatorsProductos.validateEmpty(value),
                    onChanged: (value) {
                      producto.setDescripcion(value!);
                    },
                  ), 
                ),
                SizedBox(height: PantallaConstantes.separador),
                SizedBox(
                width: 120,
                height: 120,
                child: producto.imagen != ""
                    ? kIsWeb
                        ? Image.network(
                         producto.imagen!,
                          fit: BoxFit.fill
                        )
                        : Image.file(
                          File(producto.imagen!),
                          fit: BoxFit.fill,
                        )
                    : Image.asset(producto.imagen,),
              ),
                SizedBox(
                  width: PantallaConstantes.ancho,
                  child: Row(
                   children: [
                      Text("Añadir imagen"),
                      SizedBox(width: PantallaConstantes.separador,),
                      ElevatedButton(
                        child: const Icon(Icons.image),
                        onPressed: () async {
                          final path = await CameraGalleryService().selectPhoto();
                          if (path == null) return;
                          producto.setImagen(path!);
                        }
                      ),
                      ElevatedButton(
                        child: const Icon(Icons.camera_alt),
                        onPressed: () async {
                          final path = await CameraGalleryService().takePhoto();
                          if (path == null) return;
                          producto.setImagen(path!);
                           
                        }
                      ),
                   ],
                  ),
                ),
                SizedBox(height: PantallaConstantes.separador,),
                SizedBox(
                  width: PantallaConstantes.ancho,
                  child:TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Stock",
                      border: OutlineInputBorder(),
                    ),
                    initialValue: producto.stock.toString(),
                    validator: (value) => ValidatorsProductos.validateStock(int.tryParse(value!)),
                    onChanged:(value) {
                      producto.setStock(int.parse(value));
                    },
                  ), 
                ),
                SizedBox(height: PantallaConstantes.separador),
                SizedBox(
                  width: PantallaConstantes.ancho,
                  child:TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Precio",
                      border: OutlineInputBorder(),
                    ),
                    initialValue: producto.precio.toString(),
                    validator: (value) => ValidatorsProductos.validatePrecio(double.tryParse(value!)),
                    onChanged:(value) {
                      producto.setPrecio(double.parse(value));
                    },
                  ), 
                ),               
                SizedBox(height: PantallaConstantes.separador),
                producto.nombre != ""
                ?
                SizedBox(
                  width: PantallaConstantes.ancho,
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: Customstyles.botonesDefecto,
                        onPressed: (){
                          _validarProducto(producto,context, false);
                        },       
                        child: Text("Aceptar"),
                      )
                    ]
                  )
                )
                      
                :
                SizedBox(
                  width: PantallaConstantes.ancho,
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: Customstyles.botonesDefecto,
                        onPressed: (){
                          _validarProducto(producto,context,true);
                        },       
                        child: Text("Añadir Producto"),
                      )
                    ],
                  ),
                ),
                SizedBox(height: PantallaConstantes.separador),
                      ElevatedButton(
                        style: Customstyles.botonesDefecto,
                        onPressed: (){
                          Navigator.pop(context);
                        }, 
                        child: Text("Cancelar")
                      )
                ],
              )), 
             )
        );
      }
    );
  }



}