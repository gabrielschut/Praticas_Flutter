main(List<String> args) {
  FuncTeste(2);

  var somacom10 = FuncTeste(10);
  print(somacom10(2));
  print(somacom10(6));
}

int Function(int) FuncTeste(int a) {
  int c = 0;
  return (int b) {
    return a + b + c;
  };
}
