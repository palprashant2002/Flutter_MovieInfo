import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'moviedata.dart';

class trend extends StatefulWidget {
  trend({Key? key}) : super(key: key);
  @override
  _trendState createState() => _trendState();
}

class _trendState extends State<trend> {
  List topmovie = [];
  final String api = "8d4ca579406cd4e939e423183714fd87";
  final String token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZDRjYTU3OTQwNmNkNGU5MzllNDIzMTgzNzE0ZmQ4NyIsInN1YiI6IjYxOGU5NjQwZTkzZTk1MDA2MjcxMWE4MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.tsXU283XtOskys2VhbWsQceJQTdw6-jF3bPptqiiJSk";

  fetchmovies() async {
    TMDB customlog = TMDB(ApiKeys(api, token),
        logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));
    Map latestmovie = await customlog.v3.trending
        .getTrending(mediaType: MediaType.movie, timeWindow: TimeWindow.week);
    setState(() {
      topmovie = latestmovie['results'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchmovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: gridview(
        movie: topmovie,
      ),
    );
  }
}

class gridview extends StatefulWidget {
  gridview({Key? key, required this.movie}) : super(key: key);
  List movie;
  @override
  _gridviewState createState() => _gridviewState();
}

class _gridviewState extends State<gridview> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
          itemCount: widget.movie.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 9 / 16,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10),
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Card(
                color: Colors.black,
                child: Column(children: [
                  Container(
                      child: Image.network(
                    'https://image.tmdb.org/t/p/w500/' +
                        widget.movie[index]['poster_path'],
                    fit: BoxFit.cover,
                  )),
                  Container(
                      //color: Colors.blue,
                      height: 40,
                      child: Text(
                        widget.movie[index]['title'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      )),
                ]),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => moviedetail(
                            movieinfo: widget.movie[index],
                          )),
                );
              },
            );
          }),
    );
  }
}
