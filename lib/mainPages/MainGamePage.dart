import 'package:get/get.dart';

import 'package:flutter/material.dart';

import 'package:wordgame/rotate_animation.dart';

import 'package:wordgame/sizes_helpers.dart';
import 'package:wordgame/pages/colors.dart';

import '../controller.dart';

class MaingamePage extends StatefulWidget {
  @override
  State<MaingamePage> createState() => _MaingamePageState();
}

class _MaingamePageState extends State<MaingamePage> {
  final Controller c = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    //  return WillPopScope(

    //   },
    return WillPopScope(
      onWillPop: () async {
        Get.delete<Controller>();
        // c.timerr.cancel();
        c.time -= c.time.toInt();

        // Get.back(result: true);
        // Get.offNamed("/");
        return true;
      },
//       onWillPop: () {
//       Controller(context);
//     },
//     void disposeController(BuildContext context){
// //or what you wnat to dispose/clear
//  Controller.dispose()
// }
      child: Scaffold(
          body: SafeArea(
              child: Container(
        padding: EdgeInsets.only(top: 0),
        margin: EdgeInsets.only(top: 0),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(c.backImage), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            // زر العودة للهوم بيج
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(25)),
              child: IconButton(
                  onPressed: () async {
                    // c.timerr.cancel();
                    c.time -= c.time.toInt();
                    // c.time += 12;
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) => loginPage_Body(),
                    //   ),
                    //   (route) => false,
                    // );
                    // Get.delete<Controller>();

                    //  Get.offAndToNamed("/");
                    Get.offNamed("/");
                  },
                  icon: Icon(Icons.home_filled, size: 50, color: Colors.white)),
            ),
            Padding(
              padding: EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // التايمر
                  Container(
                      width: displayWidth(context) * 0.3,
                      height: displayHeight(context) * 0.05,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: container5,
                          border: Border.all(width: 2, color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Obx(() => Text(
                              "TIME: ${c.time}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            )),
                      )),
                  // عداد النقاط  الاسكور
                  Container(
                    width: displayWidth(context) * 0.3,
                    height: displayHeight(context) * 0.05,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        color: container6,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Obx(() => Text(
                            "SCORE: ${c.score}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white),
                          )),
                    ),
                  )
                ],
              ),
            ),
            // الكلمة العربية  = السؤال
            c.anmState == AnmState.Start ||
                    c.anmState == AnmState.CompleteAll ||
                    c.anmState == AnmState.ArabicComplete ||
                    c.anmState == AnmState.Option1Complete ||
                    c.anmState == AnmState.Option2Complete ||
                    c.anmState == AnmState.Option3Complete
                // الكلمة العربية  = السؤال
                ? RotateTheWidget(
                    onEnd: () {
                      c.setAnmState = AnmState.ArabicComplete;
                      setState(() {});
                    },
                    needAnimate: c.needAnimateArabic,
                    // الكلمة العربية  = السؤال
                    child: Container(
                      width: displayWidth(context) * 0.6,
                      height: displayHeight(context) * 0.08,
                      color: container7,
                      // margin: EdgeInsets.only(top: 25),كتان متسبب فى كبر حكم الاختيارات
                      child: Center(
                          child: Obx(() => Text(
                                "${c.items.items[c.ranHead.toInt()].trans}",
                                //    "${c.fakeEn[c.ranHead.toInt()]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.white),
                              ))),
                    ),
                  )
                : SizedBox(),
            Expanded(
              child: GridView.count(
                padding: EdgeInsets.only(
                  top: 60,
                  left: 10,
                  right: 10,
                ),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                crossAxisCount: 2,
                children: [
                  c.anmState == AnmState.CompleteAll ||
                          c.anmState == AnmState.ArabicComplete ||
                          c.anmState == AnmState.Option1Complete ||
                          c.anmState == AnmState.Option2Complete ||
                          c.anmState == AnmState.Option3Complete
                      // الصورة والكلمة الاولى
                      ? RotateTheWidget(
                          onEnd: () {
                            c.setAnmState = AnmState.Option1Complete;
                            setState(() {});
                          },
                          needAnimate: c.needAnimateOption1,
                          child: GestureDetector(
                            onTap: c.anmState == AnmState.CompleteAll
                                ? () {
                                    c.selectControl(
                                        c.items.items[c.ranHead.toInt()]
                                            .options[0],
                                        context);
                                  }
                                : null,
                            child: Container(
                              decoration: BoxDecoration(
                                color: container1,
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all(width: 5, color: Colors.white),
                              ),
                              child: Column(children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Obx(
                                    () => Image.asset(
                                      'assets/${c.items.items[c.ranHead.toInt()].options[0]}.png',
                                      height: 100,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Obx(
                                    () => Text(
                                      // يبحث  عن  الكلمة  المناسبة تحت الصورة
                                      "${c.items.items[c.ranHead.toInt()].options[0]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        )
                      : SizedBox(),
                  c.anmState == AnmState.CompleteAll ||
                          c.anmState == AnmState.Option1Complete ||
                          c.anmState == AnmState.Option2Complete ||
                          c.anmState == AnmState.Option3Complete
                      // الصورة والكلمة الثانية
                      ? RotateTheWidget(
                          onEnd: () {
                            c.setAnmState = AnmState.Option2Complete;
                            setState(() {});
                          },
                          needAnimate: c.needAnimateOption2,
                          child: GestureDetector(
                            onTap: c.anmState == AnmState.CompleteAll
                                ? () {
                                    c.selectControl(
                                        c.items.items[c.ranHead.toInt()]
                                            .options[1],
                                        context);
                                  }
                                : null,
                            child: Container(
                              decoration: BoxDecoration(
                                color: container2,
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all(width: 5, color: Colors.white),
                              ),
                              // color: container2,
                              child: Column(children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Obx(
                                    () => Image.asset(
                                      'assets/${c.items.items[c.ranHead.toInt()].options[1]}.png',
                                      height: 100,
                                    ),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Obx(
                                      () => Text(
                                        "${c.items.items[c.ranHead.toInt()].options[1]}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20),
                                      ),
                                    )),
                              ]),
                            ),
                          ),
                        )
                      : SizedBox(),
                  c.anmState == AnmState.CompleteAll ||
                          c.anmState == AnmState.Option2Complete ||
                          c.anmState == AnmState.Option3Complete
                      // الصورة والكلمة الثالثة
                      ? RotateTheWidget(
                          onEnd: () {
                            c.setAnmState = AnmState.Option3Complete;
                            setState(() {});
                          },
                          needAnimate: c.needAnimateOption3,
                          child: GestureDetector(
                            onTap: c.anmState == AnmState.CompleteAll
                                ? () {
                                    // ارسال   بدائل الاجابة الى الدالة  selectControl
                                    c.selectControl(
                                        c.items.items[c.ranHead.toInt()]
                                            .options[2],
                                        context);
                                  }
                                : null,
                            child: Container(
                              // color: container3,
                              decoration: BoxDecoration(
                                color: container3,
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all(width: 5, color: Colors.white),
                              ),
                              child: Column(children: [
                                Container(
                                    padding: EdgeInsets.all(5),
                                    child: Obx(
                                      () => Image.asset(
                                        'assets/${c.items.items[c.ranHead.toInt()].options[2]}.png',
                                        height: 100,
                                      ),
                                    )),
                                Container(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Obx(
                                      () => Text(
                                        "${c.items.items[c.ranHead.toInt()].options[2]}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20),
                                      ),
                                    )),
                              ]),
                            ),
                          ))
                      : SizedBox(),
                  c.anmState == AnmState.CompleteAll ||
                          c.anmState == AnmState.Option3Complete
                      // الصورة والكلمة الرابعة
                      ? RotateTheWidget(
                          onEnd: () {
                            c.setAnmState = AnmState.CompleteAll;
                            setState(() {});
                          },
                          needAnimate: c.needAnimateOption4,
                          child: GestureDetector(
                            onTap: c.anmState == AnmState.CompleteAll
                                ? () {
                                    c.selectControl(
                                        c.items.items[c.ranHead.toInt()]
                                            .options[3],
                                        context);
                                  }
                                : null,
                            child: Container(
                              // color: container4,
                              decoration: BoxDecoration(
                                color: container4,
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all(width: 5, color: Colors.white),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(5),
                                      child: Obx(
                                        () => Image.asset(
                                          'assets/${c.items.items[c.ranHead.toInt()].options[3]}.png',
                                          height: 100,
                                        ),
                                      )),
                                  Container(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Obx(
                                      () => Text(
                                        "${c.items.items[c.ranHead.toInt()].options[3]}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      : SizedBox(),
                ],
              ),
            )
          ],
        ),
      ))),
    );
  }
}
