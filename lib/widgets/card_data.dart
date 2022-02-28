import 'package:flutter/material.dart';

class CardData extends StatelessWidget {
  final double porcentagemTamanho;
  final Widget title;
  final Widget body;

  const CardData({
    Key? key,
    required this.porcentagemTamanho,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height * porcentagemTamanho,
      margin: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF172441),
      ),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.08,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              color: Color(0xFF0D101E),
            ),
            child: title,
          ),
          body,
        ],
      ),
    );
  }
}
