import 'package:dartz/dartz.dart';
import 'package:youtap_assesment_test/domain/repositories/app_repository.dart';

import '../../utils/failure.dart';
import '../entities/movie.dart';
import '../entities/tvseries.dart';

class GetOnTheAirTVSeries {
  final AppRepository repository;

  GetOnTheAirTVSeries(this.repository);

  Future<Either<Failure, List<TVSeries>>> execute() {
    return repository.getOnTheAirTVSeries();
  }
}
