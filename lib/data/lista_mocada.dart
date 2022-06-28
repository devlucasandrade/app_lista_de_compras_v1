import 'package:lista_de_compras2/models/compras.dart';
import 'package:lista_de_compras2/models/produto.dart';

final listaMocada = [
  Compras(
    id: 'c1',
    nome: 'Lista 1',
    data: DateTime.now().toString(),
    produtos: [
      Produtos(
        id: 'p1',
        nome: 'Leite',
        quantidade: 2,
        preco: 5.0,
      ),
      Produtos(
        id: 'p2',
        nome: 'Biscoito',
        quantidade: 2,
        preco: 3.5,
      ),
      Produtos(
        id: 'p3',
        nome: 'Açúcar',
        quantidade: 10,
        preco: 4.5,
      ),
    ],
  ),
  Compras
];
