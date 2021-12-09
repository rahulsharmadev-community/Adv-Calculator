// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class StdButtonService extends StatefulWidget {
  final valueTransfer;
  const StdButtonService({Key? key, required this.valueTransfer})
      : super(key: key);

  @override
  _StdButtonServiceState createState() => _StdButtonServiceState();
}

class _StdButtonServiceState extends State<StdButtonService> {
  var userInput = '';

  var answer = '';

  final List<String> buttons = [
    'AC',
    '+/-',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '.',
    '0',
    '↩',
    '=',
  ];

  Widget button(
          {required VoidCallback buttonTap,
          required Color backgroundcolor,
          Color? titleColor = Colors.black,
          required String title}) =>
      InkResponse(
        onTap: buttonTap,
        splashColor: Colors.amber,
        child: Container(
          decoration: BoxDecoration(
              color: isOperator(title)
                  ? Colors.grey.shade200
                  : Colors.green.shade50,
              borderRadius: BorderRadius.circular(64),
              boxShadow: isOperator(title)
                  ? <BoxShadow>[
                      const BoxShadow(
                          color: Colors.black,
                          offset: Offset(3, 3),
                          blurRadius: 5,
                          spreadRadius: 1)
                    ]
                  : null),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(64),
            child: Container(
              decoration: BoxDecoration(
                  color: title != '=' ? Colors.transparent : null,
                  gradient: LinearGradient(
                    colors: [
                      Colors.yellow,
                      Colors.green.shade400,
                      Colors.green.shade700
                    ],
                    tileMode: TileMode.clamp,
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  )),
              child: Center(
                child: Text(
                  title == '/' ? '÷' : title,
                  style: TextStyle(
                      color: titleColor,
                      fontSize: title == '↩' || title == '=' || title == '-'
                          ? 35
                          : 25),
                ),
              ),
            ),
          ),
        ),
      );

  bool isOperator(String x) {
    if (x == '/' ||
        x == 'x' ||
        x == '-' ||
        x == '+' ||
        x == '=' ||
        x == '%' ||
        x == '%' ||
        x == '+/-' ||
        x == 'AC') {
      return true;
    }
    return false;
  }

// function to calculate the input operation
  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, crossAxisSpacing: 25, mainAxisSpacing: 25),
        itemBuilder: (BuildContext context, int index) {
          // Clear Button
          if (index == 0) {
            return button(
              buttonTap: () {
                setState(() {
                  userInput = '';
                  answer = '0';
                });
                widget.valueTransfer(userInput, answer);
              },
              title: buttons[index],
              backgroundcolor: Colors.blue.shade50,
              titleColor: Colors.black,
            );
          }

          // +/- button
          else if (index == 1) {
            return button(
              buttonTap: () {
                setState(() {
                  userInput[0] != '-'
                      ? userInput = '-' + userInput
                      : userInput = userInput.substring(1, userInput.length);
                });
                widget.valueTransfer(userInput, answer);
              },
              title: buttons[index],
              backgroundcolor: Colors.blue.shade50,
              titleColor: Colors.black,
            );
          }
          // % Button
          else if (index == 2) {
            return button(
              buttonTap: () {
                setState(() {
                  userInput += buttons[index];
                });
                widget.valueTransfer(userInput, answer);
              },
              title: buttons[index],
              backgroundcolor: Colors.grey.shade300,
              titleColor: Colors.black,
            );
          }
          // Delete Button
          else if (index == 18) {
            return button(
              buttonTap: () {
                setState(() {
                  userInput = userInput.substring(0, userInput.length - 1);
                });
                widget.valueTransfer(userInput, answer);
              },
              title: buttons[index],
              backgroundcolor: Colors.blue.shade50,
              titleColor: Colors.black,
            );
          }
          // Equal_to Button
          else if (index == 19) {
            return button(
              buttonTap: () {
                setState(() {
                  equalPressed();
                });
                widget.valueTransfer(userInput, answer);
              },
              title: buttons[index],
              backgroundcolor: Colors.orange.shade700,
              titleColor: Colors.white,
            );
          }

          //  other buttons
          else {
            return button(
              buttonTap: () {
                setState(() {
                  userInput += buttons[index];
                });
                widget.valueTransfer(userInput, answer);
              },
              title: buttons[index],
              backgroundcolor:
                  isOperator(buttons[index]) ? Colors.blueAccent : Colors.white,
              titleColor:
                  isOperator(buttons[index]) ? Colors.black : Colors.black,
            );
          }
        },
        itemCount: buttons.length,
      ),
    );
  }
}
