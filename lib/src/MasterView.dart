import 'package:flutter/material.dart';
import "MovieList.dart";
import 'package:movielist/src/movie_data_model.dart';

class MasterView extends StatefulWidget {
  @override
  MasterViewState createState() => MasterViewState();
}

class MasterViewState extends State<MasterView>{
  MovieResults movieList = MovieResults(movies: []);
  
  @override
  void initState(){
    super.initState();
    initializeMovieList();
  }

  Future<void> initializeMovieList() async {
    MovieResults updatedMovieList = await movieList.init();
    setState(() {movieList = updatedMovieList;});
  }
  
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.yellow,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  Text("Popular Movies"),
                ],
              ),
              Container(child: MovieListView(movieList: movieList),)
            ],
          )
        )
      )
    );
  }
}
