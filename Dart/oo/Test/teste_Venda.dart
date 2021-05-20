import '../Model/Venda.dart';
import '../Model/Cliente.dart';
import '../Model/VendaItem.dart';
import '../Model/Produto.dart';

main(List<String> args) {
  var venda = Venda(
      cliente: Cliente(nome: "Gabriel", cpf: "123.456.789-55"),
      items: <VendaItem>[
        VendaItem(
            quantidade: 11,
            produto:
                Produto(codigo: 1, nome: "Caneta", preco: 6.00, desconto: 0.5)),
        VendaItem(
          quantidade: 10,
          produto:
              Produto(codigo: 2, nome: "Lapiz", preco: 3.00, desconto: 0.1),
        )
      ]);

  print(venda.valorTotal);
}
