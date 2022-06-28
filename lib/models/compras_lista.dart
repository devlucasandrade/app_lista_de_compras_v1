import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:lista_de_compras2/db/db_util.dart';
import 'package:lista_de_compras2/models/compras.dart';
import 'package:lista_de_compras2/models/produto.dart';
import 'package:sqflite/sqflite.dart';

class ComprasLista extends ChangeNotifier {
  late Database db;
  List<Compras> _comprasItens = [];

  List<Compras> get comprasItens => [..._comprasItens];

  DateTime data = DateTime.now();

  Future<void> carregarListas() async {
    final dadosLista = await DBUtil.getData('compras');
    _comprasItens = dadosLista
        .map(
          (item) => Compras(
            id: item['id'],
            nome: item['nome'],
            data: item['data'],
            produtos: [
              Produtos(
                id: item['id'],
                nome: item['nome'],
                quantidade: item['quantidade'],
                preco: item['preco'],
              ),
            ],
          ),
        )
        .toList();
    notifyListeners();
  }

  void salvarCompras(Map<String, Object> compra) {
    bool temID = compra['id'] != null;

    final compras = Compras(
      id: temID ? compra['id'] as String : Random().nextDouble().toString(),
      nome: compra['nome'] as String,
      data: DateFormat('dd/MM/yyyy').format(data),
    );

    if (temID) {
      atualizarCompras(compras);
    } else {
      adicionarCompras(compras);
    }
  }

  void adicionarCompras(Compras compras) {
    _comprasItens.add(compras);
    DBUtil.insert('compras', {
      'id': compras.id,
      'nome': compras.nome,
      'data': DateFormat('dd/MM/yyyy').format(data),
    });
    notifyListeners();
  }

  void atualizarCompras(Compras compras) {
    int index = _comprasItens.indexWhere((c) => c.id == compras.id);

    if (index >= 0) {
      _comprasItens[index] = compras;
      DBUtil.update(
        'compras',
        {
          'nome': compras.nome,
          'data': DateFormat('dd/MM/yyyy').format(data),
        },
        '${compras.id}',
      );
      notifyListeners();
    }
  }

  void removerCompras(Compras compras) {
    int index = _comprasItens.indexWhere((c) => c.id == compras.id);

    if (index >= 0) {
      DBUtil.delete('compras', compras.id);
      _comprasItens.removeAt(index);
      notifyListeners();
    }
  }

  int get count {
    return _comprasItens.length;
  }

  Compras byIndex(int i) {
    return _comprasItens.elementAt(i);
  }

  retornarId(Compras compras) {
    int index = _comprasItens.indexWhere((c) => c.id == compras.id);
    print(index);
    return index;
  }
}
