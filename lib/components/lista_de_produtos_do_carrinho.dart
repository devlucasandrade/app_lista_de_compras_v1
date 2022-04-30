import 'package:flutter/material.dart';
import 'package:lista_de_compras2/components/item_da_lista_de_produtos_do_carrinho.dart';
import 'package:lista_de_compras2/models/lista_de_produtos.dart';
import 'package:lista_de_compras2/models/produto.dart';
import 'package:provider/provider.dart';

class ListaDeProdutosDoCarrinho extends StatelessWidget {
  const ListaDeProdutosDoCarrinho({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ListaDeProdutos>(context);
    final List<Produtos> listaProdutos = provider.itens;

    return ListView.builder(
      itemCount: listaProdutos.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: listaProdutos[i],
        child: ItemDaListaDeProdutosDoCarrinho(listaProdutos[i]),
      ),
    );
  }
}
