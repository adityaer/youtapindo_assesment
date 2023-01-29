import 'package:flutter/foundation.dart';
import 'package:youtap_assesment_test/domain/usecases/get_now_playing_movies.dart';

import '../../domain/entities/movie.dart';
import '../../utils/state_enum.dart';

class MovieNowPlayingNotifier extends ChangeNotifier {
  final GetNowPlayingMovies getNowPlayingMovies;

  MovieNowPlayingNotifier(this.getNowPlayingMovies);

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  String _message = '';

  String get message => _message;

  Future<void> fetchNowPlayingMovies() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingMovies.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (moviesData) {
        _movies = moviesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
