import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_de_compras2/models/compras_lista.dart';
import 'package:lista_de_compras2/models/produtos_lista.dart';
import 'package:lista_de_compras2/pages/lista_de_compras.dart';
import 'package:lista_de_compras2/pages/lista_de_produtos.dart';
import 'package:lista_de_compras2/pages/instrucoes_de_uso.dart';
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
          create: (ctx) => ProdutosLista(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ComprasLista(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => ListaDeCompras(),
          '/listadeprodutos': (context) => const ListaDeProdutos(),
          '/instrucoes': (context) => const InstrucoesDeUso(),
        },
      ),
    );
  }
}
