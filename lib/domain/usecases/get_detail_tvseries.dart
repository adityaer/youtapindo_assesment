import 'package:dartz/dartz.dart';
import 'package:youtap_assesment_test/domain/entities/tvseries_detail.dart';
import 'package:youtap_assesment_test/domain/repositories/app_repository.dart';

import '../../utils/failure.dart';

class GetDetailTVSeries {
  final AppRepository repository;

  GetDetailTVSeries(this.repository);

  Future<Either<Failure, TVSeriesDetail>> execute(int id) {
    return repository.getDetailTVSeries(id);
  }
}
