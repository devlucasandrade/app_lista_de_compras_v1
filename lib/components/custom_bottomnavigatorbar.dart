import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomBottomnavigatorbar extends StatefulWidget {
  final double total;

  const CustomBottomnavigatorbar({
    Key? key,
    required this.total,
  }) : super(key: key);

  @override
  State<CustomBottomnavigatorbar> createState() =>
      _CustomBottomnavigatorbarState();
}

class _CustomBottomnavigatorbarState extends State<CustomBottomnavigatorbar> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          width: MediaQuery.of(context).size.width,
          height: 60,
          color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total ' + real.format(widget.total),
                // 'Total R\$ ' + widget.total.toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
