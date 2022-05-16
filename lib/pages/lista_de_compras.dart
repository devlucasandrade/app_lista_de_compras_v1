import 'package:flutter/material.dart';
import 'package:lista_de_compras2/components/app_drawer.dart';
import 'package:lista_de_compras2/components/compras_item.dart';
import 'package:lista_de_compras2/models/compras_lista.dart';
import 'package:lista_de_compras2/pages/add_lista_dialog.dart';
import 'package:provider/provider.dart';

class ListaDeCompras extends StatefulWidget {
  const ListaDeCompras({Key? key}) : super(key: key);

  @override
  State<ListaDeCompras> createState() => _ListaDeCompras();
}

class _ListaDeCompras extends State<ListaDeCompras> {
  @override
  Widget build(BuildContext context) {
    final compras = Provider.of<ComprasLista>(context);

    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      appBar: AppBar(
        title: const Text('Lista de Compras'),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<ComprasLista>(
          context,
          listen: false,
        ).carregarListas(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.none
                ? Center(
                    child: Text('Nenhuma lista cadastrada.'),
                  )
                : Consumer<ComprasLista>(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
                            child: const Text(
                              'Para começar a usar, adicione uma lista, clicando no botâo ADICIONAR logo abaixo.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    builder: (context, listarCompras, ch) =>
                        listarCompras.count == 0
                            ? ch!
                            : ListView.builder(
                                itemCount: listarCompras.count,
                                itemBuilder: (context, index) {
                                  return ComprasItem(
                                    compras.byIndex(index),
                                  );
                                }),
                  ),
      ),
      floatingActionButton: Container(
        height: 45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            elevation: 2,
            primary: Colors.white,
          ),
          child: Text(
            '+ LISTA',
            style: TextStyle(
              color: Colors.blue.shade800,
            ),
          ),
          onPressed: () {
            openDialog();
          },
        ),
      ),
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AdicionarListaDialog(),
      );
}
