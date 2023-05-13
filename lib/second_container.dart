// ignore_for_file: avoid_unnecessary_containers, unused_element, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SliderBox extends StatefulWidget {
  const SliderBox({super.key});

  @override
  State<StatefulWidget> createState() => _SliderBoxState();
}

class _SliderBoxState extends State<SliderBox> {
  final TextEditingController amountController = TextEditingController();
  double _totalToBePaid = 0;

  double _tipPercentage = 0;
  int _totalPeople = 1;
  double _tip = 0;

  _setPercentage(double val) {
    setState(() {
      _tipPercentage = val;
      _tip = (_tipPercentage / 100) * double.parse(amountController.text);
      _totalToBePaid =
          (double.parse(amountController.text) + _tip) / _totalPeople;
    });
  }

  _decrementPeople() {
    setState(() {
      _totalPeople--;
      _totalToBePaid =
          (double.parse(amountController.text) + _tip) / _totalPeople;
    });
  }

  _incrementPeople() {
    setState(() {
      _totalPeople++;
      _totalToBePaid =
          (double.parse(amountController.text) + _tip) / _totalPeople;
    });

    void dispose() {
      amountController.dispose();
      super.dispose();
    }
  }

  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 350,
                height: 120,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(80, 155, 39, 176),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "TOTAL PER PERSON:",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 18,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Text(
                      "\$ $_totalToBePaid",
                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 40,
                ),
                padding: EdgeInsets.all(10),
                width: 350,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Bill Amount:",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        Flexible(
                          child: TextField(
                            controller: amountController,
                            textAlign: TextAlign.center,
                            obscureText: false,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: Colors.blueAccent,
                                  ),
                                  borderRadius: BorderRadius.circular(25)),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: double.infinity,
                      height: 18,
                    ),
                    const Divider(
                      height: 10,
                      color: Colors.grey,
                      indent: 0,
                      endIndent: 0,
                      thickness: 2,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Split between:",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(80, 155, 39, 176),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              margin: const EdgeInsets.only(right: 5),
                              child: InkWell(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                onTap: _decrementPeople,
                              ),
                            ),
                            Text("$_totalPeople"),
                            Container(
                              alignment: Alignment.center,
                              width: 30,
                              height: 30,
                              margin: EdgeInsets.only(left: 5),
                              color: Color.fromARGB(80, 155, 39, 176),
                              child: InkWell(
                                child: Text("+",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                onTap: _incrementPeople,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Tip:",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "\$ $_tip",
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "$_tipPercentage %",
                      style: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Slider(
                      activeColor: Colors.purple,
                      min: 0,
                      max: 100,
                      divisions: 5,
                      value: _tipPercentage,
                      onChanged: (_tipPercentage) => _setPercentage(
                        _tipPercentage,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
