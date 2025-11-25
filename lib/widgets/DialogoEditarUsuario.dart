import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jessicalopesc1/config/resources/Pantalla_constantes.dart';
import 'package:jessicalopesc1/config/utils/CameraGalleryService.dart';
import 'package:jessicalopesc1/config/utils/ValidatorsUser.dart';
import 'package:jessicalopesc1/config/utils/button_styles.dart';
import 'package:jessicalopesc1/models/user.dart';

class DialogoEditarUsuario {
  Future<UserOfMyApp?> editarUsuario(BuildContext context, UserOfMyApp original) async {
    final _formKey = GlobalKey<FormState>();
    final List<String> _items =["Zaragoza", "Madrid", "Barcelona", "Toledo"];
    UserOfMyApp temp = UserOfMyApp(
      trato: original.trato,
      nombre: original.nombre,
      contrasena: original.contrasena,
      edad: original.edad,
      nacimiento: original.nacimiento,
      imagen: original.imagen,
      isAdmin: original.isAdmin,
      isBlok: original.isBlok
    );

    return showDialog<UserOfMyApp>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Editar Usuario"),
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text("Trato"),
                          const SizedBox(width: 10),
                          const Text("Sr."),
                          Radio(
                            value: "Sr",
                            groupValue: temp.trato,
                            onChanged: (value) {
                              setStateDialog(() => temp.setTrato(value!));
                            },
                          ),
                          const SizedBox(width: 10),
                          const Text("Sra."),
                          Radio(
                            value: "Sra",
                            groupValue: temp.trato,
                            onChanged: (value) {
                              setStateDialog(() => temp.setTrato(value!));
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: PantallaConstantes.sepaadorPequeno),
                      TextFormField(
                        initialValue: temp.nombre,
                        decoration: const InputDecoration(
                          labelText: "Nombre",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            ValidatorsUsers.validateEmpty(value),
                        onChanged: (value) {
                          setStateDialog(() => temp.setNombre(value));
                        },
                      ),
                      const SizedBox(height: PantallaConstantes.sepaadorPequeno),
                      TextFormField(
                        obscureText: true,
                        initialValue: temp.contrasena,
                        decoration: const InputDecoration(
                          labelText: "Contraseña",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            ValidatorsUsers.validateEmpty(value),
                        onChanged: (value) {
                          setStateDialog(() => temp.setContrasena(value));
                        },
                      ),
                      const SizedBox(height: PantallaConstantes.sepaadorPequeno),
                      TextFormField(
                        initialValue: temp.edad.toString(),
                        decoration: const InputDecoration(
                          labelText: "Edad",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            ValidatorsUsers.validateEdad(int.tryParse(value!)),
                        onChanged: (value) {
                          setStateDialog(() =>
                              temp.setEdad(int.tryParse(value) ?? temp.edad));
                        },
                      ),
                      const SizedBox(height: PantallaConstantes.sepaadorPequeno),
                      DropdownButton<String>(
                        value: temp.nacimiento,
                        items: _items.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setStateDialog(() => temp.setNacimiento(value!));
                        },
                      ),
                      const SizedBox(height: PantallaConstantes.sepaadorPequeno),
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: temp.imagen != ""
                            ? kIsWeb
                                ? Image.network(temp.imagen!, fit: BoxFit.fill)
                                : Image.file(File(temp.imagen!), fit: BoxFit.fill)
                            : Image.asset(temp.imagen),
                      ),
                      Row(
                        children: [
                          const Text("Añadir imagen"),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            child: const Icon(Icons.image),
                            onPressed: () async {
                              final path =
                                  await CameraGalleryService().selectPhoto();
                              if (path != null) {
                                setStateDialog(() => temp.setImagen(path));
                              }
                            },
                          ),
                          ElevatedButton(
                            child: const Icon(Icons.camera_alt),
                            onPressed: () async {
                              final path =
                                  await CameraGalleryService().takePhoto();
                              if (path != null) {
                                setStateDialog(() => temp.setImagen(path));
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: PantallaConstantes.sepaadorPequeno),
                      Row(
                        children: [
                          const Text("Usuario administrador"),
                          Checkbox(
                            value: temp.isAdmin,
                            onChanged: (value) {
                              setStateDialog(() =>
                                  temp.setAdmin(value ?? temp.isAdmin));
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context, temp);
                    }
                  },
                  child: const Text("Aceptar"),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
