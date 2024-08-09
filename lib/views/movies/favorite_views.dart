import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdbapp/constant/design_system.dart';
import 'package:tmdbapp/view_models/movies_view_models.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    final details = Provider.of<MoviesViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Movies'),
      ),
      body: details.wishlist!.isEmpty
        ? const Center(child: Text('No Favorite Movies'))
        : ListView.builder(
          itemCount: details.wishlist!.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(details.wishlist![index].title!, style: TextStyleSystem().heading3Style),
              subtitle: Text(
                details.wishlist![index].overview!,
                maxLines: 2,
                textAlign: TextAlign.justify,
              ),
              trailing: IconButton(
                onPressed: () {
                  details.removeWishlist(details.wishlist![index]);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Removed from Wishlist'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                icon: const Icon(Icons.delete),
              ),
            );
          },
        ),
    );
  }
}