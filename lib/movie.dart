class Movie {
  String? title;
  String? overview;
  num? rate;
  String? posterpath;
   String? releasedate;

  Movie.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    overview = map['overview'];
    rate = map['vote_average'];
    posterpath = map["poster_path"];
    releasedate=map["release_date"];
  }

}