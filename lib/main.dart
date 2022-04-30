import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_de_compras2/models/lista_de_produtos.dart';
import 'package:lista_de_compras2/pages/adicionar_produtos_form.dart';
import 'package:lista_de_compras2/pages/carrinho_de_compras.dart';
import 'package:lista_de_compras2/pages/instrucoes_de_uso.dart';
import 'package:lista_de_compras2/pages/sobre.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ListaDeProdutos(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => const CarrinhoDeCompras(),
          '/adicionarproduto': (context) => const AdicionarProdutosForm(),
          '/instrucoes': (context) => const InstrucoesDeUso(),
          '/sobre': (context) => const Sobre(),
        },
      ),
    );
  }
}
