List<E> filtrar<E>(List<E> lista, bool Function(E) fn) {
  List<E> listaFiltrada = [];
  for (E elemento in lista) {
    if (fn(elemento)) {
      listaFiltrada.add(elemento);
    }
  }
  return listaFiltrada;
}

main(List<String> args) {
  var notas = [8.3, 4.5, 9.8, 9.7, 5.9, 7.1];

  var boasNotasFN = (double nota) => nota >= 7.5;
  var asNotasBoas = filtrar<double>(notas, boasNotasFN);

  for (var nota in asNotasBoas) {
    print(nota);
  }

  var nomes = ['gabriel', 'ana', 'josé', 'joao', 'leo', 'Guilherme'];
  var nomeGrande = (String nome) => nome.length >= 4;

  var osNomesGrandes = filtrar(nomes, nomeGrande);
  print(osNomesGrandes);
}
