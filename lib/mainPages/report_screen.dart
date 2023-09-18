import 'package:flutter/material.dart';

import '../answer_state.dart';
// import '../items.dart';

class ReportScreen extends StatelessWidget {
  final AnswerState answerState;
  const ReportScreen({Key? key, required this.answerState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isClean = answerState.solutions.length == 0;
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 111, 109, 68),
          title: Text("Report Screen"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                ReportElement(
                  constraints: constraints,
                  name: 'Total Quiz',
                  value: '${answerState.solutions.length}',
                ),
                ReportElement(
                  constraints: constraints,
                  name: 'Score',
                  value: '${isClean ? 0 : answerState.right * 10}',
                ),
                ReportElement(
                  constraints: constraints,
                  name: 'Correct Answer',
                  value:
                      '${isClean ? 0 : answerState.right}/${answerState.solutions.length}',
                ),
                ReportElement(
                  constraints: constraints,
                  name: 'Incorrect Answer',
                  value:
                      '${isClean ? 0 : answerState.wrong}/${answerState.solutions.length}',
                ),
                ReportElement(
                  constraints: constraints,
                  name: "Time's Up",
                  value:
                      '${isClean ? 0 : answerState.timesUp}/${answerState.solutions.length}',
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class ReportElement extends StatelessWidget {
  final BoxConstraints constraints;
  final String name;
  final String value;
  const ReportElement({
    Key? key,
    required this.constraints,
    required this.name,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.amber.shade100),
      margin: EdgeInsets.all(20),
      height: constraints.maxHeight * 0.12,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 20,
                color: Colors.purple,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
