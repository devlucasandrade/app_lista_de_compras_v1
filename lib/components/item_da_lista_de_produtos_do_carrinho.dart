import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lista_de_compras2/models/lista_de_produtos.dart';
import 'package:lista_de_compras2/models/produto.dart';
import 'package:provider/provider.dart';

class ItemDaListaDeProdutosDoCarrinho extends StatefulWidget {
  final Produtos? prods;
  const ItemDaListaDeProdutosDoCarrinho(this.prods, {Key? key})
      : super(key: key);

  @override
  State<ItemDaListaDeProdutosDoCarrinho> createState() =>
      _ItemDaListaDeProdutosDoCarrinhoState();
}

class _ItemDaListaDeProdutosDoCarrinhoState
    extends State<ItemDaListaDeProdutosDoCarrinho> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Dismissible(
        key: ValueKey(widget.prods!.id),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 30),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: const Icon(
            Icons.delete,
            size: 30,
            color: Colors.white,
          ),
        ),
        onDismissed: (_) {
          Provider.of<ListaDeProdutos>(context, listen: false)
              .removerProdutos(widget.prods!);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(milliseconds: 1000),
              content: Text(
                '${widget.prods!.nome} Excluido com Sucesso!',
              ),
            ),
          );
        },
        confirmDismiss: (direction) {
          return showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Remover Item?"),
              content: const Text(
                "Tem certeza que quer remover o item do carrinho?",
              ),
              actions: [
                TextButton(
                  child: const Text("NÃO"),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: const Text("SIM"),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            ),
          );
        },
        child: Card(
          shadowColor: Colors.blue,
          elevation: 4,
          child: ListTile(
            leading: const Icon(
              Icons.shopping_cart_outlined,
              size: 30,
            ),
            title: Text(
              widget.prods!.nome,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            subtitle: Row(
              children: [
                Text(
                  'Qtd: ${widget.prods!.quantidade}',
                ),
                const SizedBox(width: 10),
                Text(
                  real.format(widget.prods!.preco),
                ),
              ],
            ),
            trailing: Text(
              real.format(
                (widget.prods!.quantidade * widget.prods!.preco),
              ),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/adicionarproduto', arguments: widget.prods);
            },
          ),
        ),
      ),
    );
  }
}
