import 'package:flutter/material.dart';
import 'package:movie_demo_app/services/data_service.dart';

class MoviesTab extends StatelessWidget {
  final List movies;
  MoviesTab({ Key? key, required this.movies }) : super(key: key);

  final _cityTextController = TextEditingController();
  final _dataService = DataService();

  

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {

        final movie = movies[index];

        return movie['title']!=null ? ListTile(
          title: Row(children: [
            SizedBox(
              width: 100, 
              child: ClipRRect(
                child: Image.network('https://image.tmdb.org/t/p/w500' +movie['poster_path']), 
                borderRadius: BorderRadius.circular(10),
              )
             
            ), 
            Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,  
                  children: [
                  Text(movie['title']),
                  SizedBox(height: 7),
                  Text("Release: "+ movie['release_date']),
                  SizedBox(height: 7),
                  Text("Average rating: "+ movie['vote_average'].toString())
              ],),
                ),
            )
          ],)
        ): Container();
      }
    );
  }

  // void _search() async {
  //   final response = await _dataService.getMovie(_cityTextController.text);
  //   setState(() => _response = response);
  // }
}