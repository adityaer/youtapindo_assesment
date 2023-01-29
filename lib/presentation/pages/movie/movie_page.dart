import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:youtap_assesment_test/presentation/provider/movie_popular_notifier.dart';
import 'package:youtap_assesment_test/presentation/provider/movie_upcoming_notifier.dart';

import '../../../constant/string.dart';
import '../../../utils/state_enum.dart';
import '../../../widgets/movie_card_list.dart';
import '../../../widgets/progress_dot.dart';
import '../../provider/movie_now_playing_notifier.dart';

class MoviePage extends StatefulWidget {
  static const routeName = '/movie';

  const MoviePage({super.key});

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MovieNowPlayingNotifier>(context, listen: false)
          .fetchNowPlayingMovies();
      Provider.of<MoviePopularNotifier>(context, listen: false)
          .fetchPopularMovies();
      Provider.of<MovieUpcomingNotifier>(context, listen: false)
          .fetchUpcomingMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(StringConstants.movie,
            style: GoogleFonts.montserrat(color: Colors.black)),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(StringConstants.nowPlaying,
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                Consumer<MovieNowPlayingNotifier>(
                    builder: (context, data, child) {
                  final state = data.state;
                  if (state == RequestState.Loading) {
                    return SizedBox(
                      height: 150,
                      child: WidgetDotFade(color: Colors.teal[400], size: 20.0),
                    );
                  } else if (state == RequestState.Loaded) {
                    return MovieList(data.movies);
                  } else {
                    return SizedBox(
                      height: 150,
                      child: Center(
                        child: Text(StringConstants.canNotLoadData),
                      ),
                    );
                  }
                }),
                const SizedBox(
                  height: 5,
                ),
                Text(StringConstants.popular,
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                Consumer<MoviePopularNotifier>(builder: (context, data, child) {
                  final state = data.state;
                  if (state == RequestState.Loading) {
                    return SizedBox(
                      height: 150,
                      child: WidgetDotFade(color: Colors.teal[400], size: 20.0),
                    );
                  } else if (state == RequestState.Loaded) {
                    return MovieList(data.movies);
                  } else {
                    return SizedBox(
                      height: 150,
                      child: Center(
                        child: Text(StringConstants.canNotLoadData),
                      ),
                    );
                  }
                }),
                const SizedBox(
                  height: 5,
                ),
                Text(StringConstants.upcoming,
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                Consumer<MovieUpcomingNotifier>(
                    builder: (context, data, child) {
                  final state = data.state;
                  if (state == RequestState.Loading) {
                    return SizedBox(
                      height: 150,
                      child: WidgetDotFade(color: Colors.teal[400], size: 20.0),
                    );
                  } else if (state == RequestState.Loaded) {
                    return MovieList(data.movies);
                  } else {
                    return SizedBox(
                      height: 150,
                      child: Center(
                        child: Text(StringConstants.canNotLoadData),
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
