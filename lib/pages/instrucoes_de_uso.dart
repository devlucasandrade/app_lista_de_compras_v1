import 'package:flutter/material.dart';
import 'package:lista_de_compras2/components/container_instrucoes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InstrucoesDeUso extends StatefulWidget {
  const InstrucoesDeUso({Key? key}) : super(key: key);

  @override
  State<InstrucoesDeUso> createState() => _InstrucoesDeUsoState();
}

class _InstrucoesDeUsoState extends State<InstrucoesDeUso> {
  final controller = PageController();
  bool ultimaPagina = false;

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      appBar: AppBar(
        title: const Text('Intruções de Uso'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              ultimaPagina = index == 6;
            });
          },
          children: [
            ContainerInstrucoes(
              color: Colors.blue.shade100,
              urlImage: 'assets/images/instrucoes.png',
              title: 'COMO USAR',
              subtitle:
                  'Aqui teremos instruções de como utilizar a sua Lista de Compras e ter o melhor aproveitamento do aplicativo.',
            ),
            ContainerInstrucoes(
              color: Colors.blue.shade100,
              urlImage: 'assets/images/carrinho.png',
              title: 'ADICIONANDO PRODUTOS',
              subtitle:
                  'Ao abrir o aplicativo, será apresentada a tela onde serão adicionados os produtos. \n\nPara adicionar um novo clique no botão ADICIONAR no canto inferior direito.',
            ),
            ContainerInstrucoes(
              color: Colors.blue.shade100,
              urlImage: 'assets/images/todolist.png',
              title: 'NOME, QUANTIDADE E PREÇO',
              subtitle:
                  'Após adicionar o item, você será enviado para tela onde devem ser preenchidos os dados. \n\nCaso esteja em casa, coloque o preço como Zero e quando estiver no supermercado basta ATUALIZAR o preço.',
            ),
            ContainerInstrucoes(
              color: Colors.blue.shade100,
              urlImage: 'assets/images/wishes_list.png',
              title: 'ATUALIZANDO O PRODUTO',
              subtitle:
                  'Clicando no produto, será aberto o cadastro do mesmo, onde poderá atualizar todos os dados e SALVAR. \n\nAs mudanças de quantidade e preço após salvar o produto, são atualizadas automaticamente.',
            ),
            ContainerInstrucoes(
              color: Colors.blue.shade100,
              urlImage: 'assets/images/self_checkout.png',
              title: 'SALVANDO NA LISTA',
              subtitle:
                  'Clicando em SALVAR, você será redirecionado para a tela inicial, onde estão listados todos os itens incluídos até o momento.',
            ),
            ContainerInstrucoes(
              color: Colors.blue.shade100,
              urlImage: 'assets/images/cleanup.png',
              title: 'APAGANDO DA LISTA',
              subtitle:
                  'Para excluir um produto clique em cima dele e deslizando para a esquerda. \n\nMas calma, antes de excluir o aplicativo precisará da confirmação.',
            ),
            ContainerInstrucoes(
              color: Colors.blue.shade100,
              urlImage: 'assets/images/checkout.png',
              title: 'VAMOS LÁ!',
              subtitle:
                  'Agora é utilizar o aplicativo criando sua lista de compras para usá-la quando for ao supermercado. \n\nVocê terá à mão a informação de subtotais e total das compras, facilitando assim a sua vida!',
            ),
          ],
        ),
      ),
      bottomSheet: ultimaPagina
          ? TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
                minimumSize: const Size.fromHeight(80),
              ),
              child: const Text(
                'COMEÇAR',
                style: TextStyle(fontSize: 22),
              ),
              onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: const Text(
                      'SAIR',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 7,
                      effect: WormEffect(
                        dotHeight: 12,
                        dotWidth: 12,
                        spacing: 6,
                        dotColor: Colors.grey.shade400,
                        activeDotColor: Colors.blue,
                      ),
                      onDotClicked: (index) => controller.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      ),
                    ),
                  ),
                  TextButton(
                    child: const Text(
                      'PRÓXIMO',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () => controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
