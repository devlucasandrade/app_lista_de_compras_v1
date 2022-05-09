import 'package:flutter/cupertino.dart';

class Compras with ChangeNotifier {
  final String id;
  final String nome;
  final DateTime data;
  final String produtoId;

  Compras({
    required this.id,
    required this.nome,
    required this.data,
    required this.produtoId,
  });
}
