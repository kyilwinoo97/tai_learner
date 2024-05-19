import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tai_learner/repository/unit/unit_repository.dart';

import '../../../../../data/model/Unit.dart';

part 'pager_event.dart';

part 'pager_state.dart';

class PagerBloc extends Bloc<PagerEvent, PagerState> {

  int currentIndex = 0;
  PagerBloc() : super(UnInitialState(0)) {
    on<Next>(_next);
    on<Previous>(_previous);
  }


  FutureOr<void> _next(Next event, Emitter<PagerState> emit) {
    currentIndex ++;
    if(currentIndex == event.pageLength - 1){
      emit(PagerFinish(currentIndex));

    }else{
      emit(PagerSuccess(currentIndex));

    }
  }

  FutureOr<void> _previous(Previous event, Emitter<PagerState> emit) {
    if(currentIndex > 0){
      currentIndex --;
    }
    emit(PagerSuccess(currentIndex));
  }
}
