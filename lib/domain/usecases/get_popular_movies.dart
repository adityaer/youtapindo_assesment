import 'package:dartz/dartz.dart';
import 'package:youtap_assesment_test/domain/repositories/app_repository.dart';

import '../../utils/failure.dart';
import '../entities/movie.dart';

class GetPopularMovies {
  final AppRepository repository;

  GetPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularMovies();
  }
}
