import 'package:flutter/material.dart';

class FirstBox extends StatefulWidget {
  const FirstBox({super.key});

  @override
  State<StatefulWidget> createState() => _FirstBoxState();
}

class _FirstBoxState extends State<FirstBox> {
  @override
  Widget build(context) {
    return Container(
      alignment: Alignment.center,
      width: 350,
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Total per person:"),
          Text("Amount comes here"),
        ],
      ),
    );
  }
}
