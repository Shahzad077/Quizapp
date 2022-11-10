import 'package:flutter/material.dart';
import 'package:flutter_simple_quiz_app/result.dart';

import 'quiz_screen.dart';

QuizBrain quizBrain = QuizBrain();
int correct = 0;
int wrong = 0;

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: start(),
    );
  }
}

class start extends StatefulWidget {
  const start({Key? key}) : super(key: key);

  @override
  State<start> createState() => _startState();
}

class _startState extends State<start> {
  final questionTextController = TextEditingController();
  final answerTextController = TextEditingController();
  String questionText = "";
  bool questionAnswer = true;
  bool button = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Quiz App',
            style: TextStyle(color: Colors.white),
          ),

          backgroundColor: Colors.black, //<-- SEE HERE
        ),
        body: Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Text(
                        "Enter your Question in treue false Answer",
                        style: TextStyle(color: Colors.white, fontSize: 26),
                      ),
                    ),
                    TextField(
                      controller: questionTextController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3,
                                color: Colors.greenAccent), //<-- SEE HERE
                          ),
                          hintText: "Enter Your Question?",
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: TextField(
                        controller: answerTextController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3,
                                  color: Colors.greenAccent), //<-- SEE HERE
                            ),
                            hintText: "Enter Your Answer.",
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60, //height of button
                      width: double.infinity,
                      color: Colors.blue, //width of button
                      child: MaterialButton(
                        onPressed: () {
                          questionAnswer = true;
                          bool answer = answerTextController.text == 'true';
                          quizBrain.insertquestion(
                              questionTextController.text, answer);
                          questionTextController.clear();
                          answerTextController.clear();
                          setState(() {
                            button = true;
                          });
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    button == false
                        ? SizedBox(
                            height: 0,
                          )
                        : Container(
                            height: 70, //height of button
                            width: double.infinity, //width of button
                            color: Colors.green, //width of button
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QuizPage()),
                                );
                              },
                              child: const Text(
                                'Start Quiz',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                  ]),
            )));
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  void checkAnswer(bool userPickedAnswer) {
    bool? correctAnswer = quizBrain.getCorrectAnswer();
    setState(() {
      if (quizBrain.isFinished() == true) {
        if (userPickedAnswer == correctAnswer) {
          correct++;
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          wrong++;
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Result(correct, pressed)),
        );
        quizBrain.reset();
        scoreKeeper = [];
        correct = 0;
        wrong = 0;
      }

      //TODO: Step 6 - If we've not reached the end, ELSE do the answer checking steps below 👇
      else {
        if (userPickedAnswer == correctAnswer) {
          correct++;
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          wrong++;
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Quiz APP"),
          backgroundColor: Colors.black, //<-- SEE HERE
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 40,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      quizBrain.getQuestionText().toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      color: Colors.green,
                      height: 70, //height of button
                      width: 300,
                      child: MaterialButton(
                        child: Text(
                          'True',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Open Sans',
                              fontSize: 20),
                        ),
                        onPressed: () {
                          quizBrain.getQuestionText().toString();
                          checkAnswer(true);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      color: Colors.red,
                      height: 70, //height of button
                      width: 300,
                      child: MaterialButton(
                        child: Text(
                          'False',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Open Sans',
                              fontSize: 20),
                        ),
                        onPressed: () {
                          quizBrain.getQuestionText().toString();

                          checkAnswer(false);
                        },
                      ),
                    ),
                    Row(
                      children: scoreKeeper,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                )
              ]),
        ));
  }

  void pressed() {
    quizBrain.resetlist();
    scoreKeeper = [];
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => start()),
    );
  }
}
