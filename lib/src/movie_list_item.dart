import 'package:flutter/material.dart';
import 'package:movielist/src/movie_data_model.dart';
import 'package:movielist/src/movie_details.dart';


class MovieListItem extends StatefulWidget {
  final MovieItem movie;
  final GenresMap genresMap;
  final ThemeMode curThemeMode;

  MovieListItem({
    required this.movie,
    required this.genresMap,
    required this.curThemeMode,
  });

  @override
  MovieListItemState createState() => MovieListItemState();
}

class MovieListItemState extends State<MovieListItem>{
  late MovieItem movie;
  late GenresMap genresMap;
  late ThemeMode curThemeMode;

  MoviePics picsLists = MoviePics(backdrops: [],posters: [],logos:[]);
  
  @override
  void initState(){
    super.initState();
    movie = widget.movie;
    genresMap = widget.genresMap;
    curThemeMode = widget.curThemeMode;
    initializePicsLists();
  }

  Future<void> initializePicsLists() async {
    MoviePics updatedPicsLists = await picsLists.init(movie.id);
    setState(() {picsLists = updatedPicsLists;});
  }
  
  @override
  Widget build(BuildContext context) {
    curThemeMode = widget.curThemeMode;
    if (picsLists.posters.isEmpty) {
      return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        title: Text(movie.title),
        leading: Image.asset(
            'assets/images/Loading.gif',
            width: 125,
            height: 100,
            fit: BoxFit.fill,
          ),
      );
    } else {
      return ListTile(
        onTap:(){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MovieDetailView(picsLists: picsLists,movie:movie, genresMap: genresMap, curThemeMode: curThemeMode)),
            );
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        title: Text(
          movie.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16, 
          ),
        ),
        leading: Image.network(
          'https://image.tmdb.org/t/p/w500${picsLists.posters[0].file_path}',
          width: 125, 
          height: 100,
          fit: BoxFit.fill,
        ),
      );
    }
  }
}

