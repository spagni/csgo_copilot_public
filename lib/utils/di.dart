import 'package:csgo_copilot/application/auth/auth_bloc.dart';
import 'package:csgo_copilot/application/player/player_bloc.dart';
import 'package:csgo_copilot/application/stats/stats_bloc.dart';
import 'package:csgo_copilot/data/core/api_client.dart';
import 'package:csgo_copilot/data/datasources/player_data_source.dart';
import 'package:csgo_copilot/data/datasources/stats_data_source.dart';
import 'package:csgo_copilot/data/repositories/auth_repository_impl.dart';
import 'package:csgo_copilot/data/repositories/player_repository_impl.dart';
import 'package:csgo_copilot/data/repositories/stats_repository_impl.dart';
import 'package:csgo_copilot/domain/repositories/auth_repository.dart';
import 'package:csgo_copilot/domain/repositories/player_repository.dart';
import 'package:csgo_copilot/domain/repositories/stats_repository.dart';
import 'package:csgo_copilot/utils/analytics_helper.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class Injector {
  static GetIt getIt = GetIt.I;

  static void init() {
    // HTTP Client
    getIt.registerLazySingleton<http.Client>(() => http.Client());
    // API Client Helper
    getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt()));
    // Firebase Analytics
    getIt.registerLazySingleton<FirebaseAnalytics>(() => FirebaseAnalytics());
    getIt
        .registerLazySingleton<AnalyticsHelper>(() => AnalyticsHelper(getIt()));

    // DataSources
    getIt.registerLazySingleton<PlayerDataSource>(
      () => PlayerDataSourceImpl(getIt()),
    );
    getIt.registerLazySingleton<StatsDataSource>(
      () => StatsDataSourceImpl(getIt()),
    );

    // Repositories
    getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
    getIt.registerLazySingleton<PlayerRepository>(
      () => PlayerRepositoryImpl(getIt()),
    );
    getIt.registerLazySingleton<StatsRepository>(
      () => StatsRepositoryImpl(getIt()),
    );

    //BLoCs
    getIt.registerLazySingleton<AuthBloc>(() => AuthBloc(getIt(), getIt()));
    getIt.registerFactory<StatsBloc>(() => StatsBloc(getIt()));
    getIt.registerFactory<PlayerBloc>(() => PlayerBloc(getIt()));
  }
}
