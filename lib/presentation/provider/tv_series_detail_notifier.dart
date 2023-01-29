import 'package:flutter/foundation.dart';
import 'package:youtap_assesment_test/domain/entities/tvseries_detail.dart';
import 'package:youtap_assesment_test/domain/usecases/get_detail_tvseries.dart';

import '../../utils/state_enum.dart';

class TVSeriesDetailNotifier extends ChangeNotifier {
  final GetDetailTVSeries getDetailTVSeries;

  TVSeriesDetailNotifier(this.getDetailTVSeries);

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  late TVSeriesDetail _tvSeriesDetail;

  TVSeriesDetail get tvSeriesDetail => _tvSeriesDetail;

  String _message = '';

  String get message => _message;

  Future<void> getDetailTVSeriesData(int id) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getDetailTVSeries.execute(id);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvSeriesDetail) {
        _tvSeriesDetail = tvSeriesDetail;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
