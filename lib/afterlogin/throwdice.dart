import 'package:flutter/material.dart';
import 'package:wr/afterlogin/drawer.dart';
import 'package:wr/myvariables.dart';
import 'dart:math';

String rolledDice = 'D4';
int value = 0;
List<double> valuesMean = [
  0,
  0,
  0,
  0,
  0,
  0,
];
List<int> valuesDivide = [0, 0, 0, 0, 0, 0];

class ThrowDicePage extends StatefulWidget {
  const ThrowDicePage({Key? key}) : super(key: key);

  @override
  State<ThrowDicePage> createState() => _ThrowDicePageState();
}

class _ThrowDicePageState extends State<ThrowDicePage> {
  @override
  Widget build(BuildContext context) {
    void takeValues() {
      var rng = Random();

      switch (rolledDice) {
        case 'D4':
          value = rng.nextInt(4) + 1;
          break;
        case 'D6':
          value = rng.nextInt(6) + 1;
          break;
        case 'D10':
          value = rng.nextInt(10) + 1;
          break;
        case 'D12':
          value = rng.nextInt(12) + 1;
          break;
        case 'D20':
          value = rng.nextInt(20) + 1;
          break;
        case 'D100':
          value = rng.nextInt(100) + 1;
          break;
      }
    }

    void takeMeanValues() {
      switch (rolledDice) {
        case 'D4':
          valuesMean[0] = value + valuesMean[0];
          valuesDivide[0]++;
          break;
        case 'D6':
          valuesMean[1] = value + valuesMean[1];
          valuesDivide[1]++;
          break;
        case 'D10':
          valuesMean[2] = value + valuesMean[2];
          valuesDivide[2]++;
          break;
        case 'D12':
          valuesMean[3] = value + valuesMean[3];
          valuesDivide[3]++;
          break;
        case 'D20':
          valuesMean[4] = value + valuesMean[4];
          valuesDivide[4]++;
          break;
        case 'D100':
          valuesMean[5] = value + valuesMean[5];
          valuesDivide[5]++;
          break;
      }
    }

    String textValue(int index) {
      {
        if (valuesDivide[index] == 0) {
          return '';
        } else {
          return (valuesMean[index] / valuesDivide[index]).toStringAsFixed(2);
        }
      }
    }

    //double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeigth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      drawer: appDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    child: DropdownButton<String>(
                  dropdownColor: Color(0xff3D3D3D),
                  value: rolledDice,
                  items: diceType
                      .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item,
                              ),
                            ],
                          )))
                      .toList(),
                  onChanged: (item) => setState(
                    (() {
                      rolledDice = item!;
                    }),
                  ),
                )),
                Text(value.toString()),
                SizedBox(
                  height: 20,
                ),
                Text(diceMean),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(diceType[0] + ': '), Text(textValue(0))],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(diceType[1] + ': '), Text(textValue(1))],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(diceType[2] + ': '), Text(textValue(2))],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(diceType[3] + ': '), Text(textValue(3))],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(diceType[4] + ': '), Text(textValue(4))],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(diceType[5] + ': '), Text(textValue(5))],
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        takeValues();
                        takeMeanValues();
                      });
                    },
                    child: Text(rollDiceButton)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
