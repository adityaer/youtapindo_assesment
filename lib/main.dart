import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:youtap_assesment_test/presentation/pages/homepage/homepage.dart';
import 'package:youtap_assesment_test/presentation/pages/movie/detail/movie_detail_page.dart';
import 'package:youtap_assesment_test/presentation/pages/splash_screen/splash_screen.dart';
import 'package:youtap_assesment_test/presentation/pages/tv_series/detail/tv_series_detail_page.dart';
import 'package:youtap_assesment_test/presentation/provider/movie_now_playing_notifier.dart';
import 'package:youtap_assesment_test/presentation/provider/movie_popular_notifier.dart';
import 'package:youtap_assesment_test/presentation/provider/movie_upcoming_notifier.dart';
import 'package:youtap_assesment_test/presentation/provider/movies_detail_notifier.dart';
import 'package:youtap_assesment_test/presentation/provider/tv_series_detail_notifier.dart';
import 'package:youtap_assesment_test/presentation/provider/tv_series_notifier.dart';
import 'package:youtap_assesment_test/utils/utils.dart';

import 'environment/environment.dart';
import 'injection.dart' as di;

void main() async {
  Environment.flavorName = 'develop';
  await dotenv.load(fileName: Environment.fileName);

  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => di.locator<MovieNowPlayingNotifier>()),
        ChangeNotifierProvider(
            create: (_) => di.locator<MovieUpcomingNotifier>()),
        ChangeNotifierProvider(
            create: (_) => di.locator<MoviePopularNotifier>()),
        ChangeNotifierProvider(create: (_) => di.locator<TVSeriesNotifier>()),
        ChangeNotifierProvider(
            create: (_) => di.locator<MoviesDetailNotifier>()),
        ChangeNotifierProvider(
            create: (_) => di.locator<TVSeriesDetailNotifier>()),
      ],
      child: MaterialApp(
          title: 'Youtap Asssessment Test',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            backgroundColor: Colors.white,
          ),
          home: const SplashScreenPage(),
          navigatorObservers: [routeObserver],
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case HomePage.routeName:
                return MaterialPageRoute(builder: (_) => const HomePage());
              case MovieDetailPage.routeName:
                final id = settings.arguments as int;
                return MaterialPageRoute(
                  builder: (_) => MovieDetailPage(id: id),
                  settings: settings,
                );
              case TVSeriesDetailPage.routeName:
                final id = settings.arguments as int;
                return MaterialPageRoute(
                  builder: (_) => TVSeriesDetailPage(id: id),
                  settings: settings,
                );
              default:
                return MaterialPageRoute(builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                });
            }
          }),
    );
  }
}
