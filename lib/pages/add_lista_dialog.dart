import 'package:flutter/material.dart';
import 'package:lista_de_compras2/models/compras.dart';
import 'package:lista_de_compras2/models/compras_lista.dart';
import 'package:provider/provider.dart';

class AdicionarListaDialog extends StatefulWidget {
  const AdicionarListaDialog({Key? key}) : super(key: key);

  @override
  State<AdicionarListaDialog> createState() => _AdicionarListaDialogState();
}

class _AdicionarListaDialogState extends State<AdicionarListaDialog> {
  final double borda = 5;

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, String>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final compras = arg as Compras;
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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
    );
  }
}
