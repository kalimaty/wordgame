import 'package:hive/hive.dart';

part 'player_score.g.dart';

const SCORE_BOXS = 'WordGameScoreBoxes2';

@HiveType(typeId: 0)
class PlayerScore {
  @HiveField(0)
  String name;
  @HiveField(1)
  int score;
  @HiveField(2)
  int examNumber;
  @HiveField(3)
  String date;
  PlayerScore(
      {required this.examNumber,
      required this.name,
      required this.score,
      required this.date});
}

// const ANSWER_BOX = 'WordGameAnswerBoxes';

// @HiveType(typeId: 1)
// class PlayerAnswer {
//   @HiveField(0)
//   String arabic;
//   @HiveField(1)
//   String english;
//   PlayerAnswer({
//     required this.arabic,
//     required this.english,
//   });
// }
