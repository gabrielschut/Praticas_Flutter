main() {
  var coordenadas = [
    [9.0, 8.3],
    [7.5, 4.2],
    [3, 3.9]
  ];

  for (var coordenada in coordenadas) {
    for (var ponto in coordenada) {
      print(ponto);
    }
  }
}
