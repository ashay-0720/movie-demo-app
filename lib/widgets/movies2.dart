import 'package:flutter/material.dart';
import 'package:movie_demo_app/models/movie.dart';

class MoviesWidget extends StatelessWidget {

  final List<Movie> movies; 

  MoviesWidget({required this.movies});
  

  @override
  Widget build(BuildContext context) {
    print(movies.length);
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        print(movies.length);
        final movie = movies[index];

        return ListTile(
          title: Row(children: [
            SizedBox(
              width: 100, 
              child: ClipRRect(
                child: Image.network(movie.poster), 
                borderRadius: BorderRadius.circular(10),
              )
             
            ), 
            Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,  
                  children: [
                  Text(movie.title),
                  Text(movie.year)
              ],),
                ),
            )
          ],)
        );
      }
    );
    
  }

}