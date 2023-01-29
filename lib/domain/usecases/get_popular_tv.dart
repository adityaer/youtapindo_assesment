import 'package:dartz/dartz.dart';
import 'package:youtap_assesment_test/domain/entities/tvseries.dart';
import 'package:youtap_assesment_test/domain/repositories/app_repository.dart';

import '../../utils/failure.dart';

class GetPopularTVSeries {
  final AppRepository repository;

  GetPopularTVSeries(this.repository);

  Future<Either<Failure, List<TVSeries>>> execute() {
    return repository.getPopularTVSeries();
  }
}
