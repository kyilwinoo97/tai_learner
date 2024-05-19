part of 'pager_bloc.dart';

abstract class PagerState extends Equatable{
  int pageCount = 0;
   PagerState(this.pageCount);
  @override
  List<Object> get props => [pageCount];
}
class UnInitialState extends PagerState{
  UnInitialState(super.pageCount);
}

class PagerSuccess extends PagerState{
  PagerSuccess(super.pageCount);
}
class PagerFinish extends PagerState{
  PagerFinish(super.pageCount);
}

