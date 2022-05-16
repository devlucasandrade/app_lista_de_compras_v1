import 'package:flutter/cupertino.dart';
import 'package:lista_de_compras2/models/produto.dart';

class Compras with ChangeNotifier {
  final String id;
  final String nome;
  final String data;
  List<Produtos>? produtos = [];

  Compras({
    required this.id,
    required this.nome,
    required this.data,
    this.produtos,
  });
}
