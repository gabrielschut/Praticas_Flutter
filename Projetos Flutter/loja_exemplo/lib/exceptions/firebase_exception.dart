class AuthException {

  static const Map<String, String> errors ={
    "EMAIL_EXISTS":"Email já cadastrado",
    "OPERATION_NOT_ALLOWED" :"Operação negada",
    "TOO_MANY_ATTEMPTS_TRY_LATER" :"Excedeu o número de tentativas, tente mais tarde",
    "EMAIL_NOT_FOUND" :"E-mail não cadastrado",
    "INVALID_PASSWORD" :"Senha inconrreta",
    "USER_DISABLED" :"Usuário desabilitado",
  };

  final String key;

  const AuthException(this.key);

  @override
  String toString() {
    if(errors.containsKey(key)){
      return errors[key];
    }else{
      print(errors.hashCode);
      return "Erro na autenticação";
    }
  }
}