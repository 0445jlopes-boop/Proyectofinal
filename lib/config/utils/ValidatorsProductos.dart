class ValidatorsProductos {
  static String? validateEmpty(String? value){
    if(value == null || value.isEmpty || value != ""){
      return 'El campo está vacío';
    }
    return null;
  }
  static String? validateStock(int? value){
    if(value == null && value! < 0){
      return 'El campo está vacío o no es un número entero positivo';
    }
    return null;
  }
  static String? validatePrecio(double? value){
    if(value == null){
      return "El precio está vacío";
    }
    return null;
  }
  
}