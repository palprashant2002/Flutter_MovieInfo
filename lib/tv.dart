import 'package:dsc/trend.dart';
import 'package:dsc/tvshow.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb_api/tmdb_api.dart';

class tvview extends StatefulWidget {
  const tvview({Key? key}) : super(key: key);

  @override
  _tvviewState createState() => _tvviewState();
}

class _tvviewState extends State<tvview> {
  List tvshow = [];
  final String api = "8d4ca579406cd4e939e423183714fd87";
  final String token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZDRjYTU3OTQwNmNkNGU5MzllNDIzMTgzNzE0ZmQ4NyIsInN1YiI6IjYxOGU5NjQwZTkzZTk1MDA2MjcxMWE4MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.tsXU283XtOskys2VhbWsQceJQTdw6-jF3bPptqiiJSk";

  fetchshow() async {
    TMDB customlog = TMDB(ApiKeys(api, token),
        logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));
    Map latestshow = await customlog.v3.trending
        .getTrending(mediaType: MediaType.tv, timeWindow: TimeWindow.week);
    setState(() {
      tvshow = latestshow['results'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchshow();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: tvgridview(show: tvshow),
    );
  }
}

class tvgridview extends StatefulWidget {
  tvgridview({Key? key, required this.show}) : super(key: key);
  List show;
  @override
  _tvgridviewState createState() => _tvgridviewState();
}

class _tvgridviewState extends State<tvgridview> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
          itemCount: widget.show.length,
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
                        widget.show[index]['poster_path'],
                    fit: BoxFit.cover,
                  )),
                  Container(
                      //color: Colors.blue,
                      height: 40,
                      child: Text(
                        widget.show[index]['name'],
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
                      builder: (context) => showdetail(
                            showinfo: widget.show[index],
                          )),
                );
              },
            );
          }),
    );
  }
}
