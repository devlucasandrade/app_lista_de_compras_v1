import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_de_compras2/models/compras.dart';
import 'package:lista_de_compras2/models/compras_lista.dart';
import 'package:provider/provider.dart';

class AdicionarListaForm extends StatefulWidget {
  const AdicionarListaForm({Key? key}) : super(key: key);

  @override
  State<AdicionarListaForm> createState() => _AdicionarListaFormState();
}

class _AdicionarListaFormState extends State<AdicionarListaForm> {
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
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: const Text('Adicionar Lista'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .35,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey.shade600,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(borda),
                                ),
                              ),
                              child: const Text('CANCELAR'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .35,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue.shade800,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(borda),
                                ),
                              ),
                              child: const Text('SALVAR'),
                              onPressed: _submitForm,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Imagem de preenchimento
              // Image.asset(
              //   'assets/images/image01.png',
              //   fit: BoxFit.cover,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// Código by Jacob Moura - Youtube flutterando
// https://www.youtube.com/watch?v=sjQLmibDEu4
class RealMask extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var value = newValue.text.replaceAll(RegExp(r'\D'), '');

    value = (int.tryParse(value) ?? 0).toString();

    // if (value.length < 3) {
    //   value = value.padLeft(3, '0');
    // }

    value = value.split('').reversed.join();

    final listCharacters = [];
    // var decimalCount = 0;

    for (var i = 0; i < value.length; i++) {
      if (i == 2) {
        listCharacters.insert(0, ',');
      }

      // if (i > 2) {
      //   decimalCount++;
      // }

      // if (decimalCount == 3) {
      //   listCharacters.insert(0, '.');
      //   decimalCount = 0;
      // }
      listCharacters.insert(0, value[i]);
    }

    listCharacters.insert(0, r'');
    var formatted = listCharacters.join();

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.fromPosition(
        TextPosition(offset: formatted.length),
      ),
    );
  }
}
