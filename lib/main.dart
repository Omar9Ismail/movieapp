import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/painting.dart';
import 'movie.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MyHomePage(), title: 'Flutter Demo', theme: ThemeData());
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  List<Movie> movies = [];

  @override
  void initState() {
    getHttp();
    super.initState();
  }

  void getHttp() async {
    var response = await Dio().get(
      'https://api.themoviedb.org/3/movie/popular',
      queryParameters: {"api_key": "f55fbda0cb73b855629e676e54ab6d8e"},
    );

    movies = (response.data["results"] as List)
        .map((map) => Movie.fromMap(map))
        .toList();

    //for (int i=0 ;i<(response.data["result"] as List).length;i++){
    //  Movie movie=new Movie.fromMap(response.data['result'][i]);
    //  movies.add(movie);
    // }
    for (var movie in movies) {
      // print(movie.title);
      // print(movie.rate);
      //print(movie.overview);
      //print(movie.posterpath);

      // print("===============");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('MoviesApp',style: TextStyle(color: Colors.cyanAccent,fontWeight: FontWeight.bold),
      ),
        backgroundColor: Color(0xff3E2C41),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            Movie movie = movies[index];
            print('omar ${movie.title}');
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Screen3(
                              name: movie.title,
                              realsedata: movie.releasedate,
                              image: movie.posterpath,
                              vote: movie.rate,
                              overview: movie.overview,
                            )));
              },
              child: Container(
                height: 200,
                padding: EdgeInsets.all(10),
                color: Color(0xff261C2C),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Image.network(
                          'https://image.tmdb.org/t/p/original/${movie.posterpath}'),
                    ),
                    Expanded(
                        child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    movie.title??'',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(children: [
                              RatingBar.builder(
                                unratedColor:Colors.blueGrey
,
                                itemSize: 20,
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 0.3),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.cyanAccent,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                movie.rate.toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(Icons.access_time,
                                    size: 15, color: Colors.white),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(movie.releasedate ?? '',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ]),
                    ))
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class Screen3 extends StatelessWidget {
  final String? name;
  final String? overview;
  final String? realsedata;
  final String? image;
  final num? vote;

  const Screen3(
      {Key? key,
      this.name,
      this.overview,
      this.realsedata,
      this.image,
      this.vote})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff3E2C41),
          title: Text(name ?? '',style: TextStyle(color: Colors.cyanAccent,fontWeight: FontWeight.bold),),
        ),
        body: Container(
          color: Color(0xff261C2C),
          child: Column(
            children: [
              Expanded(
                child: Container(

                  decoration: BoxDecoration(
          border: Border.all(color: Color(0xff5C527F),width: 4,),

            image: DecorationImage(
                          image: NetworkImage(
                              'https://image.tmdb.org/t/p/original/${image}'),
                          fit: BoxFit.fill,
                      )),
                ),
              ),
              SizedBox(height: 10,),
              Text(name ?? '',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    realsedata ?? '',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                RatingBar.builder(
              unratedColor:Colors.blueGrey
                  ,itemSize: 20,
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 0.3),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.cyanAccent,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  vote.toString(),
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),

              ]),
              SizedBox(height: 15,),
              Text(
                overview ?? '',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),

            ],

          ),
        ));
  }
}






