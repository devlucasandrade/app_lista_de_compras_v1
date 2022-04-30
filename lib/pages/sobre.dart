import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  const Sobre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      appBar: AppBar(
        title: const Text('Sobre'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Carrinho de Compras',
              style: TextStyle(
                fontSize: 28,
              ),
            ),
            const Text(
              'Versão: Beta',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            // const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Image.asset(
                'assets/images/image01.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '2022 - Lucas Andrade',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const Text(
              'Todos os direitos reservados.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
