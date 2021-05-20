main(List<String> args) {
  var alunos = [
    {'nome': 'Gabriel', 'nota': 9.9},
    {'nome': 'Pedro', 'nota': 8.9},
    {'nome': 'Juan', 'nota': 7.9},
    {'nome': 'Luan', 'nota': 6.9},
    {'nome': 'Maria', 'nota': 5.9},
    {'nome': 'Paula', 'nota': 4.9},
  ];

  String Function(Map) pegarApenasOnome = (aluno) => aluno['nome'];
  var nomes = alunos.map(pegarApenasOnome);
  print(nomes);
}
