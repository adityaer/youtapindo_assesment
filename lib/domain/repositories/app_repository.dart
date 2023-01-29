import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/movie.dart';
import '../entities/movie_detail.dart';
import '../entities/tvseries.dart';
import '../entities/tvseries_detail.dart';

abstract class AppRepository {
  // movie
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, List<Movie>>> getUpcomingMovies();
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id);

  // tv
  Future<Either<Failure, List<TVSeries>>> getOnTheAirTVSeries();
  Future<Either<Failure, List<TVSeries>>> getPopularTVSeries();
  Future<Either<Failure, TVSeriesDetail>> getDetailTVSeries(int id);
}
