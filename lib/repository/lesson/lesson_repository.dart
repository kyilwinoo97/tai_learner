import 'dart:convert';

import 'package:flutter/services.dart';

import '../../data/model/Lesson.dart';

abstract class ILessonRepository{
  Future<List<Lesson>> getLesson();
}
class LessonRepository extends ILessonRepository{
  @override
  Future<List<Lesson>> getLesson() async{
    final String response = await rootBundle.loadString('assets/data/lesson_unit1.json');
    final data = await json.decode(response) as List;
    List<Lesson> lst = [];
    for (var element in data) {
      lst.add(Lesson.fromJson(element));
    }
    return lst;
  }

}