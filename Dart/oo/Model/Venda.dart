import 'Cliente.dart';
import 'VendaItem.dart';

class Venda {
  Cliente cliente;
  List<VendaItem> items;

  Venda({required this.cliente, required this.items});

  double get valorTotal {
    return items
        .map((item) => item.preco * item.quantidade)
        .reduce((t, a) => t + a);
  }
}
