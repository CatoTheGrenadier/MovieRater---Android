import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movielist/src/movie_data_model.dart';

class MovieDetailView extends StatelessWidget {
  final MoviePics picsLists;
  final MovieItem movie;
  final GenresMap genresMap;

  MovieDetailView({
    required this.picsLists,
    required this.movie,
    required this.genresMap,
  });

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.yellow,
        body: Center(
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child:Text(movie.title)
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child:Text("Release Date: ${movie.releaseDate}")
                  ),
                  
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child:Row(children: [
                      Text("Genres: "),
                      SizedBox(
                        height: 30,
                        width:300,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child:ListView(
                            scrollDirection: Axis.horizontal,
                            children: movie.genresID.map((id) => 
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                child: Text("${genresMap.storedMap[id]}")
                              )
                            ,).toList()
                          )
                        )
                      )
                    ],),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child:Text("Screenshots:")
                  ),

                  SizedBox(
                    height: 150,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child:ListView(
                        scrollDirection: Axis.horizontal,
                        children: picsLists.backdrops.map((singlePic) => 
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8.0),
                            child: (Image.network(
                            'https://image.tmdb.org/t/p/w500${singlePic.file_path}',
                              width: 150, 
                              height: 100,
                              fit: BoxFit.fill,
                            ))
                          )
                        ,).toList()
                      )
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child:Text("Overview")
                  ),
                  
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child:Text("${movie.overview}")
                  )
                ],
              ),
            ],
          )
        )
      )
    );
  }
}

