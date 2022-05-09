import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

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
          const SizedBox(height: 40),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _packageInfo.appName,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                'Versão: ' + _packageInfo.version,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/icone.png',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * .3,
              ),
              const SizedBox(height: 20),
              const Text(
                '2022 - Lucas Andrade',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const Text(
                'Todos os direitos reservados.',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
