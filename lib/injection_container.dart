
import 'package:get_it/get_it.dart';
import 'package:tai_learner/repository/unit/unit_repository.dart';
import 'package:tai_learner/ui/pages/unit/bloc/unit_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async{
  sl.registerFactory(() => UnitBloc(repository: sl()));


  //repository
  sl.registerLazySingleton<IUnitRepository>(() => UnitRepository());


  //Core
  // final db = await DbAccess().database;
  // sl.registerLazySingleton(() => db);
  // sl.registerLazySingleton<DbHelper>(() => new DbHelperImpl(database: sl()));

  //External
  // final sharedPreferences = await SharedPreferences.getInstance();
  // sl.registerLazySingleton(() => sharedPreferences);

}