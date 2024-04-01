import 'package:flutter/material.dart';
import "movie_list.dart";
import 'package:movielist/src/movie_data_model.dart';
import 'package:easy_search_bar/easy_search_bar.dart';

class MasterView extends StatefulWidget {
  @override
  MasterViewState createState() => MasterViewState();
}

class MasterViewState extends State<MasterView>{
  MovieResults movieList = MovieResults(movies: []);
  GenresMap genresMap = GenresMap();
  DeletedMovies deletedMovies = DeletedMovies(deleted: []);
  String searchValue = '';

  ThemeMode curThemeMode = ThemeMode.system; 
  void switchTheme(ThemeMode themeMode) { 
    setState(() { 
      curThemeMode = themeMode; 
    }); 
  } 
  
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
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: curThemeMode,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: EasySearchBar(
          title: const Text('Example'),
          onSearch: (value) => setState(() {searchValue = value;print(value);print(searchValue);print(1);}),
        ),
        body: Center(
          child: ListView(
            children: [
              MovieListView(movieList: movieList,genresMap:genresMap, deletedMovies: deletedMovies, searchValue: searchValue, curThemeMode: curThemeMode),
            ],
          )
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0), // Adjust the padding as needed
              child: ElevatedButton(
                onPressed: () {
                  switchTheme(ThemeMode.light);
                },
                child: Text("Light Theme"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0), // Adjust the padding as needed
              child: ElevatedButton(
                onPressed: () {
                  switchTheme(ThemeMode.dark);
                },
                child: Text("Dark Theme"),
              ),
            ),
          ],
        ),
      )
    );
  }
}
