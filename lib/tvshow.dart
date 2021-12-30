import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb_api/tmdb_api.dart';

class showdetail extends StatefulWidget {
  showdetail({Key? key, required this.showinfo}) : super(key: key);
  Map showinfo;
  @override
  _showdetailState createState() => _showdetailState();
}

class _showdetailState extends State<showdetail> {
  final String api = "8d4ca579406cd4e939e423183714fd87";
  final String token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZDRjYTU3OTQwNmNkNGU5MzllNDIzMTgzNzE0ZmQ4NyIsInN1YiI6IjYxOGU5NjQwZTkzZTk1MDA2MjcxMWE4MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.tsXU283XtOskys2VhbWsQceJQTdw6-jF3bPptqiiJSk";
  Map show = {};
  fetchdetail() async {
    TMDB customlog = TMDB(ApiKeys(api, token),
        logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));
    Map latestshowdetail =
        await customlog.v3.tv.getDetails(widget.showinfo['id']);
    setState(() {
      show = latestshowdetail;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchdetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.showinfo['name'],
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: SizedBox(
                height: 250,
                width: double.infinity,
                child: Column(children: [
                  Card(
                      child: Image.network(
                    'https://image.tmdb.org/t/p/w500/' +
                        widget.showinfo['backdrop_path'],
                    fit: BoxFit.cover,
                  )),
                  Text(
                    show['tagline'] != null ? show['tagline'] : "",
                    style: TextStyle(
                        backgroundColor: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.start,
                  )
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Container(
                alignment: Alignment.topLeft,
                height: 55,
                color: Colors.black.withOpacity(0.2),
                child: Text(
                  " 👍Average Vote : " +
                      widget.showinfo['vote_average'].toString() +
                      "\n ⭐Popularity :" +
                      show['popularity'].toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Released on : " +
                      show['first_air_date'].toString() +
                      
                      "\nType : " +
                      show['type'].toString(),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                widget.showinfo['overview'],
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
