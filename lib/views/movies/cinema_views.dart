import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdbapp/components/cards.dart';
import 'package:tmdbapp/components/shimmer.dart';
import 'package:tmdbapp/constant/constant.dart';
import 'package:tmdbapp/constant/design_system.dart';
import 'package:tmdbapp/components/search_bars.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdbapp/view_models/movies_view_models.dart';
import 'package:tmdbapp/views/movies/detail_views.dart';

class CinemaPages extends StatefulWidget {
  const CinemaPages({super.key});

  @override
  State<CinemaPages> createState() => _CinemaPagesState();
}

class _CinemaPagesState extends State<CinemaPages> {
  late String username = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MoviesViewModel>(context, listen: false).searchByNowPlaying();
      Provider.of<MoviesViewModel>(context, listen: false).searchByPopular();
    });
    getProfile();
  }

  Future getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() => username = prefs.getString('username')!);
  }

  @override
  Widget build(BuildContext context) {
    final movieList = Provider.of<MoviesViewModel>(context);
    final nowPlaying = movieList.moviesNowPlaying;
    final popular = movieList.moviesPopular;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: SearchBarButton(
                  onClicked: () => Navigator.pushNamed(context, '/search'),
                ),
              ),
              const SizedBox(height: 10),
              
              // -------------------------------------------------------- List of Movies Now Playing -------------------------------------------------------- //
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Now Playing',
                  style: TextStyleSystem().heading1Style,
                ),
              ),
              const SizedBox(height: 20),
          
              movieList.dataStatus == Status.loading
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          separatorBuilder: (BuildContext context, int index) {
                            return const Padding(padding: EdgeInsets.symmetric(horizontal: 7));
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return const Loadings(
                              constantWidth: 0.5,
                              constantHeight: 0.4,
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : movieList.dataStatus == Status.error
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline, size: 50),
                          SizedBox(height: 10),
                          Text('Please Check the internet connection', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  )
                : SizedBox(
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: 6,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Padding(padding: EdgeInsets.symmetric(horizontal: 8));
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Hero(
                            tag: nowPlaying![index].id.toString(),
                            child: MovieCards(
                              constantWidth: 0.5,
                              constantHeight: 0.4,
                              // title: nowPlaying[index].title!,
                              title: "",
                              image: Constant.imagePoster + nowPlaying[index].posterPath!,
                              onClick: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailMoviePlayPage(indexes: index)
                                ),
                              ),
                              onHolds: () {},
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(color: Colors.grey.withOpacity(0.5)),
                ),
                const SizedBox(height: 10),
                
                // -------------------------------------------------------- List of Popular Movies -------------------------------------------------------- //
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Popular Right Now',
                      style: TextStyleSystem().heading1Style,
                    ),
                ),
                const SizedBox(height: 20),

                movieList.dataStatus == Status.loading
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          separatorBuilder: (BuildContext context, int index) {
                            return const Padding(padding: EdgeInsets.symmetric(horizontal: 7));
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return const Loadings(
                              constantWidth: 0.5,
                              constantHeight: 0.4,
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : movieList.dataStatus == Status.error
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline, size: 50),
                          SizedBox(height: 10),
                          Text('Please Check the internet connection', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  )
                : SizedBox(
                  height: MediaQuery.of(context).size.height / 2.5, 
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: popular!.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Padding(padding: EdgeInsets.symmetric(horizontal: 8));
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Hero(
                            tag: popular[index].id!,
                            child: MovieCards(
                              constantWidth: 0.5,
                              constantHeight: 0.4,
                              // title: popular[index].title!,
                              title: "",
                              image: Constant.imagePoster + popular[index].posterPath!,
                              onClick: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailMoviePopularPage(indexes: index)
                                )
                              ),
                              onHolds: () {},
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
            ]
          ),
        ),
      ),
    );
  }
}