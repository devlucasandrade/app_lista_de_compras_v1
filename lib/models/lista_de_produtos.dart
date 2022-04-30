import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:lista_de_compras2/data/lista_mocada.dart';
import 'package:lista_de_compras2/models/produto.dart';

class ListaDeProdutos with ChangeNotifier {
  final List<Produtos> _itens = [];

  List<Produtos> get itens => [..._itens];

  void salvarProdutos(Map<String, Object> produto) {
    bool temId = produto['id'] != null;

    final produtos = Produtos(
      id: temId ? produto['id'] as String : Random().nextDouble().toString(),
      nome: produto['nome'] as String,
      quantidade: produto['quantidade'] as int,
      preco: produto['preco'] as double,
    );

    if (temId) {
      atualizarProdutos(produtos);
    } else {
      adicionarProdutos(produtos);
    }
  }

  void adicionarProdutos(Produtos produtos) {
    _itens.add(produtos);
    notifyListeners();
  }

  void atualizarProdutos(Produtos produtos) {
    int index = _itens.indexWhere((p) => p.id == produtos.id);

    if (index >= 0) {
      _itens[index] = produtos;

      notifyListeners();
    }
  }

  void removerProdutos(Produtos produtos) {
    int index = _itens.indexWhere((p) => p.id == produtos.id);

    if (index >= 0) {
      _itens.removeWhere((p) => p.id == produtos.id);
      notifyListeners();
    }
  }

  int get count {
    return _itens.length;
  }

  Produtos byIndex(int i) {
    return _itens.elementAt(i);
  }
}
