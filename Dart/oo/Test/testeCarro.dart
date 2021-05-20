import '../Model/Carro.dart';

main(List<String> args) {
  var c1 = Carro(150);

  c1.Frear();

  //for (int i = 0; i <= 15; i++) {
  //c1.Acelerar();
  //}

  print(c1.Acelerar());
  c1.setVelocidadeAtual(500);
  print(c1.getVelocidadeAtual());
}
