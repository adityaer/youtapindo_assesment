import 'package:flutter/foundation.dart';
import 'package:youtap_assesment_test/domain/usecases/get_on_the_air_tv.dart';

import '../../domain/entities/tvseries.dart';
import '../../domain/usecases/get_popular_tv.dart';
import '../../utils/state_enum.dart';

class TVSeriesNotifier extends ChangeNotifier {
  final GetOnTheAirTVSeries getOnTheAirTVSeries;
  final GetPopularTVSeries getPopularTVSeries;

  TVSeriesNotifier(
      {required this.getOnTheAirTVSeries, required this.getPopularTVSeries});

  RequestState _stateOTA = RequestState.Empty;

  RequestState get stateOTA => _stateOTA;

  List<TVSeries> _otaTVSeries = [];

  List<TVSeries> get otaTVSeries => _otaTVSeries;

  String _messageOTA = '';

  String get messageOTA => _messageOTA;

  RequestState _statePopular = RequestState.Empty;

  RequestState get statePopular => _statePopular;

  List<TVSeries> _popularTVSeries = [];

  List<TVSeries> get popularTVSeries => _popularTVSeries;

  String _messagePopular = '';

  String get messagePopular => _messagePopular;

  Future<void> fetchOnTheAirTVSeries() async {
    _stateOTA = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirTVSeries.execute();

    result.fold(
      (failure) {
        _messageOTA = failure.message;
        _stateOTA = RequestState.Error;
        notifyListeners();
      },
      (tvSeriesData) {
        _otaTVSeries = tvSeriesData;
        _stateOTA = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTVSeries() async {
    _statePopular = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTVSeries.execute();

    result.fold(
      (failure) {
        _messagePopular = failure.message;
        _statePopular = RequestState.Error;
        notifyListeners();
      },
      (moviesData) {
        _popularTVSeries = moviesData;
        _statePopular = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
