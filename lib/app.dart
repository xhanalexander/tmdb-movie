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
          if (settings.name == '/home') {
            return MaterialPageRoute(builder: (context) => const HomePage());
          } else if (settings.name == '/search') {
            return MaterialPageRoute(builder: (context) => const ResultsPage());
          } else if (settings.name == '/detailPlay') {
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(builder: (context) => DetailMoviePlayPage(indexes: args['indexes']));
          } else if (settings.name == '/detailPopular') {
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(builder: (context) => DetailMoviePopularPage(indexes: args['indexes']));
          }
          return null;
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