import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:lista_de_compras2/db/db_util.dart';
import 'package:lista_de_compras2/models/compras.dart';
import 'package:lista_de_compras2/models/produto.dart';
import 'package:sqflite/sqflite.dart';

class ListaDeCompras extends ChangeNotifier {
  late Database db;
  List<Compras> _itens = [];

  List<Compras> get itens => [..._itens];

  Future<void> carregarCompras() async {
    final dataList = await DBUtil.getData('compras');
    _itens = dataList
        .map(
          (item) => Compras(
            id: item['id'],
            nome: item['nome'],
            data: item['data'],
            produtoId: item['produtoId'],
          ),
        )
        .toList();
    notifyListeners();
  }

  void salvarListaDeCompras(Map<String, Object> compra) {
    bool temId = compra['id'] != null;

    final compras = Compras(
      id: temId ? compra['id'] as String : Random().nextDouble().toString(),
      nome: compra['nome'] as String,
      data: compra['data'] as DateTime,
      produtoId: compra['produtoId'] as String,
    );

    // if (temId) {
    //   atualizarCompras(compras);
    // } else {
    //   adicionarCompras(compras);
    // }
  }

  void adicionarCompras(Compras compras, Produtos produtos) {
    _itens.add(compras);
    DBUtil.insert('compras', {
      'id': compras.id,
      'nome': compras.nome,
      'data': compras.data,
      'produtoId': produtos.id,
    });
    notifyListeners();
  }
}
