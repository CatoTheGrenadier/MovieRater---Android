import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movielist/src/movie_data_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetailView extends StatefulWidget {
  final MoviePics picsLists;
  final MovieItem movie;
  final GenresMap genresMap;
  final ThemeMode curThemeMode;
  

  MovieDetailView({
    required this.picsLists,
    required this.movie,
    required this.genresMap,
    required this.curThemeMode,
  });

  @override
  MovieDetailState createState() => MovieDetailState();
}

class MovieDetailState extends State<MovieDetailView>{
  late MoviePics picsLists;
  late MovieItem movie;
  late GenresMap genresMap;
  late ThemeMode curThemeMode;

  @override
  Widget build(BuildContext context){
    picsLists = widget.picsLists;
    movie = widget.movie;
    genresMap = widget.genresMap;
    curThemeMode = widget.curThemeMode;
    print(curThemeMode);
    return MaterialApp(
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: curThemeMode,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child:Text(
                      movie.title,
                      style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30, 
                    ),
                    )
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        Text(
                          "Release Date:  ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16, 
                          ),
                        ),
                        Text("${movie.releaseDate}")
                      ],
                    )
                  ),
                  
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Genres: ",
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16, 
                        ),
                        ),
                        SizedBox(
                          height: 20,
                          width:270,
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
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Ratings: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16, 
                          ),
                        ),
                        SizedBox(
                          height: 37,
                          width:260,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child:RatingBar.builder(
                              initialRating: movie.voteAverage / 2,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            )
                          )
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child:Text(
                      "Screenshots:",
                      style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16, 
                    ),
                    )
                  ),

                  SizedBox(
                    height: 250,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child:ListView(
                        scrollDirection: Axis.horizontal,
                        children: picsLists.backdrops.map((singlePic) => 
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8.0),
                            child: (Image.network(
                            'https://image.tmdb.org/t/p/w500${singlePic.file_path}',
                              width: 300, 
                              height: 250,
                              fit: BoxFit.fill,
                            ))
                          )
                        ,).toList()
                      )
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child:Text(
                      "Overview:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16, 
                      ),
                    )
                  ),
                  
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child:Text("${movie.overview}")
                  )
                ],
              ),
            ],
          )
        ),
      )
    );
  }
}

