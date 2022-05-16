import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lista_de_compras2/models/produtos_lista.dart';
import 'package:lista_de_compras2/models/produto.dart';
import 'package:provider/provider.dart';

class ItemDaListaDeProdutosDoCarrinho extends StatefulWidget {
  final Produtos? prods;

  const ItemDaListaDeProdutosDoCarrinho(this.prods, {Key? key})
      : super(key: key);

  @override
  State<ItemDaListaDeProdutosDoCarrinho> createState() =>
      _ItemDaListaDeProdutosDoCarrinhoState();
}

class _ItemDaListaDeProdutosDoCarrinhoState
    extends State<ItemDaListaDeProdutosDoCarrinho> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Dismissible(
        key: ValueKey(widget.prods!.id),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 30),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: const Icon(
            Icons.delete,
            size: 30,
            color: Colors.white,
          ),
        ),
        onDismissed: (_) {
          Provider.of<ProdutosLista>(context, listen: false)
              .removerProdutos(widget.prods!);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(milliseconds: 1000),
              content: Text(
                '${widget.prods!.nome} Excluido com Sucesso!',
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
            leading: const Icon(
              Icons.shopping_basket_outlined,
              size: 30,
            ),
            title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                widget.prods!.nome,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            subtitle: Row(
              children: [
                Text(
                  'Qtd: ${widget.prods!.quantidade}',
                ),
                const SizedBox(width: 10),
                Text(
                  real.format(widget.prods!.preco),
                ),
              ],
            ),
            trailing: Container(
              width: 90,
              child: SingleChildScrollView(
                child: Text(
                  real.format(
                    (widget.prods!.quantidade * widget.prods!.preco),
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            onTap: () {
              openDialog();
              // Navigator.of(context)
              //     .pushNamed('/adicionarproduto', arguments: widget.prods);
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
                        final quantidade = int.tryParse(quantidadeString) ?? -1;

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
  final _formData = Map<String, Object>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = widget.prods;

      if (arg != null) {
        final produtos = arg;
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
