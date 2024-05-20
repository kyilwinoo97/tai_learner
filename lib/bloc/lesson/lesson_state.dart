part of 'lesson_bloc.dart';

abstract class LessonState extends Equatable{
  LessonState();
  @override
  List<Object> get props => [];
}
class UnInitialState extends LessonState{
}
class Success extends LessonState{
  List<Lesson> lst;
  Success(this.lst);
}
class Failure extends LessonState{
  String message;
  Failure(this.message);
}
class Loading extends LessonState{
  Loading();
}


