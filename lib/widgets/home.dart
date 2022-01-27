// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_demo_app/widgets/trending.dart';
import 'package:movie_demo_app/widgets/tv.dart';

class Home extends StatelessWidget {
  final List trending, tv;
  const Home({ Key? key, required this.trending, required this.tv }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TV(tv: tv),
        TrendingMovies(trending: trending)
      ],
    );
  }
}