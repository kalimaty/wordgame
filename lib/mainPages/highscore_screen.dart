// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:wordgame/hive_object/player_score.dart';

import '../answer_state.dart';

class HighScoreScreen extends StatefulWidget {
  final AnswerState answerState;
  const HighScoreScreen({Key? key, required this.answerState})
      : super(key: key);

  @override
  State<HighScoreScreen> createState() => _HighScoreScreenState();
}

class _HighScoreScreenState extends State<HighScoreScreen> {
  Box<PlayerScore> scoreBox = Hive.box<PlayerScore>(SCORE_BOXS);
// final Controller c = Get.put(Controller());
  List<PlayerScore> top5 = [];

  Map<dynamic, PlayerScore> deletedBox = {};
  List<Solution> solutionsBin = [];
  // Map<dynamic, Solution> deletedBox = {};
  undoReset() async {
    await scoreBox.putAll(deletedBox);
    widget.answerState.solutions = solutionsBin;
    top5update();
  }

  resetScores() async {
    for (Solution a in widget.answerState.solutions) {
      solutionsBin.add(a);
    }

    scoreBox.toMap().forEach((key, value) {
      deletedBox[key] = value;
    });
    await scoreBox.clear();
    if (widget.answerState.solutions.isNotEmpty)
      widget.answerState.solutions.clear();
    top5update();
  }

  top5update() {
    List<PlayerScore> emptyLP = [];
    scoreBox.toMap().forEach((key, value) {
      emptyLP.add(value);
    });

    emptyLP = emptyLP..sort((a, b) => b.score.compareTo(a.score));
    if (emptyLP.length < 5) {
      top5 = emptyLP.sublist(0, emptyLP.length);
    } else {
      // حد اقصى 5 لاعبين فقط
      top5 = emptyLP.sublist(0, 5);
    }

    setState(() {});
  }

  resetConfirmation() async {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            content: Text(
              "If you reset data you will lose all data from both Leaderboard and Highscore. Are you Sure you want to delete all data?",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              OutlinedButton(
                onPressed: () {
                  resetScores();
                  Navigator.of(dialogContext).pop();
                },
                child: Text("Confirm"),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: Text("Cancel"),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    top5update();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF58627a),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF222941),
        actions: [
          InkWell(
            onTap: () {
              if (scoreBox.isNotEmpty) {
                resetConfirmation();
              } else {
                undoReset();
              }
              setState(() {});
            },
            child: scoreBox.isNotEmpty ? Icon(Icons.delete) : Icon(Icons.undo),
          ),
        ],
        title: Text("High Scores"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Top 5 only",
            style: TextStyle(
              color: Colors.yellow,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "Rank",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ...top5.map((e) {
                    int index = top5.indexWhere((p) => p == e);
                    return Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }).toList()
                ],
              ),
              Column(
                children: [
                  Text(
                    "Name",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ...top5.map((e) {
                    return Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        e.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }).toList()
                ],
              ),
              Column(
                children: [
                  Text(
                    "Date",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ...top5.map((e) {
                    return Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        e.date,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }).toList()
                ],
              ),
              Column(
                children: [
                  Text(
                    "Score",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ...top5.map((e) {
                    return Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        "${e.score}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }).toList()
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
