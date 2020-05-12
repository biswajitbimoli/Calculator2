import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyHomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<MyHomeScreen> {
  String result = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        leading: Icon(Icons.add_circle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[ Expanded(
          child: Container(
            color: Colors.teal,
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(bottom: 40.0, left: 10.0, right: 10.0),
            child: Text(
              result,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          )),
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    button('1'),
                    button('2'),
                    button('3'),
                    button('+')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    button('4'),
                    button('5'),
                    button('6'),
                    button('-')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    button('7'),
                    button('8'),
                    button('9'),
                    button('x')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    button('0'),
                    button('.'),
                    button('/'),
                    Container(
                        height: MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.width / 4,
                        padding: EdgeInsets.only(
                            bottom: 10.0, left: 5.0, right: 5.0),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                          color: Colors.black87,
                          child: Text(
                            '=',
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.0),
                          ),
                          onPressed: () {
                            result = result.replaceAll('x', '*');
                            Parser p = Parser();
                            ContextModel cm = ContextModel();
                            Expression exp = p.parse(result);
                            double eval = exp.evaluate(EvaluationType.REAL, cm);
                            setState(() {
                              result = eval.toString();
                            });
                          },
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.width / 4,
                        padding: EdgeInsets.only(
                            bottom: 10.0, left: 5.0, right: 5.0),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                          color: Colors.black87,
                          child: Text(
                            'C',
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.0),
                          ),
                          onPressed: () {
                            setState(() {
                              result = '0';
                            });
                          },
                        )),
                    Container(
                        height: MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.width / 4,
                        padding: EdgeInsets.only(
                            bottom: 10.0, left: 5.0, right: 5.0),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                          color: Colors.black87,
                          child: Icon(
                            Icons.content_cut,
                            color: Colors.white,
                            size: 25.0,
                          ),
                          onPressed: () {
                            setState(() {
                              result = result.length < 1
                                  ? result = '0'
                                  : result.substring(0, result.length - 1);
                            });
                          },
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget button(String number) {
    String num = number;
    return Container(
        height: MediaQuery.of(context).size.height / 8,
        width: MediaQuery.of(context).size.width / 4,
        padding: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),

          color: Colors.black87,
          child: Text(
            num,
            style: TextStyle(color: Colors.white, fontSize: 25.0),
          ),

          //minWidth: 50.0,
          onPressed: () {
            String x = num;
            setState(() {
              if ((result.endsWith('+') ||
                      result.endsWith('-') ||
                      result.endsWith('x') ||
                      result.endsWith('/')) &&
                  (x == '+' || x == '-' || x == '/' || x == 'x')) {
                result = result;
              } else if (x == '.') {
                List string = result.split(RegExp(r"['+', '\-', '/', 'x']"));
                var m = string[string.length - 1].toString();
                if (m.contains('.')) {
                  result = result;
                } else {
                  result = result + '.';
                }
              } else if (result.length == 1 && result.endsWith('0')) {
                if (x == 'x' || x == '/') {
                  result = result;
                } else {
                  result = x;
                }
              } else {
                result = result.length < 30 ? result + x : result;
              }
            });
          },
        ));
  }
}
