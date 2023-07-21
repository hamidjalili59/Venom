import 'package:api_service/api_service.dart';
import 'package:database_service/database_service.dart';
import 'package:dio/dio.dart';
import 'package:venom/src/config/routes/router.dart';
import 'package:venom/src/core/interceptors/auth_header_suplier.dart';
import 'package:venom/src/core/interceptors/request_interceptor.dart';
import 'package:venom/src/features/price/domain/models/price_list.dart';
import 'package:venom/src/features/price/domain/models/price_model.dart';
import 'package:venom/src/features/ride/domain/models/ride_list.dart';
import 'package:venom/src/features/ride/domain/models/ride_model.dart';
import 'package:venom/src/features/vehicle/domain/models/vehicle_list.dart';
import 'package:venom/src/features/vehicle/domain/models/vehicle_model.dart';
import 'package:venom/src/injectable/injectable.dart';

class MainModulesInjection {
  MainModulesInjection() {
    getIt.registerSingleton<Dio>(Dio());
    getIt.registerLazySingleton<ApiService>(
      () => ApiServiceImpl(
        interceptors: [getIt.get<RequestInterceptor>()],
        dio: getIt.get<Dio>(),
      ),
    );
    getIt.registerLazySingleton<DatabaseService>(
      () => DatabaseServiceImpl(),
    );
    getIt.registerLazySingleton<AppRouter>(() => AppRouter());
    getIt.registerLazySingleton<AuthHeaderSupplier>(() => AuthHeaderSupplier());
  }

  //
  Future initDatabase() async =>
      await getIt.get<DatabaseService>().initialize();

  Future registerHiveAdapters() async {
    final databaseService = getIt.get<DatabaseService>();

    await databaseService.registerAdapter<RideList>(RideListAdapter());
    await databaseService.registerAdapter<Ride>(RideAdapter());
    await databaseService.registerAdapter<PriceList>(PriceListAdapter());
    await databaseService.registerAdapter<Price>(PriceAdapter());
    await databaseService.registerAdapter<VehicleList>(VehicleListAdapter());
    await databaseService.registerAdapter<Vehicle>(VehicleAdapter());
  }
}
