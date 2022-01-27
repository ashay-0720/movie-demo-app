import 'package:flutter/material.dart';
import 'package:movie_demo_app/services/data_service.dart';
import 'package:movie_demo_app/widgets/home.dart';
import 'package:movie_demo_app/widgets/movies.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      )
      
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  List trendingmovies = [];
  List toprated = [];
  List tv = [];
  final _dataService = DataService();
  
  final apiKey = 'cc921c97b3ba759b63b7549a2c4729f9';
  final readAccessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjYzkyMWM5N2IzYmE3NTliNjNiNzU0OWEyYzQ3MjlmOSIsInN1YiI6IjYxZjA1Zjk0YWE2NTllMDA0NGIzOWQwZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.cg1qySxE3vT82MXKPjYMQw6vlYT2Os4wUj7Af2457EY';
  
  @override
  void initState() {
    loadmovies();
    super.initState();
  }

  loadmovies() async{
    TMDB tmdbwithcustomlogs = 
      TMDB(
        ApiKeys(apiKey, readAccessToken),
        logConfig: ConfigLogger(
          showLogs: true,
          showErrorLogs: true
        )
      );

    Map trendingresult = await tmdbwithcustomlogs.v3.trending.getTrending();
    Map topratedresult = await tmdbwithcustomlogs.v3.movies.getTopRated();
    Map tvresult = await tmdbwithcustomlogs.v3.tv.getPopular();
    final movie_detail = await _dataService.getMovie("550");
    // Map mov = await tmdbwithcustomlogs.v3.genres.getMovieList();

    setState(() {
      trendingmovies = trendingresult['results'];
      toprated = topratedresult['results'];
      tv = tvresult['results'];
    });
    // print(tv);
    // print(movie_detail);
    // print(trendingresult);
  }
  // List<Widget> _widgetOptions = <Widget>[
  //   MoviesTab(),
  //   MoviesTab()
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HD Movies App'),
      ),
      body: Center(
        child: _selectedIndex == 0 ? Home(trending: trendingmovies, tv: tv) : MoviesTab(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movies',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.school),
          //   label: 'School',
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

