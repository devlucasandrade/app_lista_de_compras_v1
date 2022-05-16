import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lista_de_compras2/models/produtos_lista.dart';
import 'package:lista_de_compras2/models/produto.dart';
import 'package:provider/provider.dart';

class AdicionarProdutosForm extends StatefulWidget {
  const AdicionarProdutosForm({Key? key}) : super(key: key);

  @override
  State<AdicionarProdutosForm> createState() => _AdicionarProdutosFormState();
}

class _AdicionarProdutosFormState extends State<AdicionarProdutosForm> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  final double borda = 5;

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final produtos = arg as Produtos;
        _formData['id'] = produtos.id;
        _formData['nome'] = produtos.nome;
        _formData['quantidade'] = produtos.quantidade;
        _formData['preco'] = produtos.preco.toString().replaceAll('.', ',');
      }
    }
  }

  void _submitForm() {
    final ehValido = _formKey.currentState?.validate() ?? false;

    if (!ehValido) {
      return;
    }

    _formKey.currentState?.save();

    Provider.of<ProdutosLista>(
      context,
      listen: false,
    ).salvarProdutos(_formData);

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
        title: const Text('Adicionar Produtos'),
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
                          labelText: 'Nome do Produto',
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
                            return 'Nome do produto é obrigatório.';
                          }

                          if (nome.trim().length < 3) {
                            return 'Nome precisa ter no mínimo 3 letras.';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: _formData['quantidade']?.toString(),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.calculate_outlined),
                          labelText: 'Quantidade',
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
                        keyboardType: TextInputType.number,
                        onSaved: (quantidade) => _formData['quantidade'] =
                            int.parse(quantidade ?? '0'),
                        validator: (_quantidade) {
                          final quantidadeString = _quantidade ?? '';
                          final quantidade =
                              int.tryParse(quantidadeString) ?? -1;

                          if (quantidade <= 0) {
                            return 'Informe a quantidade.';
                          }

                          if (quantidade > 999) {
                            return 'Informe a quantidade correta.';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: _formData['preco']?.toString(),
                        decoration: InputDecoration(
                          labelText: 'Preço Unitário',
                          prefixIcon: Icon(Icons.monetization_on_outlined),
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
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,

                        // Formatar valores para REAL BR
                        inputFormatters: [
                          RealMask(),
                        ],
                        onFieldSubmitted: (value) {
                          _submitForm();
                        },
                        onSaved: (preco) {
                          _formData['preco'] = double.parse(
                            preco!.replaceAll(RegExp(r','), '.'),
                          );
                        },

                        validator: (_preco) {
                          final precoString =
                              _preco!.replaceAll(RegExp(r','), '.');
                          final preco = double.tryParse(precoString) ?? -1;

                          if (preco < 0) {
                            return 'Informe Zero ou um valor positivo.';
                          }

                          if (preco > 9999) {
                            return 'Informe o valor correto.';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
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
              Image.asset(
                'assets/images/image01.png',
                fit: BoxFit.cover,
              ),
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
