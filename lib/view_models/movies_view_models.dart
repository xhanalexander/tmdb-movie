import 'package:flutter/material.dart';
import '../models/movies_models.dart';
import 'package:tmdbapp/models/api/movies_api.dart';

enum Status {
  loading,
  complete,
  error,
}

class MoviesViewModel with ChangeNotifier {

  List<Results>? _moviesNowPlaying = [];
  List<Results>? _moviesPopular = [];
  List<Results>? _moviesSearch = [];
  List<Results>? _moviesSimmilar = [];
  final List<Results> _wishlist = [];
  final MoviesAPI _addtoFavorites = MoviesAPI();
  bool _isLoading = false;
  String? _errorMessage;

  List<Results>? get moviesNowPlaying => _moviesNowPlaying;
  List<Results>? get moviesPopular => _moviesPopular;
  List<Results>? get moviesSearch => _moviesSearch;
  List<Results>? get moviesSimmilar => _moviesSimmilar;
  List<Results>? get wishlist => _wishlist;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Status _dataStatus = Status.loading;
  Status get dataStatus => _dataStatus;

  
  Future<void> addtoFavorites(int mediaId, bool isFavorites) async {
    _isLoading = true;
    _errorMessage = null;

    try {
      await _addtoFavorites.addToFavoriteMovies(mediaId, isFavorites);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  void addWishlist(Results movie) {
    if (!_wishlist.any((element) => element.id == movie.id)) {
      _wishlist.add(movie);
      debugPrint("Wishlist total: ${_wishlist.length}");
      notifyListeners();
    } else {
      debugPrint("Already in Wishlist");
    }
  }

  void removeWishlist(Results movie) {
    _wishlist.remove(movie);
    notifyListeners();
  }

  void clearWishlist() {
    _wishlist.clear();
    notifyListeners();
  }

  searchByNowPlaying() async {
    try {
      _dataStatus = Status.loading;
      notifyListeners();
      _moviesNowPlaying = await MoviesAPI().getNowPlaying();
      _dataStatus = Status.complete;
      notifyListeners();
    } catch (e) {
      _dataStatus = Status.error;
      notifyListeners();
    }
  }

  searchByPopular() async {
    try {
      _dataStatus = Status.loading;
      notifyListeners();
      _moviesPopular = await MoviesAPI().getPopular();
      _dataStatus = Status.complete;
      notifyListeners();
    } catch (e) {
      _dataStatus = Status.error;
      notifyListeners();
    }
  }

  searchMoviesList({required searchs}) async {
    try {
      _dataStatus = Status.loading;
      notifyListeners();
      
      // remove null posterPath
      List<Results>? resultMovies = await MoviesAPI().searchMovies(search: searchs);
      _moviesSearch = resultMovies.where((element) => element.posterPath != null).toList();

      _dataStatus = Status.complete;
      notifyListeners();
    } catch (e) {
      _dataStatus = Status.error;
      notifyListeners();
    }
  }

  searchSimmilarMovies({required ids}) async {
    try {
      _dataStatus = Status.loading;
      notifyListeners();

      // remove null posterPath
      List<Results>? resultMovies = await MoviesAPI().getSimmilarMovies(id: ids);
      _moviesSimmilar = resultMovies.where((element) => element.posterPath != null).toList();

      _dataStatus = Status.complete;
      notifyListeners();
    } catch (e) {
      _dataStatus = Status.error;
      notifyListeners();
    }
  }

}