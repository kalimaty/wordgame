import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wordgame/hive_object/player_score.dart';

import '../answer_state.dart';
// import 'package:syncfusion_flutter_core/src/slider_controller.dart';

class LeaderBoard extends StatefulWidget {
  final AnswerState answerState;

  const LeaderBoard({super.key, required this.answerState});
  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  Box<PlayerScore> scoreBox = Hive.box<PlayerScore>(SCORE_BOXS);

  List<PlayerScore> top5 = [];

  Map<dynamic, PlayerScore> deletedBox = {};

  bool expandedButton = true;
  List<Solution> solutionsBin = [];

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
      // backgroundColor: Color(0xFF24413d),
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green),
        // backgroundColor: Color(0xFF3a6a74),
        backgroundColor: Colors.amberAccent,
        title: Text(
          "Leaderboard",
          style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<PlayerScore>(SCORE_BOXS).listenable(),
          builder: (context, Box<PlayerScore> box, child) {
            return DefaultTextStyle(
              style: TextStyle(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        expandedButton
                            ? InkWell(
                                onTap: () {
                                  expandedButton = false;
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.more_horiz_rounded,
                                  color: Colors.white,
                                ),
                              )
                            : box.isNotEmpty
                                ? InkWell(
                                    onTap: () {
                                      resetConfirmation();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text("Reset"),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      undoReset();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text("Undo"),
                                    ),
                                  ),
                        // PopupMenuButton(
                        //     icon: Icon(
                        //       Icons.more_horiz_rounded,
                        //       color: Colors.white,
                        //     ),
                        //     itemBuilder: (context) {
                        //       return box.isNotEmpty
                        //           ? [
                        //               PopupMenuItem(
                        //                 onTap: () {
                        //                   resetConfirmation();
                        //                 },
                        //                 height: 10,
                        //                 child: Text("Reset"),
                        //               ),
                        //             ]
                        //           : [
                        //               PopupMenuItem(
                        //                 onTap: () {
                        //                   undoReset();
                        //                 },
                        //                 height: 10,
                        //                 child: Text("Undo"),
                        //               ),
                        //             ];
                        //     }),
                      ],
                    ),
                    Expanded(child: ChartScreen(playerScores: top5))
                  ],
                ),
              ),
            );
          }),
    );
  }
}

// ignore: must_be_immutable
class ChartScreen extends StatelessWidget {
  ChartScreen({required this.playerScores});
  final List<PlayerScore> playerScores;
  TooltipBehavior tooltipBehavior = TooltipBehavior(enable: true);
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      legend: Legend(
        isVisible: true,
        textStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      tooltipBehavior: tooltipBehavior,
      title: ChartTitle(
        text: "Scores in subjects",
        textStyle: TextStyle(color: Colors.white),
      ),
      // primaryYAxis: CategoryAxis(
      //   labelStyle: TextStyle(color: Colors.white),
      //   title: AxisTitle(
      //     text: 'Score',
      //     textStyle: TextStyle(
      //         color: Colors.white,
      //         fontStyle: FontStyle.italic,
      //         fontWeight: FontWeight.bold,
      //         fontSize: 16),
      //   ),
      // ),

      primaryXAxis: CategoryAxis(
        labelStyle: TextStyle(color: Colors.white),
        labelAlignment: LabelAlignment.center,
        title: AxisTitle(
          text: 'Name',
          textStyle: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
      primaryYAxis: NumericAxis(
        labelStyle: TextStyle(color: Colors.white),
        maximum: 100,
      ),
      series: <ChartSeries>[
        StackedColumnSeries<PlayerScore, String>(
            dataSource: playerScores,
            xValueMapper: (PlayerScore playerScore, int index) {
              return playerScore.name;
            },
            yValueMapper: (PlayerScore playerScore, int index) {
              return 100 * (playerScore.score / playerScore.examNumber);
            },
            name: "Score in Percent",
            color: Colors.blue),
      ],
    );
  }
}
