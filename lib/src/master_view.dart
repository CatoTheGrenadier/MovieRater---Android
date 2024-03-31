import 'package:flutter/material.dart';
import "movie_list.dart";
import 'package:movielist/src/movie_data_model.dart';

class MasterView extends StatefulWidget {
  @override
  MasterViewState createState() => MasterViewState();
}

class MasterViewState extends State<MasterView>{
  MovieResults movieList = MovieResults(movies: []);
  GenresMap genresMap = GenresMap();
  DeletedMovies deletedMovies = DeletedMovies(deleted: []);
  
  @override
  void initState(){
    super.initState();
    initializeMovieList();
    initializeGenresMap();
    initializeDeleted();
  }

  Future<void> initializeMovieList() async {
    MovieResults updatedMovieList = await movieList.init();
    setState(() {movieList = updatedMovieList;});
  }

  Future<void> initializeGenresMap() async {
    GenresMap newGenresMap = await genresMap.init();
    setState(() {genresMap = newGenresMap;});
  }

  Future<void> initializeDeleted() async {
    DeletedMovies newDeletedMovies = await deletedMovies.init();
    setState(() {deletedMovies = newDeletedMovies;});
  }
  
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.yellow,
        body: Center(
          child: ListView(
            children: [
              Column(
                children: [
                  Text("Popular Movies"),
                ],
              ),
              MovieListView(movieList: movieList,genresMap:genresMap, deletedMovies: deletedMovies),
            ],
          )
        )
      )
    );
  }
}
