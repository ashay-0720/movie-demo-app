import 'package:flutter/material.dart';
import '../description.dart';

class TV extends StatelessWidget {
  final List tv;

  const TV({ Key? key, required this.tv }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text("Popular TV shows",  style: TextStyle(fontSize: 20)),
          SizedBox(height: 10,),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tv.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => 
                    Description(
                      name: tv[index]['name'], 
                      bannerurl: 'https://image.tmdb.org/t/p/w500' + tv[index]['backdrop_path'],
                      posterurl: 'https://image.tmdb.org/t/p/w500' + tv[index]['poster_path'],
                      description: tv[index]['overview'],
                      vote: tv[index]['vote_average'].toString(),
                      launch_on: tv[index]['first_air_date'],
                      )));
                  },
                  child: (tv[index]['original_name'] != null && tv[index]['backdrop_path'] !=null )? Container(
                    padding: EdgeInsets.all(5),
                    // height: 140,
                    width: 250,
                    child: Column(
                      children: [
                        Container(
                          
                          height: 140,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                               image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500' + 
                                tv[index]['backdrop_path']
                              ),
                              fit: BoxFit.cover
                              )
                            ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          child: Text(tv[index]['original_name']!=null
                            ? tv[index]['original_name']
                            : 'Loading'),
                        )
                      ],
                    ),
                  ): Container(),
                );
              },
            ),
          )
        ],
      )
    );
  }
}