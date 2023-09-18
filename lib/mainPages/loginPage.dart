import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:wordgame/sizes_helpers.dart';

// ignore: camel_case_types
class LoginPage_Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // _getScore();
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: displayHeight(context),
          width: displayWidth(context),
          decoration: BoxDecoration(
              //     image: DecorationImage(
              //   image: AssetImage(
              //     "assets/login.jpg",
              //   ),
              //   fit: BoxFit.cover,
              // )),)
              color: Colors.yellow.shade100),
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 90),
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        color: Colors.lightGreen.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(25)),
                    child: Text(
                      "WORD GAME",
                      style: TextStyle(fontSize: 50, color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 50),
                    width: displayWidth(context) * 0.3,
                    height: displayHeight(context) * 0.2,
                    decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(25)),
                    child: IconButton(
                      icon: Icon(
                        Icons.play_circle_outline,
                        color: Colors.white,
                        size: 90,
                      ),
                      onPressed: () {
                        Get.toNamed("/mainPage");
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 90),
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(25)),
                    child: Text(
                      "FaisalGame",
                      style: TextStyle(fontSize: 50, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
