import 'package:flutter/material.dart';
import 'package:movie_demo_app/models/movie.dart';
import 'package:movie_demo_app/services/data_service.dart';

// import 'movies2.dart';

class MoviesTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MoviesTabState();
}

class _MoviesTabState extends State<MoviesTab> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();
  List<Movie> _response = [];

  loadmovies() async{
    final response = await _dataService.getMovie("fight");
    setState(() => _response = response);
  }

  @override
  void initState() {
    loadmovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SingleChildScrollView(child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50),
                child: SizedBox(
                  width: 150,
                  child: TextField(
                      controller: _cityTextController,
                      decoration: InputDecoration(labelText: 'City'),
                      textAlign: TextAlign.center),
                ),
              ),
              ElevatedButton(onPressed: _search, child: Text('Search'))
            ],
          ),
        ),

        !_response.isEmpty ?
          Expanded(child: ListView.builder(
        itemCount: _response.length,
        itemBuilder: (context, index) {

          final movie = _response[index];

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
      )
      ) :
          Container()
      ]
      ),
    );
  }

  void _search() async {
    final response = await _dataService.getMovie(_cityTextController.text);
    setState(() => _response = response);
    print(response);
  }
}