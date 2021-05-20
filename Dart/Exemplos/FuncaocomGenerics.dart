Object SegundoElemento(List lista) {
  return lista.length >= 2 ? lista[2] : null;
}

E SegundoElementoV2<E>(List<E> lista) {
  return lista[3];
}

main(List<String> args) {
  var lista = ['uni', 'duni', 'duny', 'te'];
  print(SegundoElemento(lista));
  print(SegundoElementoV2(lista));
}
