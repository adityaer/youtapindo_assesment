import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:get_it/get_it.dart';
import 'package:youtap_assesment_test/domain/usecases/get_detail_movies.dart';
import 'package:youtap_assesment_test/domain/usecases/get_detail_tvseries.dart';
import 'package:youtap_assesment_test/domain/usecases/get_on_the_air_tv.dart';
import 'package:youtap_assesment_test/domain/usecases/get_popular_movies.dart';
import 'package:youtap_assesment_test/domain/usecases/get_popular_tv.dart';
import 'package:youtap_assesment_test/domain/usecases/get_upcoming_movies.dart';
import 'package:youtap_assesment_test/presentation/provider/movie_now_playing_notifier.dart';
import 'package:youtap_assesment_test/presentation/provider/movie_popular_notifier.dart';
import 'package:youtap_assesment_test/presentation/provider/movie_upcoming_notifier.dart';
import 'package:youtap_assesment_test/presentation/provider/movies_detail_notifier.dart';
import 'package:youtap_assesment_test/presentation/provider/tv_series_detail_notifier.dart';
import 'package:youtap_assesment_test/presentation/provider/tv_series_notifier.dart';

import 'data/datasources/app_remote_data_source.dart';
import 'data/repositories/app_repository_impl.dart';
import 'domain/repositories/app_repository.dart';
import 'domain/usecases/get_now_playing_movies.dart';
import 'environment/environment.dart';

final locator = GetIt.instance;

void init() {
  locator.registerLazySingleton<AppRepository>(
    () => AppRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<AppRemoteDataSource>(
      () => AppRemoteDataSourceImpl(client: locator()));

  locator.registerFactory(
    () => MovieNowPlayingNotifier(
      locator(),
    ),
  );

  locator.registerFactory(
    () => MoviePopularNotifier(
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieUpcomingNotifier(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TVSeriesNotifier(
        getOnTheAirTVSeries: locator(), getPopularTVSeries: locator()),
  );

  locator.registerFactory(
    () => MoviesDetailNotifier(locator()),
  );

  locator.registerFactory(
    () => TVSeriesDetailNotifier(locator()),
  );

  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetUpcomingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularTVSeries(locator()));
  locator.registerLazySingleton(() => GetOnTheAirTVSeries(locator()));
  locator.registerLazySingleton(() => GetDetailMovies(locator()));
  locator.registerLazySingleton(() => GetDetailTVSeries(locator()));

  // Dio
  var dio = Dio(
    BaseOptions(
      baseUrl: Environment.baseUrl,
      connectTimeout: 60 * 1000,
      receiveTimeout: 60 * 1000,
    ),
  );
  dio.interceptors.add(DioLoggingInterceptor(
    level: Level.body,
    compact: false,
  ));

  locator.registerLazySingleton(() => dio);
}
