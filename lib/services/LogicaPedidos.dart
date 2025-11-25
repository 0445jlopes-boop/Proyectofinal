import 'package:jessicalopesc1/models/pedido.dart';
import 'package:jessicalopesc1/services/LogicaUsuarios.dart';

class LogicaPedidos {
  static final List<Pedido> _pedidos = [
    Pedido(
      descripcion: "Pedido prueba", 
      total: 23.9, 
      estado: "Pedido", 
      user: LogicaUsuarios.getListaUsuarios().first
    )
  ];

  static void agregarPedido(Pedido p) {
    _pedidos.add(p);
  }

  static bool eliminarPedido(Pedido p){
    return _pedidos.remove(p);
  }

  static List<Pedido> getPedidos() {
    return _pedidos;
  }
}