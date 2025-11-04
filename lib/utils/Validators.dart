class Validators {
  static String? validateEmpty(String? value){
    if(value == null || value.isEmpty){
      return 'El campo está vacío';
    }
    return null;
  }
  static String? validatePassword(String? value1, String? value2){
    if(value1 != value2 && (value1 == null || value1.isEmpty)){
      return 'Las contraseñas no coinciden';
    }
    return null;
  }
  static String? validateEdad(int? value){
    if(value == null){
      return 'El campo está vacío o no es un número entero';
    }
    return null;
  }
  
}