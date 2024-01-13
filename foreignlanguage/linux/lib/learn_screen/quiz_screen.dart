import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key, required this.questions}) : super(key: key);
  final List questions;

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // List<Map<String, dynamic>> questions = [
  //   {
  //     'answer': 'assume',
  //     'question': 'I _______ he is coming to the party tonight.',
  //     'options': ['assume', 'see', 'saw', 'electric'],
  //   },
  //   // Add more questions here...
  // ];
  int score = 0;
  int currentQuestionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(70, 130, 169, 1),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0),
          ),
        ),
        toolbarHeight: 90,
        flexibleSpace: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 80,
                width: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/logo.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.questions[currentQuestionIndex]['question'],
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20.0),
            ...List.generate(
              widget.questions[currentQuestionIndex]['options'].length,
                  (index) => ElevatedButton(
                onPressed: () => _checkAnswer(index),
                child: Text(
                    widget.questions[currentQuestionIndex]['options'][index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _checkAnswer(int selectedOptionIndex) {
    String correctAnswer = widget.questions[currentQuestionIndex]['answer'];
    String selectedAnswer =
    widget.questions[currentQuestionIndex]['options'][selectedOptionIndex];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        String result = 'Incorrect!';
        if (selectedAnswer == correctAnswer) {
          score += 1;
          result = 'Correct!';
        }
        return AlertDialog(
          title: const Text('Result'),
          content: Text(result),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _nextQuestion();
              },
              child: const Text('Next'),
            ),
          ],
        );
      },
    );
  }

  void _nextQuestion() {
    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Quiz Completed'),
            content: Text(
                'You have completed the quiz.\nYour score: $score/${widget.questions.length}'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }
}


