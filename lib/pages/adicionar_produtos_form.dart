import 'package:flutter/material.dart';
import 'package:lista_de_compras2/models/lista_de_produtos.dart';
import 'package:lista_de_compras2/models/produto.dart';
import 'package:provider/provider.dart';

class AdicionarProdutosForm extends StatefulWidget {
  const AdicionarProdutosForm({Key? key}) : super(key: key);

  @override
  State<AdicionarProdutosForm> createState() => _AdicionarProdutosFormState();
}

class _AdicionarProdutosFormState extends State<AdicionarProdutosForm> {
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
        _formData['preco'] = produtos.preco;
      }
    }
  }

  void _submitForm() {
    final ehValido = _formKey.currentState?.validate() ?? false;

    if (!ehValido) {
      return;
    }

    _formKey.currentState?.save();

    Provider.of<ListaDeProdutos>(
      context,
      listen: false,
    ).salvarProdutos(_formData);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      appBar: AppBar(
        title: const Text('Adicionar Produtos'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Container(
            padding: const EdgeInsets.all(10),
            color: Colors.blue.shade100,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _formData['nome']?.toString(),
                    decoration:
                        const InputDecoration(labelText: 'Nome do Produto'),
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
                    decoration: const InputDecoration(labelText: 'Quantidade'),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onSaved: (quantidade) =>
                        _formData['quantidade'] = int.parse(quantidade ?? '0'),
                    validator: (_quantidade) {
                      final quantidadeString = _quantidade ?? '';
                      final quantidade = int.tryParse(quantidadeString) ?? -1;

                      if (quantidade <= 0) {
                        return 'Informe a quantidade.';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: _formData['preco']?.toString(),
                    decoration: const InputDecoration(labelText: 'Preço'),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    onSaved: (preco) =>
                        _formData['preco'] = double.parse(preco ?? '0'),
                    validator: (_preco) {
                      final precoString = _preco ?? '';
                      final preco = double.tryParse(precoString) ?? -1;

                      if (preco < 0) {
                        return 'Informe Zero ou um valor positivo.';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 120,
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
                        width: 120,
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
        ),
      ),
    );
  }
}
