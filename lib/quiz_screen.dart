import 'package:flutter_simple_quiz_app/question_model.dart';

class QuizBrain {
  int _questionNumber = 0;
  List<Question> _questionBank = [];
  void insertquestion(String a, bool b) {
    _questionBank.add(Question(a, b));
    _questionBank.shuffle();
  }

  void resetlist() {
    _questionBank.clear();
  }

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String? getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool? getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  Function? reset() {
    _questionNumber = 0;
  }
}
