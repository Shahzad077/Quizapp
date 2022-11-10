import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetHandler;

  Result(this.resultScore, this.resetHandler);

  //Remark Logic
  String get resultPhrase {
    String resultText;
    if (resultScore >= 5) {
      resultText = 'You are awesome!';
      print(resultScore);
    } else if (resultScore >= 3) {
      resultText = 'Pretty likeable!';
      print(resultScore);
    } else if (resultScore >= 2) {
      resultText = 'You need to work more!';
    } else if (resultScore >= 1) {
      resultText = 'You need to work hard!';
    } else {
      resultText = 'This is a poor score!';
      print(resultScore);
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Result"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //Text
            Text(
              'Score ' '2',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ), //Text
            MaterialButton(
              child: Text(
                'Restart Quiz!',
                style: TextStyle(fontSize: 30, color: Colors.red),
              ), //Text
              textColor: Colors.white12,
              onPressed: () {
                resetHandler;
              },
            ), //FlatButton
          ], //<Widget>[]
        ),
      ), //Column
    ); //Center
  }
}
