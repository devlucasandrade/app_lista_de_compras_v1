import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue.shade300,
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
          ),
          Card(
            color: Colors.blue.shade100,
            child: ListTile(
              leading: const Icon(Icons.shopping_cart_rounded, size: 30),
              title: const Text('Carrinho de Compras'),
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
          Card(
            color: Colors.blue.shade100,
            child: ListTile(
              leading: const Icon(Icons.add_shopping_cart_outlined, size: 30),
              title: const Text('Adicionar Produtos'),
              onTap: () =>
                  Navigator.of(context).popAndPushNamed('/adicionarproduto'),
            ),
          ),
          Card(
            color: Colors.blue.shade100,
            child: ListTile(
              leading: const Icon(Icons.help_outline, size: 30),
              title: const Text('Dúvidas? Clique aqui.'),
              onTap: () => Navigator.of(context).pushNamed('/instrucoes'),
            ),
          ),
          Card(
            color: Colors.blue.shade100,
            child: ListTile(
              leading: const Icon(Icons.info_outline, size: 30),
              title: const Text('Sobre'),
              // subtitle: const Text('Versão: Beta'),
              onTap: () => Navigator.of(context).pushNamed('/sobre'),
            ),
          ),
          Image.asset(
            'assets/images/drawer.png',
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
