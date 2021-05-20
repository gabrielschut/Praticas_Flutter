class Produto {
  int codigo;
  String nome;
  double preco;
  double desconto;

  Produto(
      {this.codigo = 0, this.nome = 'aa', this.preco = 0, this.desconto = 0});

  String toString() {
    return 'Nome: $nome, Preço:$preco, Codigo: $codigo';
  }

  double get precoComDesconto {
    return (1 - this.desconto) * this.preco;
  }
}
