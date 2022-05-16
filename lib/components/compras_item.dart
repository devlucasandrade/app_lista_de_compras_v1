import 'package:flutter/material.dart';

import 'package:lista_de_compras2/models/compras.dart';
import 'package:lista_de_compras2/models/compras_lista.dart';
import 'package:provider/provider.dart';

class ComprasItem extends StatefulWidget {
  final Compras? compras;
  const ComprasItem(this.compras, {Key? key}) : super(key: key);

  @override
  State<ComprasItem> createState() => _ComprasItem();
}

class _ComprasItem extends State<ComprasItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Dismissible(
        key: ValueKey(widget.compras!.id),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 30),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        onDismissed: (_) {
          Provider.of<ComprasLista>(context, listen: false)
              .removerCompras(widget.compras!);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(milliseconds: 1000),
              content: Text(
                '${widget.compras!.nome} Excluido com Sucesso!',
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
                  child: const Text(
                    "NÃO",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
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
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
              child: const Icon(
                Icons.shopping_cart,
                size: 30,
                color: Colors.blue,
              ),
            ),
            title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                widget.compras!.nome,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            subtitle: Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  size: 18,
                ),
                Text(widget.compras!.data),
              ],
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.orange,
                ),
                onPressed: () {
                  openDialog();
                },
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/listadeprodutos', arguments: widget.compras);
            },
          ),
        ),
      ),
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    TextFormField(
                      initialValue: _formData['nome']?.toString(),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.sort_by_alpha),
                        labelText: 'Nome da Lista',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      onSaved: (nome) => _formData['nome'] = nome ?? '',
                      validator: (_nome) {
                        final nome = _nome ?? '';

                        if (nome.trim().isEmpty) {
                          return 'Nome da lista é obrigatório.';
                        }

                        if (nome.trim().length < 3) {
                          return 'Nome precisa ter no mínimo 3 letras.';
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            SizedBox(
              child: TextButton(
                child: const Text(
                  'CANCELAR',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            SizedBox(
              child: TextButton(
                child: const Text('SALVAR'),
                onPressed: _submitForm,
              ),
            ),
          ],
        ),
      );
  final double borda = 5;

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, String>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = widget.compras;

      if (arg != null) {
        final compras = arg;
        _formData['id'] = compras.id;
        _formData['nome'] = compras.nome;
        // _formData['data'] = DateTime();
      }
    }
  }

  void _submitForm() {
    final ehValido = _formKey.currentState?.validate() ?? false;

    if (!ehValido) {
      return;
    }

    _formKey.currentState?.save();

    Provider.of<ComprasLista>(
      context,
      listen: false,
    ).salvarCompras(_formData);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 1000),
        content: Text(
          'Adicionado/Atualizado com sucesso!',
        ),
      ),
    );

    Navigator.of(context).pop();
  }
}
