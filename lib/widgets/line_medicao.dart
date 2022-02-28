import 'package:flutter/material.dart';

class LineMedicao extends StatelessWidget {
  const LineMedicao({
    Key? key,
    required this.label,
    required this.dado,
  }) : super(key: key);

  final String label;
  final String dado;

  @override
  Widget build(BuildContext context) {
    const estilo = TextStyle(
      decoration: TextDecoration.none,
      fontSize: 18,
      color: Colors.white,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: estilo),
          Text(dado, style: estilo),
        ],
      ),
    );
  }
}
