import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentIndex = 0;
  int _score = 0;
  int _remainingTime = 30;
  late Timer _timer;

  static const List<String> questions = [
    'What is the plural of "child"?',
    'What is the past tense of "run"?',
    'What is the superlative form of "good"?',
    'What is a synonym for "happy"?',
    'What is a homophone for "blue"?',
    'What is a preposition?',
    'What is an antonym for "big"?',
    'What is a synonym for "beautiful"?',
    'What is a simile?',
    'What is a verb?',
    'What is a collective noun for a group of birds?',
    'Which word is a pronoun: "he", "jump", or "book"?',
    'What is a gerund?',
    'What is a contraction for "I am"?'
  ];

  static const List<List<String>> options = [
    ['Childs', 'Children', 'Childes', 'Childies'],
    ['Ran', 'Runned', 'Runned', 'Ran'],
    ['Better', 'Best', 'Goodest', 'Gooder'],
    ['Sad', 'Glad', 'Mad', 'Bad'],
    ['Blew', 'Blewes', 'Blewed', 'Blue'],
    ['A type of verb', 'A type of noun', 'A type of adjective', 'A type of pronoun'],
    ['Small', 'Little', 'Tiny', 'Narrow'],
    ['Pretty', 'Ugly', 'Plain', 'Attractive'],
    ['A figure of speech', 'A type of noun', 'A type of verb', 'A type of adjective'],
    ['A type of noun', 'A type of verb', 'A type of adjective', 'A type of pronoun'],
    ['Flock', 'Herd', 'School', 'Pack'],
    ['He', 'Jump', 'Book'],
    ['A type of verb', 'A type of noun', 'A type of adjective', 'A type of pronoun'],
    ['I\'m', 'I\'ve', 'I\'d', 'I\'am']
  ];

  static const List<int> answers = [
    1, 0, 1, 1, 2, 2, 1, 0, 3, 1, 0, 0, 0, 0
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer.cancel();
          _showResultDialog();
        }
      });
    });
  }

  void _showResultDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Quiz results'),
            content: Text('You scored $_score out of ${questions.length}'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _checkAnswer(int selectedIndex) {
    if (selectedIndex == answers[_currentIndex]) {
      setState(() {
        _score++;
      });
    }

    if (_currentIndex < questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      _timer.cancel();
      _showResultDialog();
    }
  }

  void _goToNextQuestion() {
    if (_currentIndex < questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  void _goToPreviousQuestion() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'Time remaining: $_remainingTime seconds',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[200],
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    questions[_currentIndex],
                    style: TextStyle(fontSize: 20.0),
                  ),
                  ...options[_currentIndex]
                      .asMap()
                      .entries
                      .map(
                        (entry) => ElevatedButton(
                      child: Text(
                        entry.value,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      onPressed: () {
                        _checkAnswer(entry.key);
                      },
                    ),
                  )
                      .toList(),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_currentIndex > 0)
                        ElevatedButton(
                          child: Text('Previous'),
                          onPressed: _goToPreviousQuestion,
                        ),
                      Text(
                        'Question ${_currentIndex + 1} of ${questions.length}',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      if (_currentIndex < questions.length - 1)
                        ElevatedButton(
                          child: Text('Next'),
                          onPressed: _goToNextQuestion,
                        ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Score: $_score / ${_currentIndex + 1}',
                    style: TextStyle(fontSize: 18.0),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}