import 'package:flutter/material.dart';
import 'package:english_exam/Q.dart';
import 'Setting.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizLevelsScreen(),
    );
  }
}

class QuizLevelsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> quizLevels = [
    {
      'title': 'Beginner',
      'subtitle': 'Level 1-30 Questions',
      'color': Colors.blue,
      'progress': 0.5,
      'levels': [
        {'title': 'Level 1', 'subtitle': '1min'},
        {'title': 'Level 2', 'subtitle': '1min'},
        {'title': 'Level 3', 'subtitle': '1min'},
      ],
    },
    {
      'title': 'Intermediate',
      'subtitle': 'Level 2-30 Questions',
      'color': Colors.green,
      'progress': 0.2,
      'levels': [
        {'title': 'Level 1', 'subtitle': '2min'},
        {'title': 'Level 2', 'subtitle': '2min'},
        {'title': 'Level 3', 'subtitle': '2min'},
      ],
    },
    {
      'title': 'Advanced',
      'subtitle': 'Level 3-30 Questions',
      'color': Colors.red,
      'progress': 0.8,
      'levels': [
        {'title': 'Level 1', 'subtitle': '3min'},
        {'title': 'Level 2', 'subtitle': '3min'},
        {'title': 'Level 3', 'subtitle': '3min'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('English Quiz'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Text('Settings'),
                value: 'settings',
              ),
              PopupMenuItem(
                child: Text('About'),
                value: 'about',
              ),
              PopupMenuItem(
                child: Text('Exit'),
                value: 'exit',
              ),
            ],
            onSelected: (String value) {
              if (value == 'settings') {
              } else if (value == 'about') {
                // TODO: Implement about functionality
              } else if (value == 'exit') {
                // TODO: Implement exit functionality
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: quizLevels.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => QuizLevelScreen(
                    levelTitle: quizLevels[index]['title'],
                    levelSubtitle: quizLevels[index]['subtitle'],
                    levels: quizLevels[index]['levels'],
                  ),
                ));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                      color: quizLevels[index]['color'],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          quizLevels[index]['title'],
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          quizLevels[index]['subtitle'],
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50.0,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(4.0),
                        bottomRight: Radius.circular(4.0),
                      ),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${quizLevels[index]['progress']*100}% Complete',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: quizLevels[index]['color'],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class QuizLevelScreen extends StatelessWidget {
  final String levelTitle;
  final String levelSubtitle;
  final List<Map<String, String>> levels;

  QuizLevelScreen({
    required this.levelTitle,
    required this.levelSubtitle,
    required this.levels,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(levelTitle),
      ),
      body: Column(
        children: [
          Container(
            height: 150.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
              color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  levelTitle,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  levelSubtitle,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: levels.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => QuizPage()
                      ));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            levels[index]['title']!,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            levels[index]['subtitle']!,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class QuizScreen extends StatelessWidget {
  final String levelTitle;
  final String quizTitle;

  QuizScreen({required this.levelTitle, required this.quizTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$levelTitle - $quizTitle'),
      ),
      body: Center(
        child: Text('Quiz Screen'),
      ),
    );
  }
}