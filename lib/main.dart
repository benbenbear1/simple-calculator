import 'package:flutter/material.dart';
import 'package:trial/buttons.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

    @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var userInput = '';
  var userAnswer = '';



  final myTextStyle = const TextStyle(fontSize: 25, color: Colors.white);

  // Array of button
  final List<String> buttons = [
    'C', 'DEL', '%', 'ANS',
    '7', '8', '9', '/',
    '4', '5', '6', 'x',
    '1', '2', '3', '-',
    '0', '.', '=','+',
  ];


   @override
  Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: const Color(0xFF1F1F35),
       body: Column(
          children: <Widget> [
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(height: 50,),
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(userInput, style: const TextStyle(fontSize: 35, color: Colors.white))
                      ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(userAnswer, style: const TextStyle(fontSize: 45, color: Colors.white,
                          fontWeight: FontWeight.bold),)

                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index){
                    if (index == 0) { // Clear Button
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userInput = '';
                            userAnswer = '0';
                          });
                      },
                        buttonText: buttons[index],
                        color:  const Color(0xFF13102C),
                        textColor: Colors.white,

                    );
                  }  else if(index == 1) {  // Delete Button
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userInput = userInput.substring(0, userInput.length-1);
                          });
                        },
                        buttonText: buttons[index],
                        color:  const Color(0xFF13102C),
                        textColor: Colors.white,
                      );
                    } else if(index == 2) {  // %
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            });
                        },
                        buttonText: buttons[index],
                        color:  const Color(0xFF13102C),
                        textColor: Colors.white,
                      );
                    } else if(index == 3) {  // ANS
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                          });
                        },
                        buttonText: buttons[index],
                        color:  const Color(0xFF13102C),
                        textColor: Colors.white,
                      );
                    }else if(index == 18) {  // Equals to Button
                      return MyButton(
                      buttonTapped: () {
                        setState(() {
                          equalPressed();
                         });
                      },
                        buttonText: buttons[index],
                          color: Colors.white,
                              textColor: Colors.black,
                          );

                  } else {
                      return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userInput += buttons[index];    //userInput = userInput + buttons[index]
                        });
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index]) ? const Color(0xFF13102C) : Colors.white,
                      textColor: isOperator(buttons[index]) ? Colors.white : Colors.black,
                      );
                      }
                })
              ),
            ),
         ],
       )
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finaluserInput = userInput;
    finaluserInput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}


