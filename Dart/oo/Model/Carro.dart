class Carro {
  final int velocidadeMaxima;
  var _velocidadeAtual = 0;

  Carro(this.velocidadeMaxima);

  String toString() {
    return "$_velocidadeAtual \ $velocidadeMaxima";
  }

  int Acelerar() {
    int velocidadeadicional = 10;
    if (EstaNoLimete()) {
      print('Não vai mais rapido do que já ta');
      return _velocidadeAtual;
    } else {
      return _velocidadeAtual += velocidadeadicional;
    }
  }

  int Frear() {
    int reduzirvelocidade = 10;
    if (_velocidadeAtual - reduzirvelocidade >= 10) {
      return _velocidadeAtual -= reduzirvelocidade;
    } else {
      print('Já ta parado');
      return _velocidadeAtual;
    }
  }

  bool EstaNoLimete() {
    if (_velocidadeAtual == velocidadeMaxima) {
      return true;
    }
    return false;
  }

  int getVelocidadeAtual() {
    return _velocidadeAtual;
  }

  void setVelocidadeAtual(int valor) {
    this._velocidadeAtual = valor;
  }
}
