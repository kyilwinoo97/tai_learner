import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tai_learner/data/model/Unit.dart';

abstract class IUnitRepository{
  Future<List<Unit>> getUnit();
}
class UnitRepository implements IUnitRepository{
  UnitRepository();
  @override
  Future<List<Unit>> getUnit() async{
    final String response = await rootBundle.loadString('assets/data/unit1.json');
    final data = await json.decode(response) as List;
    List<Unit> lst = [];
    for (var element in data) {
      lst.add(Unit.fromJson(element));
    }
    return lst;
  }

}