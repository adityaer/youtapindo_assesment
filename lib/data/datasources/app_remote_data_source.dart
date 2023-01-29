import 'package:dio/dio.dart';
import 'package:youtap_assesment_test/environment/environment.dart';

import '../../utils/exception.dart';
import '../models/movie_detail_response.dart';
import '../models/movie_model.dart';
import '../models/movie_response.dart';
import '../models/tvseries_detail_model.dart';
import '../models/tvseries_model.dart';
import '../models/tvseries_response.dart';

abstract class AppRemoteDataSource {
  // movie
  Future<List<MovieModel>> getNowPlayingMovies();

  Future<List<MovieModel>> getPopularMovies();

  Future<List<MovieModel>> getUpcomingMovies();

  Future<MovieDetailResponse> getMovieDetail(int id);

  // tv
  Future<List<TVSeriesModel>> getOnTheAirTVSeries();

  Future<List<TVSeriesModel>> getPopularTVSeries();

  Future<TVSeriesDetailResponse> getDetailTVSeries(int id);
}

class AppRemoteDataSourceImpl implements AppRemoteDataSource {
  static final BASE_URL = Environment.baseUrl;
  static final API_KEY = Environment.apiKey;

  final Dio client;

  AppRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response =
        await client.get('$BASE_URL/movie/now_playing?api_key=$API_KEY');

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(response.data).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response =
        await client.get('$BASE_URL/movie/popular?api_key=$API_KEY');

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(response.data).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getUpcomingMovies() async {
    final response =
        await client.get('$BASE_URL/movie/upcoming?api_key=$API_KEY');

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(response.data).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    final response = await client.get('$BASE_URL/movie/$id?api_key=$API_KEY');

    if (response.statusCode == 200) {
      return MovieDetailResponse.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  // tv

  @override
  Future<List<TVSeriesModel>> getOnTheAirTVSeries() async {
    final response =
        await client.get('$BASE_URL/tv/on_the_air?api_key=$API_KEY');

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(response.data).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> getPopularTVSeries() async {
    final response = await client.get('$BASE_URL/tv/popular?api_key=$API_KEY');

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(response.data).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TVSeriesDetailResponse> getDetailTVSeries(int id) async {
    final response = await client.get('$BASE_URL/tv/$id?api_key=$API_KEY');

    if (response.statusCode == 200) {
      return TVSeriesDetailResponse.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
