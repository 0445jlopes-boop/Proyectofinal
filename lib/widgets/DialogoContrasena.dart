import 'package:flutter/material.dart';
import 'package:jessicalopesc1/controllers/controllersRegistro.dart';

class DialogoContrasena {
  static final TextEditingController _controladorTextFormField = TextEditingController(); //Esto permite borrar y asignar texto a un Text form field, lo suaremos para motrar la contraseña en el alrt dialog

  static void olvidasteContrasena(BuildContext context){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text("Recuperar contraseña"),
          content:  TextField(
            controller: _controladorTextFormField ,
            decoration: InputDecoration(
              labelText: "Nombre de usuaio",
            ),
          ),
          actions: [
            TextButton(
              onPressed: (){
                _controladorTextFormField.clear();
                Navigator.pop(context);
              }, 
              child: const Text("Cancelar")
            ),
            ElevatedButton(
              onPressed: (){
                final usuario = _controladorTextFormField.text.trim();
                final contrasena = Controllersregistro.extraerContrasena(usuario);
                if(contrasena != null){
                  showDialog(
                    context: context, 
                    builder: (_)  => AlertDialog(
                      title: const Text("Contraseña encontrada:"),
                      content: Text("Su contraseña es: $contrasena"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context), 
                          child: const Text("Cerrar")
                        )
                      ],
                    ) 
                  );
                }else{
                  showDialog(
                    context: context, 
                    builder: (_)  => AlertDialog(
                      title: const Text("Contraseña no encontrada:"),
                      content: Text("Su contraseña no se ha podido enontrar ya que no hay una contraseña asociada al nombre indicado"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context), 
                          child: const Text("Cerrar")
                        )
                      ],
                    ) 
                  );
                }
              },
              child: Text("Recuperar contraseña"),
            )
          ],
        );
      }
    );
  }
}