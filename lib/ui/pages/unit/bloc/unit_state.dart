part of 'unit_bloc.dart';

abstract class UnitState extends Equatable{
  const UnitState();
  @override
  List<Object> get props => [];
}
class Uninitialized extends UnitState{}

class Success extends UnitState{
  final List<Unit> result ;
  const Success({required this.result});
}

class Failure extends UnitState{
  final String message;
  const Failure(this.message);
}
class Loading extends UnitState{
  const Loading();
}