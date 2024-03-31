import 'package:flutter/material.dart';
import 'package:movielist/src/movie_data_model.dart';
import 'movie_list_item.dart';


class MovieListView extends StatefulWidget {
  final MovieResults movieList;
  final GenresMap genresMap;
  final DeletedMovies deletedMovies;

  MovieListView({
    required this.movieList,
    required this.genresMap,
    required this.deletedMovies,
  });

  @override
  MovieListState createState() => MovieListState();
}

class MovieListState extends State<MovieListView>{
  late MovieResults movieList;
  late GenresMap genresMap;
  late DeletedMovies deletedMovies;
  
  @override
  Widget build(BuildContext context){
    movieList = widget.movieList;
    genresMap = widget.genresMap;
    deletedMovies = widget.deletedMovies;
    if (movieList.movies.isEmpty) {
      return Center(
        child: Text("Loading")
      );
    } else {
      return Column(
        children: movieList.movies.where((movie) => !deletedMovies.deleted.contains(movie.id)).map((movie) => 
          Dismissible(
            key: Key(movie.id.toString()),
            onDismissed: (direction) {
              setState(() {
                deletedMovies.deleted.add(movie.id);
                deletedMovies.encodeAndWriteDeletedToFile();
                deletedMovies.readDeletedFromFile();
              });
            },
            child: MovieListItem(movie: movie, genresMap: genresMap),
          )
        ).toList(),
      );
    }
  }
}