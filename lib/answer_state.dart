// import 'dart:math';

enum Answered { right, wrong, nothing }

class Solution {
  final String english;
  final String arabic;
  final Answered answered;
  Solution({
    required this.english,
    required this.arabic,
    required this.answered,
  });
}

class AnswerState {
  int right = 0;
  int wrong = 0;
  int timesUp = 0;
  List<Solution> solutions = [];
  addSolution({
    required String english,
    required String arabic,
    required Answered answered,
  }) {
    solutions
        .add(Solution(answered: answered, arabic: arabic, english: english));
    // print(english);
    // print(solutions);
  }
}
