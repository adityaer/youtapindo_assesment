import 'package:flutter/foundation.dart';
import 'package:youtap_assesment_test/domain/usecases/get_popular_movies.dart';

import '../../domain/entities/movie.dart';
import '../../utils/state_enum.dart';

class MoviePopularNotifier extends ChangeNotifier {
  final GetPopularMovies getPopularMovies;

  MoviePopularNotifier(this.getPopularMovies);

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  String _message = '';

  String get message => _message;

  Future<void> fetchPopularMovies() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularMovies.execute();

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
