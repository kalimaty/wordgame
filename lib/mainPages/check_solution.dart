import 'package:flutter/material.dart';

import '../answer_state.dart';
import '../bubble_background.dart';
// import '../items.dart';

class CheckSolution extends StatefulWidget {
  final AnswerState answerState;
  const CheckSolution({Key? key, required this.answerState}) : super(key: key);

  @override
  State<CheckSolution> createState() => _CheckSolutionState();
}

class _CheckSolutionState extends State<CheckSolution> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFF122522),
      backgroundColor: Colors.yellow.shade100,
      appBar: AppBar(
        backgroundColor: Color(0xFF18172d),
        title: Text("Solution"),
        actions: [
          InkWell(
            onTap: () {
              widget.answerState.solutions.clear();
              setState(() {});
              // widget.answerState.solutions.forEach((element) { })
            },
            child: Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: widget.answerState.solutions
                .map((Solution e) => FractionallySizedBox(
                      widthFactor: 0.8,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BubbleBackground(
                              colors: e.answered == Answered.right
                                  ? [
                                      Colors.green,
                                      Colors.green,
                                    ]
                                  : e.answered == Answered.wrong
                                      ? [Colors.redAccent, Colors.redAccent]
                                      : [Colors.teal, Colors.teal],
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  "Arabic: ${e.arabic}",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BubbleBackground(
                              colors: [Color(0xFF805e39), Color(0xFF481e31)],
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  "English: ${e.english}",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
