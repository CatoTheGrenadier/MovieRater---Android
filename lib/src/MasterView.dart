import 'package:flutter/material.dart';
import "MovieList.dart";

class MasterView extends StatefulWidget {
  @override
  MasterViewState createState() => MasterViewState();
}

class MasterViewState extends State<MasterView>{
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
              MovieListView(),
            ],
          )
        )
      )
    );
  }
}
