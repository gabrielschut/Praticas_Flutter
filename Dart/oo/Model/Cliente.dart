class Cliente {
  String nome;
  String cpf;

  Cliente({this.nome = "", this.cpf = ""});

  String get getNome {
    return this.nome;
  }

  void set setNome(String novonome) {
    this.nome = novonome;
  }

  String get getCPF {
    return this.cpf;
  }

  void set setCPF(String nwCPF) {
    this.cpf = nwCPF;
  }
}
