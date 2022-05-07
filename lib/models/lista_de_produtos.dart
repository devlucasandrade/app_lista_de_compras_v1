import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:lista_de_compras2/db/db_util.dart';
import 'package:lista_de_compras2/models/produto.dart';
import 'package:sqflite/sqflite.dart';

class ListaDeProdutos extends ChangeNotifier {
  late Database db;
  List<Produtos> _itens = [];

  List<Produtos> get itens => [..._itens];

  Future<void> carregarProdutos() async {
    final dataList = await DBUtil.getData('produtos');
    _itens = dataList
        .map(
          (item) => Produtos(
            id: item['id'],
            nome: item['nome'],
            quantidade: item['quantidade'],
            preco: item['preco'],
          ),
        )
        .toList();
    notifyListeners();
  }

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
    DBUtil.insert('produtos', {
      'id': produtos.id,
      'nome': produtos.nome,
      'quantidade': produtos.quantidade,
      'preco': produtos.preco,
    });
    notifyListeners();
  }

  void atualizarProdutos(Produtos produtos) {
    int index = _itens.indexWhere((p) => p.id == produtos.id);

    if (index >= 0) {
      _itens[index] = produtos;
      DBUtil.update('produtos', {
        'id': produtos.id,
        'nome': produtos.nome,
        'quantidade': produtos.quantidade,
        'preco': produtos.preco,
      });

      notifyListeners();
    }
  }

  void removerProdutos(Produtos produtos) {
    int index = _itens.indexWhere((p) => p.id == produtos.id);

    if (index >= 0) {
      // _itens.removeWhere((p) => p.id == produtos.id);
      DBUtil.delete('produtos', produtos.id);
      _itens.removeAt(index);
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
