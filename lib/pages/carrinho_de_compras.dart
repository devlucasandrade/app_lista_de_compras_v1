import 'package:flutter/material.dart';
import 'package:lista_de_compras2/components/app_drawer.dart';
import 'package:lista_de_compras2/components/custom_bottomnavigatorbar.dart';
import 'package:lista_de_compras2/components/item_da_lista_de_produtos_do_carrinho.dart';
import 'package:lista_de_compras2/models/lista_de_produtos.dart';
import 'package:lista_de_compras2/models/produto.dart';
import 'package:provider/provider.dart';

class CarrinhoDeCompras extends StatelessWidget {
  const CarrinhoDeCompras({Key? key}) : super(key: key);

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
            padding: const EdgeInsets.only(right: 3),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/instrucoes');
              },
              icon: const Icon(Icons.help_outline),
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
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Para começar a usar, adicione produtos ao carrinho, clicando no botâo ADICIONAR logo abaixo.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
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
