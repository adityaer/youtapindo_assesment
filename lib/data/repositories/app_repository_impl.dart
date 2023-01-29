import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/entities/tvseries.dart';
import '../../domain/entities/tvseries_detail.dart';
import '../../domain/repositories/app_repository.dart';
import '../../utils/exception.dart';
import '../../utils/failure.dart';
import '../datasources/app_remote_data_source.dart';

class AppRepositoryImpl implements AppRepository {
  final AppRemoteDataSource remoteDataSource;

  AppRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    try {
      final result = await remoteDataSource.getNowPlayingMovies();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    try {
      final result = await remoteDataSource.getPopularMovies();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getUpcomingMovies() async {
    try {
      final result = await remoteDataSource.getUpcomingMovies();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id) async {
    try {
      final result = await remoteDataSource.getMovieDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  // tv
  @override
  Future<Either<Failure, List<TVSeries>>> getOnTheAirTVSeries() async {
    try {
      final result = await remoteDataSource.getOnTheAirTVSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getPopularTVSeries() async {
    try {
      final result = await remoteDataSource.getPopularTVSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TVSeriesDetail>> getDetailTVSeries(int id) async {
    try {
      final result = await remoteDataSource.getDetailTVSeries(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
