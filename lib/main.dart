import "package:flutter/material.dart";
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/hive_flutter.dart';
// import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'hive_object/player_score.dart';
import 'mainPages/MainGamePage.dart';
import 'mainPages/loginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PlayerScoreAdapter());
  await Hive.openBox<PlayerScore>(SCORE_BOXS);
//  var a = await Hive.openBox<PlayerScore>(SCORE_BOXS);
  runApp(Navigate());
}

class Navigate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   SfGlobalLocalizations.delegate
      // ],
      // supportedLocales: const [
      //   Locale('en'),
      //   Locale('tr'),
      // ],
      // locale: const Locale('tr'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      getPages: [
        GetPage(name: "/", page: () => LoginPage_Body()),
        GetPage(name: "/mainPage", page: () => MaingamePage())
      ],
    );
  }
}
