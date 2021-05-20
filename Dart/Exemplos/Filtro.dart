main(List<String> args) {
  List<double> notas = [3.5, 7.5, 6.9, 8.2, 9.9];

  bool Function(double) notasBoasFN = (double nota) => nota >= 7;

  var notasBoas = notas.where(notasBoasFN);
  print(notasBoas);
}
