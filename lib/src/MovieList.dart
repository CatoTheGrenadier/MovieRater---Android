import 'package:flutter/material.dart';
import 'package:movielist/src/movie_data_model.dart';


class MovieListView extends StatefulWidget {
  final MovieResults movieList;

  MovieListView({required this.movieList});

  @override
  MovieListState createState() => MovieListState();
}

class MovieListState extends State<MovieListView>{
  late MovieResults movieList;
  
  @override
  Widget build(BuildContext context){
    movieList = widget.movieList;
    print("check123");
    print(movieList.movies);
    print(movieList.movies.isEmpty);
    if (movieList.movies.isEmpty) {
      return Center(
        child: Text("To hell with you")
      );
    } else {
      return Column(
        children: movieList.movies.map((movie) => ListTile(
          title: Text(movie.title),
        )).toList(),
      );
    }
  }
}