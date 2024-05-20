part of 'lesson_bloc.dart';
class LessonEvent extends Equatable{
  const LessonEvent();
  @override
  List<Object> get props => [];
}

class GetLesson extends LessonEvent{
  const GetLesson();
}
