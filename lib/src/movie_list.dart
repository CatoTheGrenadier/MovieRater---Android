import 'package:flutter/material.dart';
import 'package:movielist/src/movie_data_model.dart';
import 'movie_list_item.dart';


class MovieListView extends StatefulWidget {
  final MovieResults movieList;
  final GenresMap genresMap;
  final DeletedMovies deletedMovies;
  final String searchValue;
  final ThemeMode curThemeMode;

  MovieListView({
    required this.movieList,
    required this.genresMap,
    required this.deletedMovies,
    required this.searchValue,
    required this.curThemeMode,
  });

  @override
  MovieListState createState() => MovieListState();
}

class MovieListState extends State<MovieListView>{
  late MovieResults movieList;
  late GenresMap genresMap;
  late DeletedMovies deletedMovies;
  late String searchValue;
  late ThemeMode curThemeMode;
  
  @override
  Widget build(BuildContext context){
    movieList = widget.movieList;
    genresMap = widget.genresMap;
    deletedMovies = widget.deletedMovies;
    searchValue = widget.searchValue;
    curThemeMode = widget.curThemeMode;
    if (movieList.movies.isEmpty) {
      return Center(
        child: Text(
            "Loading",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16, 
            ),
          )
      );
    } else {
      return Column(
        children: movieList.movies.where((movie) => (!deletedMovies.deleted.contains(movie.id)) && (movie.title.contains(searchValue))).map((movie) => 
          Dismissible(
            key: Key(movie.id.toString()),
            onDismissed: (direction) {
              setState(() {
                deletedMovies.deleted.add(movie.id);
                deletedMovies.encodeAndWriteDeletedToFile();
              });
            },
            child: MovieListItem(movie: movie, genresMap: genresMap, curThemeMode: curThemeMode),
          )
        ).toList(),
      );
    }
  }
}