import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_demo_app/models/movie.dart';

class DataService {
  Future<List<Movie>> getMovie(String movieTitle) async {
    // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
    // final response = await http.get("http://www.omdbapi.com/?s=Batman&page=2&apikey=564727fa");
    String url =  "https://www.omdbapi.com/?s="+movieTitle+"&apikey=1c5b40d4";
    var uri = Uri.parse(url);
    final response = await http.get(uri);

    // print(response.body);
    // Map json = jsonDecode(response.body);
    

    if(response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["Search"];
      return list.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Failed to load movies!");
    }


    // return json;
  }
}