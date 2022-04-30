import 'package:flutter/material.dart';

class ContainerInstrucoes extends StatelessWidget {
  final Color color;
  final String urlImage;
  final String title;
  final String subtitle;

  const ContainerInstrucoes({
    Key? key,
    required this.color,
    required this.urlImage,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Image.asset(
              urlImage,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * .7,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.blue.shade900,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue.shade900,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
