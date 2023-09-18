import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wordgame/hive_object/player_score.dart';
import 'package:wordgame/mainPages/report_screen.dart';
import 'package:pie_chart/pie_chart.dart';
import '../answer_state.dart';
import '../items.dart';
import 'check_solution.dart';
import 'highscore_screen.dart';
import 'leaderboard.dart';
import 'loginPage.dart';

class ScoreScreen extends StatefulWidget {
  final AnswerState answerState;
  final Items items;
  const ScoreScreen({
    Key? key,
    required this.answerState,
    required this.items,
  }) : super(key: key);

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  String? name;
  late LeaderBoard leaderboard;
  Box<PlayerScore> scoreBox = Hive.box<PlayerScore>(SCORE_BOXS);

  @override
  void initState() {
    leaderboard = LeaderBoard(
      answerState: widget.answerState,
    );
    super.initState();
  }

  askForName(context, int score, int examNumber) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState2) {
            return AlertDialog(
              content: TextField(
                onChanged: (value) {
                  setState2(
                    () {
                      name = value;
                    },
                  );
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: 'Enter your Name',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (name != null) {
                      if (name!.isNotEmpty) {
                        await setPlayerScore(
                            name: name!, score: score, examNumber: examNumber);
                      }
                      setState(() {});
                      Navigator.of(context).pop();
                    } else {}
                  },
                  child: Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      if (name == null)
        askForName(context, widget.answerState.right * 10,
            widget.items.items.length * 10);
    });
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        // backgroundColor: Color(0xFF476767),
        title: Text("Score Screen"),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 10,
              ),

              DefaultTextStyle(
                style: TextStyle(color: Colors.white),
                child: PieChart(
                  dataMap: {
                    "Right": widget.answerState.right.toDouble(),
                    "Time's up": widget.answerState.timesUp.toDouble(),
                    "Wrong": widget.answerState.wrong.toDouble(),
                  },
                  animationDuration: Duration(milliseconds: 800),
                  chartLegendSpacing: 28,
                  chartRadius: MediaQuery.of(context).size.width / 2,
                  colorList: [
                    Colors.green,
                    Colors.tealAccent,
                    Colors.redAccent
                  ],
                  initialAngleInDegree: 0,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 10,
                  centerText:
                      "Score ${widget.answerState.right * 10}/${widget.items.items.length * 10}",
                  legendOptions: LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.bottom,
                    showLegends: true,
                    legendShape: BoxShape.circle,
                    legendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  chartValuesOptions: ChartValuesOptions(
                    showChartValueBackground: true,
                    showChartValues: true,
                    showChartValuesInPercentage: true,
                    showChartValuesOutside: false,
                    decimalPlaces: 1,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),

              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: MaterialButton(
                  height: constraints.maxHeight * 0.1,
                  minWidth: constraints.maxWidth * 0.6,
                  color: Color.fromARGB(255, 214, 92, 17),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CheckSolution(
                          answerState: widget.answerState,
                        ),
                      ),
                    );
                  },
                  child: Text("Check Solution"),
                ),
              ),
              SizedBox(
                height: 15,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: MaterialButton(
                      height: constraints.maxHeight * 0.1,
                      minWidth: constraints.maxWidth * 0.4,
                      color: Color(0xFF899390),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LeaderBoard(
                              answerState: widget.answerState,
                            ),
                          ),
                        );
                      },
                      child: Text("LeaderBoard"),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: MaterialButton(
                      height: constraints.maxHeight * 0.1,
                      minWidth: constraints.maxWidth * 0.4,
                      color: Color(0xFF899390),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HighScoreScreen(
                              answerState: widget.answerState,
                            ),
                          ),
                        );
                      },
                      child: Text("Heigh Scores"),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: MaterialButton(
                      height: constraints.maxHeight * 0.1,
                      minWidth: constraints.maxWidth * 0.4,
                      color: Color(0xFF899390),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ReportScreen(
                              answerState: widget.answerState,
                            ),
                          ),
                        );
                      },
                      child: Text("Report"),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: MaterialButton(
                      height: constraints.maxHeight * 0.1,
                      minWidth: constraints.maxWidth * 0.4,
                      color: Color(0xFF899390),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginPage_Body()),
                            (route) => false);
                      },
                      child: Text("Home"),
                    ),
                  ),
                ],
              ),
              // Container(),
            ],
          ),
        );
      }),
    );
  }

  setPlayerScore({
    required String name,
    required int score,
    required int examNumber,
  }) {
    var date = DateTime.now();
    int year = date.year;
    int month = date.month;
    int day = date.day;
    String hour =
        "${date.hour > 11 ? date.hour - 12 : date.hour}${date.hour > 11 ? "pm" : "am"}";

    String dateOfPlaying = "$year-${months[month - 1]}-$day-$hour";
    scoreBox.put(
        name,
        PlayerScore(
            name: name,
            score: score,
            examNumber: examNumber,
            date: dateOfPlaying));
  }
}

const List months = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];
