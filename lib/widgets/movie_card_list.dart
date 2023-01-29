import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtap_assesment_test/widgets/progress_dot.dart';

import '../domain/entities/movie.dart';
import '../presentation/pages/movie/detail/movie_detail_page.dart';
import '../utils/constants.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.routeName,
                  arguments: movie.id,
                );
              },
              child: Material(
                  elevation: 5,
                  color: Colors.teal,
                  shadowColor: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    child: CachedNetworkImage(
                      imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                      placeholder: (context, url) => const SizedBox(
                        width: 120,
                        child: Center(
                          child: WidgetDotFade(color: Colors.white, size: 15.0),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  )),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
