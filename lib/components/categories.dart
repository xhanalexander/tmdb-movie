import 'package:flutter/material.dart';
import 'package:tmdbapp/constant/design_system.dart';

class Categories extends StatelessWidget {
  final String categoriesName;
  final VoidCallback onClicked;

  const Categories({
    super.key,
    required this.categoriesName,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          categoriesName,
          style: TextStyleSystem().heading1Style,
        ),
        TextButton(
          style: ButtonStyle(
            padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
          onPressed: onClicked,
          child: const Text(
            "View All",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            )
          ),
        )
      ],
    );
  }
}

class GenresMovies extends StatelessWidget {
  final String genresName;
  final Color genreColors;

  const GenresMovies({
    super.key,
    required this.genresName,
    this.genreColors = Colors.purple,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: genreColors,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Text(
        genresName,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}