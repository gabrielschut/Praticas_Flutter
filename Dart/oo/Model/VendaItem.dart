import 'Produto.dart';

class VendaItem {
  Produto produto;
  int quantidade;
  double _preco = 0;

  VendaItem({required this.produto, this.quantidade = 1});

  double get preco {
    if (Produto != null) {
      _preco = produto.precoComDesconto;
    }
    return _preco;
  }

  void set preco(double novopreco) {
    if (novopreco > 0) {
      this._preco = novopreco;
    }
  }
}
