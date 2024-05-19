import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tai_learner/repository/unit/unit_repository.dart';

import '../../../../../data/model/Unit.dart';

part 'unit_event.dart';

part 'unit_state.dart';

class UnitBloc extends Bloc<UnitEvent, UnitState> {
  IUnitRepository repository;

  UnitBloc({required this.repository}) : super(Uninitialized()) {
    on<GetAllUnit>(_getAllUnit);
  }

  _getAllUnit(UnitEvent event, Emitter<UnitState> emit) async {
    emit(const Loading());
    List<Unit> result = await repository.getUnit();

    if (result.isNotEmpty) {
      emit(Success(result: result));
    } else {
      emit(const Failure("no unit item"));
    }
  }
}
