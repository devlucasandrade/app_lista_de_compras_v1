import 'package:flutter/cupertino.dart';

class Produtos with ChangeNotifier {
  final String id;
  final String nome;
  final int quantidade;
  final double preco;

  Produtos({
    required this.id,
    required this.nome,
    required this.quantidade,
    required this.preco,
  });
}
