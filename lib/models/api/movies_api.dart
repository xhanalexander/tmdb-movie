import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tmdbapp/constant/constant.dart';
import 'package:tmdbapp/models/movies_models.dart';

class MoviesAPI {
  final Dio dios = Dio();

  // ---------------------------- Get movies by Now Playing ---------------------------- //
  Future<List<Results>> getNowPlaying() async {
    try {
      final response = await dios.get("${Constant.baseUrlMovies}/movie/now_playing",
        queryParameters: {
          "api_key": Constant.apiKey,
          "language": "en-US",
          "page": 1,
        }
      );
      final results = response.data;
      final list = results['results']
          .map<Results>((e) => Results.fromJson(e))
          .toList();
        // debugPrint(list.toString());
      return list;
    } catch (e) {
      throw Exception("Failed to load movies: $e");
    }
  }

  // ---------------------------- Get movies by Popular ---------------------------- //
  Future<List<Results>> getPopular() async {
    try {
      final response = await dios.get("${Constant.baseUrlMovies}/movie/popular",
        queryParameters: {
          "api_key": Constant.apiKey,
          "language": "en-US",
          "page": 1,
        }
      );
      final results = response.data;
      // debugPrint(results.toString());
      final list = results['results']
          .map<Results>((e) => Results.fromJson(e))
          .toList();
        // debugPrint(list.toString());
      return list;
    } catch (e) {
      throw Exception("Failed to load movies: $e");
    }
  }

  // ---------------------------- Get movies by Search ---------------------------- //
  Future<List<Results>> searchMovies({required search}) async {
    try {
      final response = await dios.get("${Constant.baseUrlMovies}/search/movie",
        queryParameters: {
          "api_key": Constant.apiKey,
          "language": "en-US",
          "query": search,
          "page": 1,
        }
      );
      final results = response.data;
      final list = results['results']
          .map<Results>((e) => Results.fromJson(e))
          .toList();
        // debugPrint(list.toString());
      return list;
    } catch (e) {
      throw Exception("Failed to load movies: $e");
    }
  }

  // ---------------------------- Get movies by Similar genre ---------------------------- //
  Future<List<Results>> getSimmilarMovies({required id}) async {
    try {
      final response = await dios.get("${Constant.baseUrlMovies}/movie/$id/similar",
        queryParameters: {
          "api_key": Constant.apiKey,
          "language": "en-US",
          "page": 1,
        }
      );
      final results = response.data;
      final list = results['results']
          .map<Results>((e) => Results.fromJson(e))
          .toList();
        // debugPrint(list.toString());
      return list;
    } catch (e) {
      throw Exception("Failed to load movies: $e");
    }
  }

  Future<void> addToFavoriteMovies(int movieId, bool isFavorite) async {
    try {
      final response = await dios.post(
        '${Constant.baseUrlMovies}/account/${Constant.accountId}/favorite',
        queryParameters: {
          'api_key': Constant.apiKey,
        },
        data: {
          'media_type': 'movie',
          'media_id': movieId,
          'favorite': isFavorite,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        debugPrint('Successfully marked as favorite');
      } else {
        debugPrint('Failed to mark as favorite: ${response.data}');
        throw Exception('Failed to mark as favorite');
      }
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception('Failed to mark as favorite');
    }

  }
    


  
}