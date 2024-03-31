import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

String api_key = "5763f56108dc124de419d28d03df1748";

class MovieResults{
  List<SingleMovie> movies = [];
  bool cached = false;

  MovieResults({
    required this.movies,
  });

  Future<MovieResults> init() async {
    MovieResults newMovie = MovieResults(movies: []);
    if (!cached){
      cached = true;
      String jsonString = await fetchMovieResultJson();
      if (jsonString != Null){
        writeJsonToFile(jsonString, "assets\\JsonFiles\\movieDataCache.json");
        newMovie = MovieResults.fromJson(jsonString);
      }
    } else {
      String jsonString = await readJsonFromFile("assets\\JsonFiles\\movieDataCache.json");
      if (jsonString != Null){
        newMovie = MovieResults.fromJson(jsonString);
      }
    }
    return newMovie;
  }

  factory MovieResults.fromJson(String jsonString){
    Map<String,dynamic> jsonData = json.decode(jsonString);
    var results = jsonData['results'] as List;
    List<SingleMovie> movies = results.map((movieJson) => SingleMovie.fromJson(movieJson)).toList();
    return MovieResults(
      movies: movies,
    );
  }

  Future<String> fetchMovieResultJson() async {
    final response = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=$api_key"));
    if (response.statusCode == 200){
      return response.body;
    } else {
      throw Exception('Failed to load movie results');
    }
  }

  void writeJsonToFile(String jsonData, String fileName) async {
    Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocumentsDir.path}/$fileName';
    File file = File(filePath);
    await file.writeAsString(jsonData);
  }

  Future<String> readJsonFromFile(String filePath) async {
    try {
      File file = File(filePath);
      String contents = await file.readAsString();
      return contents;
    } catch (error) {
      throw Exception('Failed to read JSON from file: $error');
    }
  }
}

class SingleMovie{
  int id = 0;
  String posterPath = "null";
  String title = "null";
  double voteAverage = 0.0;
  int voteCount = 0;
  String releaseDate = "null";
  String backdropPath = "null";
  String overview = "null";
  String originalTitle = "null";
  double popularity = 0.0;
  List<int> genresID = [];

  SingleMovie({
    required this.id,
    required this.posterPath,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
    required this.releaseDate,
    required this.backdropPath,
    required this.overview,
    required this.originalTitle,
    required this.popularity,
    required this.genresID,
  });

  factory SingleMovie.fromJson(Map<String,dynamic> json){
    return SingleMovie(
      id: json["id"] ?? 0,
      posterPath: json["poster_path"] ?? "",
      title: json["title"] ?? "",
      voteAverage: json["vote_average"] ?? 0.0,
      voteCount: json["vote_count"] ?? 0,
      releaseDate: json["release_date"] ?? "",
      backdropPath: json["backdrop_path"] ?? "",
      overview: json["overview"] ?? "",
      originalTitle: json["original_title"] ?? "",
      popularity: json["popularity"] ?? 0.0,
      genresID: (json['genre_ids'] as List<dynamic>).cast<int>(),
    );
  }
}