import 'package:flutter/material.dart';
import 'package:tmdbapp/views/movies/movies_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final pageControllers = PageController();

  final List<Widget> _pages =[
    const CinemaPages(),
    const FavoritePage(),
    const Profilepages()
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (index) => setState(() => selectedIndex = index),
        controller: pageControllers,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_outlined),
            activeIcon: Icon(Icons.movie),
            label: 'Cinema',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            activeIcon: Icon(Icons.person_2),
            label: 'Profile',
          ),
        ],
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
          pageControllers.animateToPage(
            selectedIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        }),
      ),
    );
  }
}