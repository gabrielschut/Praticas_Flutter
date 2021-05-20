class Data {
  int dia;
  int mes;
  int ano;
//Contrutor nomeado
  Data.com({this.dia = 1, this.mes = 1, this.ano = 1970});
  //Contrutor normal
  Data(this.dia, this.mes, this.ano);

  String retornoFormatado() {
    return "$dia/$mes/$ano";
  }

  String toString() {
    return retornoFormatado();
  }
}

main(List<String> args) {
  Data dataNascimento = Data(28, 03, 1996);
  Data natal = Data.com(dia: 25, mes: 12, ano: 2021);
  print("Eu nasci em $dataNascimento");
  print("O natal vai ser $natal");
}
