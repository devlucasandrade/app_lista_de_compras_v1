import 'package:flutter/material.dart';
import 'package:lista_de_compras2/components/app_drawer.dart';
import 'package:lista_de_compras2/components/custom_bottomnavigatorbar.dart';
import 'package:lista_de_compras2/components/item_da_lista_de_produtos_do_carrinho.dart';
import 'package:lista_de_compras2/models/lista_de_produtos.dart';
import 'package:lista_de_compras2/models/produto.dart';
import 'package:provider/provider.dart';

class CarrinhoDeCompras extends StatefulWidget {
  const CarrinhoDeCompras({Key? key}) : super(key: key);

  @override
  State<CarrinhoDeCompras> createState() => _CarrinhoDeComprasState();
}

class _CarrinhoDeComprasState extends State<CarrinhoDeCompras> {
  @override
  Widget build(BuildContext context) {
    final ListaDeProdutos produtos = Provider.of(context);
    double totalCarrinho = 0.0;

    for (Produtos prod in produtos.itens) {
      double total = (prod.preco) * (prod.quantidade);
      totalCarrinho += total;
    }

    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      appBar: AppBar(
        title: const Text('Carrinho de Compras'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                if (produtos.count > 0) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Limpar Lista?"),
                      content: const Text(
                        "Tem certeza que quer remover TODOS os itens do carrinho?",
                      ),
                      actions: [
                        TextButton(
                          child: const Text(
                            "NÃO",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text("SIM"),
                          onPressed: () {
                            produtos.removerTodos();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Lista Vazia"),
                      content: const Text(
                        "A lista de produtos atual já está vazia. Cadastre novos produtos para começar a usar.",
                      ),
                      actions: [
                        TextButton(
                          child: const Text(
                            "SAIR",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              icon: Icon(
                Icons.delete_forever_outlined,
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<ListaDeProdutos>(context, listen: false)
            .carregarProdutos(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.none
                ? Center(
                    child: Text('Nenhum produto cadastrado.'),
                  )
                : Consumer<ListaDeProdutos>(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
                            child: const Text(
                              'Para começar a usar, adicione produtos ao carrinho, clicando no botâo ADICIONAR logo abaixo.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Image.asset(
                            'assets/images/carrinho.png',
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    builder: (context, listarProdutos, ch) =>
                        listarProdutos.count == 0
                            ? ch!
                            : ListView.builder(
                                itemCount: listarProdutos.count,
                                itemBuilder: (context, index) =>
                                    ItemDaListaDeProdutosDoCarrinho(
                                  produtos.byIndex(index),
                                ),
                              ),
                  ),
      ),
      bottomNavigationBar: CustomBottomnavigatorbar(
        total: totalCarrinho,
      ),
      drawer: const AppDrawer(),
    );
  }
}
