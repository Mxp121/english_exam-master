import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    'What is the plural of "goose"?',
    'What is the past tense of "eat"?',
    'What is the opposite of "hot"?',
    'What is the capital of Canada?',
    'What is the largest ocean in the world?',
    'Which planet is known as the "Red Planet"?',
    'What is the highest mountain in the world?',
    'What is the smallest country in the world?',
    'Who wrote "The Great Gatsby"?',
    'What is the chemical symbol for gold?',
    'Who is the founder of Amazon?',
    'What is the currency of Japan?',
    'What is the largest country in the world?',
    'Who painted the Mona Lisa?',
    'What is the smallest planet in our solar system?',
    'What is the most abundant gas in Earth\'s atmosphere?',
    'Which two elements make up water?',
    'What is the boiling point of water in degrees Celsius?',
    'What is the formula for the area of a circle?',
    'Who is the current Prime Minister of the United Kingdom?',
    'What is the tallest mammal in the world?',
    'What is the largest animal in the world?',
    'What is the smallest mammal in the world?',
    'What is the fastest land animal in the world?',
    'What is the largest bird in the world?',
    'What is the longest river in the world?',
    'Who discovered penicillin?',
    'What is the name of the biggest desert in the world?',
    'What is the name of the smallest ocean in the world?',
    'What is the name of the imaginary line that divides the Earth into the Northern and Southern Hemispheres?'
  ];

  static const List<List<String>> options = [
    ['Geese', 'Geeses', 'Gooses', 'Gooseys'],
    ['Ate', 'Eaten', 'Eated', 'Eat'],
    ['Cold', 'Warm', 'Mild', 'Cool'],
    ['Toronto', 'Ottawa', 'Montreal', 'Vancouver'],
    ['Atlantic', 'Indian', 'Pacific', 'Arctic'],
    ['Mars', 'Venus', 'Mercury', 'Jupiter'],
    ['Mount Everest', 'K2', 'Kangchenjunga', 'Lhotse'],
    ['Vatican City', 'Monaco', 'Nauru', 'Tuvalu'],
    ['F. Scott Fitzgerald', 'Ernest Hemingway', 'John Steinbeck', 'William Faulkner'],
    ['Au', 'Ag', 'Cu', 'Fe'],
    ['Jeff Bezos', 'Bill Gates', 'Mark Zuckerberg', 'Steve Jobs'],
    ['Yen', 'Dollar', 'Euro', 'Pound'],
    ['Russia', 'China', 'USA', 'Canada'],
    ['Leonardo da Vinci', 'Michelangelo', 'Raphael', 'Vincent van Gogh'],
    ['Mercury', 'Mars', 'Venus', 'Pluto'],
    ['Nitrogen', 'Oxygen', 'Carbon dioxide', 'Argon'],
    ['Hydrogen and Oxygen', 'Carbon and Oxygen', 'Nitrogen and Oxygen', 'Hydrogen and Nitrogen'],
    ['100', '212', '0', '-273'],
    ['πr²', '2πr', '2πr²', 'πr'],
    ['Boris Johnson', 'Theresa May', 'David Cameron', 'Tony Blair'],
    ['Giraffe', 'Elephant', 'Whale', 'Hippopotamus'],
    ['Blue whale', 'African elephant', 'Giraffe', 'Saltwater crocodile'],
    ['Bumblebee bat', 'Mouse lemur', 'Pygmy marmoset', 'Etruscan shrew'],
    ['Cheetah', 'Lion', 'Leopard', 'Tiger'],
    ['Ostrich', 'Emu', 'Condor', 'Albatross'],
    ['Nile', 'Amazon', 'Yangtze', 'Mississippi'],
    ['Alexander Fleming', 'Marie Curie', 'Albert Einstein', 'IsaacNewton'],
    ['Sahara', 'Arabian', 'Gobi', 'Kalahari'],
    ['Southern', 'Arctic', 'Indian', 'Antarctic'],
    ['Equator', 'Prime Meridian', 'Tropic of Cancer', 'Tropic of Capricorn']
  ];

  static const List<int> answers = [
    0, 0, 2, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 2, 0, 0, 1, 1, 2, 0, 2, 0, 0, 0, 1, 3
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
                      .toList()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}