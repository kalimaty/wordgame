import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordgame/mainPages/loginPage.dart';
import 'package:wordgame/mainPages/score_screen.dart';
import 'package:wordgame/pages/colors.dart';
import 'package:wordgame/rotate_animation.dart';
import 'package:wordgame/sizes_helpers.dart';

import 'Arrays/WordArrays.dart';
import 'answer_state.dart';
import 'items.dart';

enum AnmState {
  Start,
  ArabicComplete,
  Option1Complete,
  Option2Complete,
  Option3Complete,
  CompleteAll
}

class Controller extends GetxController {
  late Timer timerr;
  var score = 0.obs;
  late Items items;
  increment() => score++;
  var time = 0.obs;
  var ranHead = 0.obs;
  late AudioPlayer player;
  AnswerState answerState = AnswerState();
  AnmState get anmState => _anmState;
  late AnmState _anmState;
  set setAnmState(AnmState e) {
    _anmState = e;
    update();
  }

  bool needAnimateArabic = true;
  bool needAnimateOption1 = true;
  bool needAnimateOption2 = true;
  bool needAnimateOption3 = true;
  bool needAnimateOption4 = true;

  // ignore: non_constant_identifier_names
  RandomHead() async {
    _anmState = AnmState.Start;
    needAnimateArabic = true;
    needAnimateOption1 = true;
    needAnimateOption2 = true;
    needAnimateOption3 = true;
    needAnimateOption4 = true;
    ranHead++; //انتقل للسؤال التالى
    Future.delayed(Duration(seconds: 3), () {
      player.setAsset(items.items[ranHead.toInt()].sound);
      player.play();
    });

    update();
  }

  late String backImage;
  var backImageList = [
    "assets/back/b1.jpg",
    "assets/back/b2.jpg",
    "assets/back/b3.jpg",
    "assets/back/b4.jpg",
    "assets/back/b5.jpg",
    "assets/back/b6.jpg"
  ].toList();

  selectControl(RxString eng, BuildContext context) {
    if (eng == items.items[ranHead.toInt()].eng
        // wordArrayEng[index].obs;
        ) {
      // عشان يظهر الاجابات  الصحيحة والخاطئة فى شاشة الحلول
      answerState.addSolution(
        english: items.items[ranHead.toInt()].eng.toString(),
        arabic: items.items[ranHead.toInt()].trans.toString(),
        answered: Answered.right,
      );

      timerr.cancel();
      // return showGeneralDialog(
      //     barrierColor: Colors.white.withOpacity(0.6),
      //     transitionBuilder: (context, a1, a2, widget) {
      //       return Transform.scale(
      //         scale: a1.value,
      //         child: Opacity(
      //           opacity: a1.value,
      //           child: AlertDialog(
      //             shape: OutlineInputBorder(
      //                 borderSide: BorderSide(color: Colors.white, width: 5),
      //                 borderRadius: BorderRadius.circular(16.0)),
      //             backgroundColor: Colors.green,
      //             title: Icon(Icons.check_circle_sharp,
      //                 color: Colors.white, size: 75),
      //             content: Container(
      //               height: displayHeight(context) * 0.07,
      //               child: Center(
      //                 child: Text(
      //                   "Congratulations!",
      //                   style: TextStyle(
      //                       fontWeight: FontWeight.bold,
      //                       color: Colors.white,
      //                       fontSize: 35),
      //                 ),
      //               ),
      //             ),
      //             actions: [
      //               IconButton(
      //                 icon: Icon(Icons.home_filled, color: Colors.white),
      //                 iconSize: 50,
      //                 onPressed: () {
      //                   //  saveHighScore(score);
      //                   //  scoreSave(0);
      //                   //  _saveHighScore(score.toInt());
      //                   Navigator.pushAndRemoveUntil(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (BuildContext context) => LoginPage_Body(),
      //                     ),
      //                     (route) => false,
      //                   );
      //                 },
      //               ),
      //               IconButton(
      //                 icon: Icon(Icons.arrow_right_alt_outlined,
      //                     color: Colors.white),
      //                 iconSize: 50,
      //                 onPressed: () async {
      //                   timerr.cancel();

      //                   var t = 12 - time.toInt();
      //                   answerState.right += 1;
      //                   time += t;
      //                   score += 10;
      //                   if (ranHead.toInt() + 1 < wordArrayTr.length) {
      //                     RandomHead();

      //                     // _saveScore();

      //                     // _getScore();
      //                     Navigator.pop(context);
      //                     Future.delayed(Duration(seconds: 3), () {
      //                       time_func();
      //                     });
      //                   } else {
      //                     // await _saveScore();
      //                     Navigator.of(context).pushAndRemoveUntil(
      //                         MaterialPageRoute(
      //                           builder: (context) => ScoreScreen(
      //                             items: items,
      //                             answerState: answerState,
      //                           ),
      //                         ),
      //                         (route) => false);
      //                   }
      //                 },
      //               ),
      //             ],
      //           ),
      //         ),
      //       );
      //     },
      //     transitionDuration: Duration(milliseconds: 200),
      //     barrierDismissible: true,
      //     barrierLabel: '',
      //     context: context,
      //     pageBuilder: (context, animation1, animation2) {
      //       return Container();
      //     });

      return showDialog(
          barrierDismissible: false,
          barrierColor: Colors.white.withOpacity(0.3),
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: displayHeight(context) * 0.4,
              child: RotateTheWidget(
                needAnimate: true,
                onEnd: () {
                  setAnmState = AnmState.CompleteAll;
                },
                child: AlertDialog(
                  actionsAlignment: MainAxisAlignment.center,
                  contentPadding: EdgeInsets.all(20),
                  // iconPadding: EdgeInsets.all(20),
                  // shape: OutlineInputBorder(
                  //     borderSide: BorderSide(color: Colors.white, width: 5),
                  //     borderRadius: BorderRadius.circular(25.0)),
                  backgroundColor: Colors.green,
                  shape: CircleBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 5,
                    ),
                  ),
                  title: Icon(
                    Icons.check_circle_sharp,
                    color: Colors.white,
                    size: 50,
                  ),
                  content: Container(
                    height: displayHeight(context) * 0.09,
                    width: displayWidth(context) * 0.07,
                    child: Center(
                      child: Text(
                        "Congratulations!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30),
                      ),
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.home_filled, color: Colors.white),
                      iconSize: 50,
                      onPressed: () {
                        //  saveHighScore(score);
                        //  scoreSave(0);
                        //  _saveHighScore(score.toInt());
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => LoginPage_Body(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_right_alt_outlined,
                          color: Colors.white),
                      iconSize: 50,
                      onPressed: () async {
                        timerr.cancel();

                        var t = 12 - time.toInt();
                        answerState.right += 1;
                        time += t;
                        score += 10;
                        if (ranHead.toInt() + 1 < wordArrayTr.length) {
                          RandomHead();

                          // _saveScore();

                          // _getScore();
                          Navigator.pop(context);
                          Future.delayed(Duration(seconds: 3), () {
                            time_func();
                          });
                        } else {
                          // await _saveScore();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => ScoreScreen(
                                  items: items,
                                  answerState: answerState,
                                ),
                              ),
                              (route) => false);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          });
    } else {
      answerState.addSolution(
          english: items.items[ranHead.toInt()].eng.toString(),
          arabic: items.items[ranHead.toInt()].trans.toString(),
          answered: Answered.wrong);
      timerr.cancel();
      return showGeneralDialog(
          barrierColor: Colors.black.withOpacity(0.6),
          transitionBuilder: (context, a1, a2, widget) {
            return Transform.scale(
              scale: a1.value,
              child: Opacity(
                opacity: a1.value,
                child: AlertDialog(
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 5),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  backgroundColor: Colors.red,
                  title: Icon(Icons.cancel, color: Colors.white, size: 75),
                  content: Container(
                    height: displayHeight(context) * 0.07,
                    child: Center(
                      child: Text(
                        "Unfortunately!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 35),
                      ),
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.home_filled, color: Colors.white),
                      iconSize: 50,
                      onPressed: () {
                        //  saveHighScore(score);
                        //  scoreSave(0);
                        //  _saveHighScore(score.toInt());
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => LoginPage_Body(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_right_alt_outlined,
                          color: Colors.white),
                      iconSize: 50,
                      onPressed: () async {
                        timerr.cancel();
                        answerState.wrong += 1;
                        var t = 12 - time.toInt();
                        time += t;
                        if (ranHead.toInt() + 1 < wordArrayTr.length) {
                          RandomHead();

                          // _saveScore();

                          // _getScore();
                          Navigator.pop(context);
                          Future.delayed(Duration(seconds: 3), () {
                            time_func();
                          });
                        } else {
                          // await _saveScore();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => ScoreScreen(
                                  items: items,
                                  answerState: answerState,
                                ),
                              ),
                              (route) => false);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          context: context,
          pageBuilder: (context, animation1, animation2) {
            return Container();
          });
    }
  }

  // Future _saveScore() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt("score", score.toInt());
  // }

  // Future _getScore() async {
  //   var tempScore;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   tempScore = prefs.getInt("score");
  //   return score.value = tempScore;
  // }

  // Future _resetScore() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt("score", 0);
  // }

  // ignore: non_constant_identifier_names
  time_func() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      time--;
      timerr = timer;
      // ignore: unrelated_type_equality_checks
      if (time == 0) {
        answerState.addSolution(
            english: items.items[ranHead.toInt()].eng.toString(),
            arabic: items.items[ranHead.toInt()].trans.toString(),
            answered: Answered.nothing);
        timer.cancel();
        Get.defaultDialog(
          backgroundColor: Colors.grey[850],
          radius: 20.0,
          title: " ",
          titleStyle: TextStyle(color: Colors.white),
          middleText: "Time's Up!!",
          middleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
          barrierDismissible: false,
          actions: [
            IconButton(
              icon: Icon(Icons.home_filled, color: Colors.white),
              iconSize: 50,
              onPressed: () {
                time -= time.toInt();
                time += 12;

                // _resetScore();

                Get.offAll(LoginPage_Body());
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_right_alt_outlined, color: Colors.green),
              iconSize: 50,
              onPressed: () async {
                timerr.cancel();
                answerState.timesUp += 1;
                var t = 12 - time.toInt();
                time += t;
                if (ranHead.toInt() + 1 < wordArrayTr.length) {
                  RandomHead();

                  // _saveScore();

                  // _getScore();

                  Get.back();
                  Future.delayed(Duration(seconds: 3), () {
                    time_func();
                  });
                } else {
                  // await _saveScore();
                  Get.to(
                    ScoreScreen(
                      items: items,
                      answerState: answerState,
                    ),
                  );
                }
              },
            )
          ],
        );
      }
    });
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }

  Future<void> onInit() async {
    _anmState = AnmState.Start;
    player = AudioPlayer();
    backImage = backImageList[Random().nextInt(6)];
    items = Items();
    items.generate();
    items.items.shuffle();
    time += 12;
    // _resetScore();
    randomColors();
    //  RandomHead();
    Future.delayed(Duration(seconds: 3), () {
      time_func();
      player.setAsset(items.items[ranHead.toInt()].sound);
      player.play();
    });

    // await player.setAsset(items.items[ranHead.toInt()].sound);
    // player.play();
    super.onInit();
  }
}
