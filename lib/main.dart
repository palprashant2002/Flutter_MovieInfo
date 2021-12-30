//import 'package:dsc/view.dart';
import 'package:dsc/home.dart';
import 'package:dsc/trend.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() {
  runApp(dsc());
}

class dsc extends StatefulWidget {
  const dsc({Key? key}) : super(key: key);

  @override
  _dscState createState() => _dscState();
}

class _dscState extends State<dsc> {
  List topmovie = [];
  final String api = "8d4ca579406cd4e939e423183714fd87";
  final String token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZDRjYTU3OTQwNmNkNGU5MzllNDIzMTgzNzE0ZmQ4NyIsInN1YiI6IjYxOGU5NjQwZTkzZTk1MDA2MjcxMWE4MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.tsXU283XtOskys2VhbWsQceJQTdw6-jF3bPptqiiJSk";

  fetchmovies() async {
    TMDB customlog = TMDB(ApiKeys(api, token),
        logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));
    Map latestmovie = await customlog.v3.trending
        .getTrending(mediaType: MediaType.movie, timeWindow: TimeWindow.week);
    // print("______________________________________________");
    //print(latestmovie);
    setState(() {
      topmovie = latestmovie['results'];
      print("_______________________________________________");
      print(topmovie[1]);
    });
    // print("_______________________________________________");
    // print(topmovie);
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchmovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MovieInfo",
      color: Colors.blue,
      home: home(),
    );
  }
}
