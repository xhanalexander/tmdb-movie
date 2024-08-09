import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdbapp/components/app_bars.dart';
import 'package:tmdbapp/components/cards.dart';
import 'package:tmdbapp/components/detail_poster.dart';
import 'package:tmdbapp/components/shimmer.dart';
import 'package:tmdbapp/constant/constant.dart';
import 'package:tmdbapp/constant/design_system.dart';
import 'package:tmdbapp/models/api/movies_api.dart';
import 'package:tmdbapp/view_models/movies_view_models.dart';

// -------------------------------------------------------- Now Playing -------------------------------------------------------- //
class DetailMoviePlayPage extends StatefulWidget {
  final int indexes;

  const DetailMoviePlayPage({
    super.key,
    required this.indexes,
  });

  @override
  State<DetailMoviePlayPage> createState() => _DetailMoviePlayPageState();
}

class _DetailMoviePlayPageState extends State<DetailMoviePlayPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final details = Provider.of<MoviesViewModel>(context, listen: false);
      details.searchSimmilarMovies(ids: details.moviesNowPlaying![widget.indexes].id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final details = Provider.of<MoviesViewModel>(context);


    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: customAppBar(
        context, 
        '',
        childs: [
          IconButton(
            onPressed: () {
                /* details.addWishlist(details.moviesNowPlaying![widget.indexes]);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Added to Favorites'),
                    duration: Duration(seconds: 1),
                  ),
                ); */
              },
            icon: Icon(
              details.wishlist!.any((element) => element.id == details.moviesPopular![widget.indexes].id)
                ? Icons.favorite
                : Icons.favorite_border,
              color: details.wishlist!.any((element) => element.id == details.moviesPopular![widget.indexes].id)
                ? Colors.red
                : Colors.white,
            )
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            details.dataStatus == Status.loading
              ? const Loadings(
                  constantWidth: 1,
                  constantHeight: 0.8,
              )
              : Hero(
                  tag: details.moviesNowPlaying![widget.indexes].id.toString(),
                  child: MoviePoster(
                    image: Constant.imagePoster + details.moviesNowPlaying![widget.indexes].posterPath!,
                  ),
                ),
            const SizedBox(height: 20),
            
            // ------------------------ movie details ------------------------ //
            
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: details.dataStatus == Status.loading
                    ? const Loadings(
                        constantWidth: double.infinity,
                        constantHeight: 0.04,
                      )
                    : Text(
                      details.moviesNowPlaying![widget.indexes].title!.toString(),
                      style: TextStyleSystem().heading1Style,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow[700],
                        ),
                        const SizedBox(width: 5),
                        details.dataStatus == Status.loading
                          ? const Loadings(
                              constantWidth: 0.1,
                              constantHeight: 0.04,
                            )
                          : Text(
                            details.moviesNowPlaying![widget.indexes].voteAverage!.toString().substring(0, 3),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow[700],
                            )
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            
            // ------------------------ movie details description ------------------------ //
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
                  const SizedBox(height: 10),
                  
                  Text(
                    "Description",
                    style: TextStyleSystem().heading2Style,
                  ),
                  details.dataStatus == Status.loading
                    ? const Loadings(
                        constantWidth: double.infinity,
                        constantHeight: 0.2,
                      )
                    : Text(
                      details.moviesNowPlaying![widget.indexes].overview!,
                      style: TextStyleSystem().bodyStyle,
                      textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),

                  Text(
                    "Language",
                    style: TextStyleSystem().heading2Style,
                  ),
                  details.dataStatus == Status.loading
                    ? const Loadings(
                        constantWidth: double.infinity,
                        constantHeight: 0.04,
                      )
                    : Text(
                      details.moviesNowPlaying![widget.indexes].originalLanguage!,
                      style: TextStyleSystem().bodyStyle,
                  ),
                  const SizedBox(height: 20),

                  // ------------------------ movie similars ------------------------ //
                  Text(
                    "Similar Movies Genre",
                    style: TextStyleSystem().heading2Style,
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2.5, 
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: 6,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Padding(padding: EdgeInsets.symmetric(horizontal: 8));
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return MovieCards(
                            constantWidth: 0.5,
                            constantHeight: 0.4,
                            title: "",
                            image: Constant.imagePoster + details.moviesSimmilar![index].posterPath!,
                            onClick: () {}
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),




                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------- Popular -------------------------------------------------------- //
class DetailMoviePopularPage extends StatefulWidget {
  final int indexes;

  const DetailMoviePopularPage({
    super.key,
    required this.indexes,
  });

  @override
  State<DetailMoviePopularPage> createState() => _DetailMoviePopularPageState();
}

class _DetailMoviePopularPageState extends State<DetailMoviePopularPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final details = Provider.of<MoviesViewModel>(context, listen: false);
      details.searchSimmilarMovies(ids: details.moviesPopular![widget.indexes].id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final details = Provider.of<MoviesViewModel>(context);
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: customAppBar(
        context, 
        '',
        childs: [
          IconButton(
            onPressed: () {
                details.addWishlist(details.moviesPopular![widget.indexes]);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Added to Favorites'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            icon: Icon(
              details.wishlist!.any((element) => element.id == details.moviesPopular![widget.indexes].id)
                ? Icons.favorite
                : Icons.favorite_border,
              color: details.wishlist!.any((element) => element.id == details.moviesPopular![widget.indexes].id)
                ? Colors.red
                : Colors.white,
            )
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            details.dataStatus == Status.loading
              ? const Loadings(
                  constantWidth: 1,
                  constantHeight: 0.8,
              )
              : Hero(
                  tag: details.moviesPopular![widget.indexes].id!,
                  child: MoviePoster(
                    image: Constant.imagePoster + details.moviesPopular![widget.indexes].posterPath.toString(),
                  ),
                ),
            const SizedBox(height: 20),
            
            // ------------------------ movie details ------------------------ //
            
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: details.dataStatus == Status.loading
                      ? const Loadings(
                          constantWidth: double.infinity,
                          constantHeight: 0.04,
                        )
                      : Text(
                        details.moviesPopular![widget.indexes].title!.toString(),
                        style: TextStyleSystem().heading1Style,
                    )
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow[700],
                        ),
                        const SizedBox(width: 5),
                        details.dataStatus == Status.loading
                          ? const Loadings(
                              constantWidth: 0.1,
                              constantHeight: 0.04,
                            )
                          : Text(
                            details.moviesPopular![widget.indexes].voteAverage.toString().substring(0, 3),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow[700],
                            )
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            
            // ------------------------ movie details description ------------------------ //
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
                  const SizedBox(height: 10),
                  
                  Text(
                    "Description",
                    style: TextStyleSystem().heading2Style,
                  ),
                  details.dataStatus == Status.loading
                    ? const Loadings(
                        constantWidth: double.infinity,
                        constantHeight: 0.2,
                      )
                    : Text(
                      details.moviesPopular![widget.indexes].overview!,
                      style: TextStyleSystem().bodyStyle,
                      textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),

                  Text(
                    "Language",
                    style: TextStyleSystem().heading2Style,
                  ),
                  details.dataStatus == Status.loading
                    ? const Loadings(
                        constantWidth: double.infinity,
                        constantHeight: 0.04,
                      )
                    : Text(
                      details.moviesPopular![widget.indexes].originalLanguage!,
                      style: TextStyleSystem().bodyStyle,
                  ),
                  const SizedBox(height: 20),
                  
                  // ------------------------ movie similars ------------------------ //
                  Text(
                    "Similar Movies Genre",
                    style: TextStyleSystem().heading2Style,
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2.5, 
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: 6,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Padding(padding: EdgeInsets.symmetric(horizontal: 8));
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return MovieCards(
                            constantWidth: 0.5,
                            constantHeight: 0.4,
                            title: details.moviesSimmilar![index].title!,
                            image: Constant.imagePoster + details.moviesSimmilar![index].posterPath!,
                            onClick: () {}
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------- Search Result -------------------------------------------------------- //

class DetailMovieSearchPage extends StatefulWidget {
  final int indexes;

  const DetailMovieSearchPage({
    super.key,
    required this.indexes,
  });

  @override
  State<DetailMovieSearchPage> createState() => _DetailMovieSearchPageState();
}

class _DetailMovieSearchPageState extends State<DetailMovieSearchPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final details = Provider.of<MoviesViewModel>(context, listen: false);
      details.searchSimmilarMovies(ids: details.moviesSearch![widget.indexes].id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final details = Provider.of<MoviesViewModel>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: customAppBar(
        context, 
        '',
        childs: [
          IconButton(
            onPressed: () {
                details.addWishlist(details.moviesSearch![widget.indexes]);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Added to Favorites'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            icon: Icon(
              details.wishlist!.any((element) => element.id == details.moviesPopular![widget.indexes].id)
                ? Icons.favorite
                : Icons.favorite_border,
              color: details.wishlist!.any((element) => element.id == details.moviesPopular![widget.indexes].id)
                ? Colors.red
                : Colors.white,
            )
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            details.dataStatus == Status.loading
              ? const Loadings(
                  constantWidth: 1,
                  constantHeight: 0.8,
              )
              : MoviePoster(
                image: Constant.imagePoster + details.moviesSearch![widget.indexes].posterPath!,
              ),
            const SizedBox(height: 20),
            
            // ------------------------ movie details ------------------------ //
            
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: details.dataStatus == Status.loading
                      ? const Loadings(
                          constantWidth: double.infinity,
                          constantHeight: 0.04,
                        )
                      : Text(
                        details.moviesSearch![widget.indexes].title!.toString(),
                        style: TextStyleSystem().heading1Style,
                    )
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow[700],
                        ),
                        const SizedBox(width: 5),
                        details.dataStatus == Status.loading
                          ? const Loadings(
                              constantWidth: 0.1,
                              constantHeight: 0.04,
                            )
                          : Text(
                            details.moviesSearch![widget.indexes].voteAverage.toString().substring(0, 3),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow[700],
                            )
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            
            // ------------------------ movie details description ------------------------ //
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
                  const SizedBox(height: 10),
                  
                  Text(
                    "Description",
                    style: TextStyleSystem().heading2Style,
                  ),
                  details.dataStatus == Status.loading
                    ? const Loadings(
                        constantWidth: double.infinity,
                        constantHeight: 0.2,
                      )
                    : Text(
                      details.moviesSearch![widget.indexes].overview!,
                      style: TextStyleSystem().bodyStyle,
                      textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),

                  Text(
                    "Language",
                    style: TextStyleSystem().heading2Style,
                  ),
                  details.dataStatus == Status.loading
                    ? const Loadings(
                        constantWidth: double.infinity,
                        constantHeight: 0.04,
                      )
                    : Text(
                      details.moviesSearch![widget.indexes].originalLanguage!,
                      style: TextStyleSystem().bodyStyle,
                  ),
                  const SizedBox(height: 20),
                  
                  // ------------------------ movie similars ------------------------ //
                  Text(
                    "Similar Movies Genre",
                    style: TextStyleSystem().heading2Style,
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2.5, 
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: 6,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Padding(padding: EdgeInsets.symmetric(horizontal: 8));
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return MovieCards(
                            constantWidth: 0.5,
                            constantHeight: 0.4,
                            title: "",
                            image: Constant.imagePoster + details.moviesSimmilar![index].posterPath!,
                            onClick: () {}
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}