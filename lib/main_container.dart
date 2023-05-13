// ignore_for_file: avoid_unnecessary_containers, unused_element, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:core';

class SliderBox extends StatefulWidget {
  const SliderBox({super.key});

  @override
  State<StatefulWidget> createState() => _SliderBoxState();
}

class _SliderBoxState extends State<SliderBox> {
  double _totalToBePaid = 0.0;
  double _tipPercentage = 0.0;
  int _totalPeople = 1;
  double _tip = 0, _billAmount = 0.0;

  _setPercentage(double val) {
    setState(() {
      _tipPercentage = val;
      _tip = (_tipPercentage / 100) * _billAmount;
      _totalToBePaid = (_billAmount + _tip) / _totalPeople;
    });
  }

  _decrementPeople() {
    setState(() {
      if (_totalPeople == 1) {
        _totalPeople = 1;
      } else {
        _totalPeople--;
      }
      _totalToBePaid = (_billAmount + _tip) / _totalPeople;
    });
  }

  _incrementPeople() {
    setState(() {
      _totalPeople++;
      _totalToBePaid = (_billAmount + _tip) / _totalPeople;
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.125),
          alignment: Alignment.center,
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(20),
            children: <Widget>[
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
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    Text(
                      "\$ ${_totalToBePaid.toStringAsFixed(2)}",
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
                padding: const EdgeInsets.all(10),
                width: 350,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueGrey.shade100,
                    style: BorderStyle.solid,
                  ),
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
                            textAlign: TextAlign.center,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                            decoration: const InputDecoration(
                              prefixText: "Bill Amount",
                              prefixIcon: Icon(
                                Icons.attach_money,
                              ),
                            ),
                            // inputFormatters: <TextInputFormatter>[
                            //   FilteringTextInputFormatter.digitsOnly
                            // ],
                            onChanged: (String value) {
                              try {
                                _billAmount = double.parse(value);
                              } catch (exception) {
                                _billAmount = 0.0;
                              }
                            },
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
                    const Padding(padding: EdgeInsets.only(bottom: 20)),
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
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(80, 155, 39, 176),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              margin: const EdgeInsets.only(right: 5),
                              child: InkWell(
                                onTap: _decrementPeople,
                                child: const Icon(Icons.remove),
                              ),
                            ),
                            Text("$_totalPeople"),
                            Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(80, 155, 39, 176),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              margin: const EdgeInsets.only(left: 5),
                              child: InkWell(
                                onTap: _incrementPeople,
                                child: const Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
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
                          style: const TextStyle(
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
                      divisions: 10,
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
