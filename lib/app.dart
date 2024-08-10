import 'package:tmdbapp/components/routes_transition.dart';
import 'package:tmdbapp/views/movies/movies_view.dart';
import 'package:tmdbapp/view_models/view_models.dart';
import 'package:tmdbapp/views/auth/login_view.dart';
import 'package:tmdbapp/views/home_views.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MoviesViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginPage(),
        },
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/home':
              return fadeRoute(page: const HomePage());
            case '/search':
              return slideRoute(page: const ResultsPage());
            case '/detailNowPlaying':
              final args = settings.arguments as Map<String, dynamic>;
              return slideRoute(page: DetailMoviePlayPage(indexes: args['indexes']));
            case '/detailPopular':
              final args = settings.arguments as Map<String, dynamic>;
              return slideRoute(page: DetailMoviePopularPage(indexes: args['indexes']));
            case '/detailSearch':
              final args = settings.arguments as Map<String, dynamic>;
              return slideRoute(page: DetailMovieSearchPage(indexes: args['indexes']));
            default:
              return null;
          }
        },
        theme: ThemeData(
          colorScheme: const ColorScheme.dark(
            primary: Colors.purple,
            secondary: Colors.purple,
            surface: Colors.purple,
          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}