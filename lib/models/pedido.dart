import 'dart:math';

import 'package:jessicalopesc1/models/user.dart';

class Pedido {
  int id;
  String descripcion;
  double total;
  String estado; // Pedido / En producción / En reparto / Entregado
  UserOfMyApp user;

  Pedido({
    required this.descripcion,
    required this.total,
    required this.estado,
    required this.user
  }) : id = Random().nextInt(90000) + 10000; // ID aleatorio

  getEstado() {
    return estado;
  }
  getDescripcion() {
    return descripcion;
  }
  getTotal() {
    return total;
  }
  getId() {
    return id;
  }
  getUserOfMyApp(){
    return user;
  }
  
  setEstado(String nuevoEstado) {
    estado = nuevoEstado;
  }
  setDescripcion(String nuevaDescripcion) {
    descripcion = nuevaDescripcion;
  }
  setTotal(double nuevoTotal) {
    total = nuevoTotal;
  }
  setId(int nuevoId) {
    id = nuevoId;
  }
  setUserOfMyApp(UserOfMyApp nuevoUser){
    user = nuevoUser;
  }
  getInfoPedido() {
    return 'Pedido ID: $id\nDescripción: $descripcion\nTotal: \$${total.toStringAsFixed(2)}\nEstado: $estado';
  }

}