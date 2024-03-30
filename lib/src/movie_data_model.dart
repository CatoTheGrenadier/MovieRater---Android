import 'package:http/http.dart' as http;
import 'dart:io';

class MovieResults{
  List<SingleMovie> movies = [];
  bool cached = false;

  MovieResults({
    required this.movies,
  }){
    init();
  }

  void init(){
    if (!cached){
      String jsonString = await fetchMovieResultJson();
      
    }
  }

  factory MovieResults.fromJson(Map<String,dynamic> json){
    var results = json['results'] as List;
    List<SingleMovie> movies = results.map((movieJson) => SingleMovie.fromJson(movieJson)).toList();
    return MovieResults(
      movies: movies,
    );
  }

  Future<String> fetchMovieResultJson() async {
    final response = await http.get(Uri.parse(''));
    if (response.statusCode == 200){
      return response.body;
    } else {
      throw Exception('Failed to load movie results');
    }
  }

  void writeJsonToFile(String jsonData, String filePath) async {
    File file = File(jsonData);
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
      id: json['id'],
      posterPath: json['posterPath'],
      title: json["title"],
      voteAverage: json["voteAverage"],
      voteCount: json["voteCount"],
      releaseDate: json["releaseDate"],
      backdropPath: json["backdropPath"],
      overview: json["overview"],
      originalTitle: json["originalTitle"],
      popularity: json["popularity"],
      genresID: json["genresID"],
    );
  }
}