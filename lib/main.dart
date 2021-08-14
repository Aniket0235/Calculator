import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 35.0;
  double resultFontSize = 45.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
        equationFontSize = 35.0;
        resultFontSize = 45.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 45.0;
        resultFontSize = 35.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation == "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 35.0;
        resultFontSize = 45.0;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
        color: buttonColor,
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid)),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(buttonText,
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(title: Text('Calculator')),
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                equation,
                style:
                TextStyle(fontSize: equationFontSize, color: Colors.white),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                result,
                style: TextStyle(fontSize: resultFontSize, color: Colors.white),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton("AC", 1, Colors.red),
                        buildButton("⌫", 1, Colors.lightBlue.shade600),
                        buildButton("^", 1, Colors.lightBlue.shade600),
                      ]),
                      TableRow(children: [
                        buildButton("7", 1, Colors.white38),
                        buildButton("8", 1, Colors.white38),
                        buildButton("9", 1, Colors.white38),
                      ]),
                      TableRow(children: [
                        buildButton("4", 1, Colors.white38),
                        buildButton("5", 1, Colors.white38),
                        buildButton("6", 1, Colors.white38),
                      ]),
                      TableRow(children: [
                        buildButton("1", 1, Colors.white38),
                        buildButton("2", 1, Colors.white38),
                        buildButton("3", 1, Colors.white38),
                      ]),
                      TableRow(children: [
                        buildButton(".", 1, Colors.white38),
                        buildButton("0", 1, Colors.white38),
                        buildButton("( )", 1, Colors.white38),
                      ]),
                    ],
                  )),
              Container(
                width: MediaQuery.of(context).size.width * .25,
                child: Table(children: [
                  TableRow(children: [
                    buildButton("÷", 1, Colors.lightBlue.shade600),
                  ]),
                  TableRow(children: [
                    buildButton("×", 1, Colors.lightBlue.shade600),
                  ]),
                  TableRow(children: [
                    buildButton("-", 1, Colors.lightBlue.shade600),
                  ]),
                  TableRow(children: [
                    buildButton("+", 1, Colors.lightBlue.shade600),
                  ]),
                  TableRow(children: [
                    buildButton("=", 1, Colors.red),
                  ]),
                ]),
              )
            ]),
          ],
        ));
  }
}
