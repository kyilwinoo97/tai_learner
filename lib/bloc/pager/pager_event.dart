part of 'pager_bloc.dart';
class PagerEvent extends Equatable{
  PagerEvent();
  @override
  List<Object> get props => [];
}
class Next extends PagerEvent{
  int pageLength;
  Next(this.pageLength);
}
class Previous extends PagerEvent{
  Previous();
}