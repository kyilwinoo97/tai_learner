import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/Lesson.dart';
import '../../repository/lesson/lesson_repository.dart';


part 'lesson_event.dart';

part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  ILessonRepository repository;
  LessonBloc(this.repository) : super(UnInitialState()) {
    on<GetLesson>(_getlesson);
  }

  FutureOr<void> _getlesson(GetLesson event, Emitter<LessonState> emit) async{
    emit(Loading());
    List<Lesson> result = await repository.getLesson();

    if (result.isNotEmpty) {
      emit(Success(result));
    } else {
      emit(Failure("no unit item"));
    }
  }
}
