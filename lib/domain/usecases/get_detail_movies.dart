import 'package:dartz/dartz.dart';
import 'package:youtap_assesment_test/domain/repositories/app_repository.dart';

import '../../utils/failure.dart';
import '../entities/movie_detail.dart';

class GetDetailMovies {
  final AppRepository repository;

  GetDetailMovies(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
