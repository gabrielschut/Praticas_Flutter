main(List<String> args) {
  Map<String, double> notas = {
    'Mario': 8.6,
    'Antonio': 7.6,
    'Maria': 8,
  };

  for (var nome in notas.keys) {
    print("$nome e a nota ${notas[nome]}");
  }
}
