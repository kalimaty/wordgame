import 'dart:math';

import 'package:get/get.dart';

import 'Arrays/WordArrays.dart';

class Items {
  List<Item> items = [];

  generate() {
    for (int i = 0; i < wordArrayTr.length; i++) {
      Item item = Item(i);
      item.getOptions();
      items.add(item);
    }
  }
}

class Item {
  final int index;
  List<RxString> options = [];
  Item(this.index);
  RxString get trans => wordArrayTr[index].obs;
  RxString get eng => wordArrayEng[index].obs;
  String get image => imageArray[index];
  String get sound => soundArray[index];

  getOptions() {
    Random random = Random();
    var head = eng;

    var remains = [
      'apples',
      'banana',
      'bear',
      'bird',
      'box',
      'onion',
      'orange',
      'pen',
    ];

    remains.remove(head.toString());

    var op1 = remains[random.nextInt(remains.length)].obs;
    remains.remove(op1.toString());

    var op2 = remains[random.nextInt(remains.length)].obs;
    remains.remove(op2.toString());

    var op3 = remains[random.nextInt(remains.length)].obs;

    List<RxString> _options = [head, op1, op2, op3];
    _options.shuffle();
    options = _options;
  }
}
