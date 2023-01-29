import 'package:flutter/foundation.dart';
import 'package:youtap_assesment_test/domain/entities/movie_detail.dart';
import 'package:youtap_assesment_test/domain/usecases/get_detail_movies.dart';

import '../../utils/state_enum.dart';

class MoviesDetailNotifier extends ChangeNotifier {
  final GetDetailMovies getDetailMovies;

  MoviesDetailNotifier(this.getDetailMovies);

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  late MovieDetail _movieDetail;

  MovieDetail get movieDetail => _movieDetail;

  String _message = '';

  String get message => _message;

  Future<void> getDetailMovieSData(int id) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getDetailMovies.execute(id);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (moviesData) {
        _movieDetail = moviesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
