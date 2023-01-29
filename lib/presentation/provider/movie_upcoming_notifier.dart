import 'package:flutter/foundation.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_upcoming_movies.dart';
import '../../utils/state_enum.dart';

class MovieUpcomingNotifier extends ChangeNotifier {
  final GetUpcomingMovies getUpcomingMovies;

  MovieUpcomingNotifier(this.getUpcomingMovies);

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  String _message = '';

  String get message => _message;

  Future<void> fetchUpcomingMovies() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getUpcomingMovies.execute();

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
