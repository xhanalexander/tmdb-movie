import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdbapp/components/cards.dart';
import 'package:tmdbapp/constant/constant.dart';
import 'package:tmdbapp/components/shimmer.dart';
import 'package:tmdbapp/components/app_bars.dart';
import 'package:tmdbapp/components/search_bars.dart';
import 'package:tmdbapp/constant/design_system.dart';
import 'package:tmdbapp/view_models/movies_view_models.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  final borderRadius = const BorderRadius.all(Radius.circular(30));
  final searchController = TextEditingController();
  final searches = TextEditingController();

  final List<String> moviesType = ['Movies', 'Episode', 'Shorts'];
  final List<Map<String, String>> moviesSearchs = [
    {"title": "Marvel"},
    {"title": "Spiderman"},
    {"title": "Alvin"},
  ];

  randomizeSearch(String search) {
    final randomTitle = Random();
    moviesSearchs.shuffle(randomTitle);
    search = moviesSearchs[randomTitle.nextInt(moviesSearchs.length)]["title"]!;
    return search;
  }
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final defaultSearch = randomizeSearch(searches.text);
      Provider.of<MoviesViewModel>(context, listen: false).searchMoviesList(searchs: defaultSearch);
    });
  }

  @override
  dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> onSearch() async {
    final searchResult = searchController.text;
    debugPrint(searchResult);
    setState(() async => await Provider.of<MoviesViewModel>(context, listen: false).searchMoviesList(searchs: searchResult));
  }
  
  @override
  Widget build(BuildContext context) {
    final movie = Provider.of<MoviesViewModel>(context);
    final searchResult = movie.moviesSearch;
    return Scaffold(
      appBar: customAppBar(context, "Search Movies"),
      body: SafeArea(
        child: Column(
          children: [
        
            // ---------------------------- search bar components ---------------------------- //
            
            SearchBars(
              marginSize: const EdgeInsets.symmetric(horizontal: 10),
              controller: searchController,
              hintText: "Search movies...",
              onSearch: () => onSearch(),
              iconData: Icons.search,
              onChanges: (value) {
                searches.text = value;
                onSearch();
              },
            ),
            const SizedBox(height: 10),
        
            // ---------------------------- results movies ---------------------------- //
        
            movie.dataStatus == Status.loading
              ? const LoadingResult(
                  paddingSize: EdgeInsets.symmetric(horizontal: 10),
                )
              : movie.dataStatus == Status.error
                ? const Center(child: Text("Error"))
                : movie.moviesSearch!.isEmpty
                  ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 50),
                        const SizedBox(height: 10),
                        Text("No result movie", style: TextStyleSystem().heading2Style),
                      ],
                    ),
                  )
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: RefreshIndicator(
                          onRefresh: () async => await Provider.of<MoviesViewModel>(context, listen: false).searchMoviesList(searchs: searchController.text),
                          child: AnimationLimiter(
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                childAspectRatio: 0.6,
                              ),
                              shrinkWrap: true,
                              itemCount: searchResult!.length,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  columnCount: 2,
                                  child: SlideAnimation(
                                    duration: const Duration(milliseconds: 1350),
                                    verticalOffset: 150.0,
                                    child: ResultsCards(
                                      image: Constant.imagePoster + searchResult[index].posterPath!,
                                      onClick: () {
                                        Navigator.pushNamed(
                                          context,
                                          '/detailSearch',
                                          arguments: {
                                            'indexes': index,
                                          }
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    )
          ],
        ),
      ),
    );
  }
}