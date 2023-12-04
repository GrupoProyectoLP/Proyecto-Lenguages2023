import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_style_app/src/models/credits.dart';
import 'package:tmdb_style_app/src/models/movies.dart';
import 'package:tmdb_style_app/src/providers/appProvider.dart';
import 'package:tmdb_style_app/src/widgets/MovieSlider.dart';
import 'package:tmdb_style_app/src/widgets/TrendingMovies.dart';
import 'package:tmdb_style_app/src/widgets/drawer.dart';

class Home extends StatefulWidget{
  Home({super.key});
  AppProvider get service => GetIt.I<AppProvider>();

  @override
  State<Home> createState() => _HomeState();
} 

class _HomeState extends State<Home>{
  late Future<List<Movies>> popularMovies;
  late Future<List<Movies>> topRatedMovies;
  late Future<List<Movies>> upcomingMovies;
  late Future<List<Person>> movieCredits;
  
@override
void initState(){
  super.initState();
}

@override
Widget build(BuildContext context){
 return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Image.asset('assets/images/HomeLogo.png', width: 250, height: 100, filterQuality: FilterQuality.high),
          centerTitle: true,
          ),
          
          drawer: DrawerElements(),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Trending movies',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 30),
              const PopularMovies(),
              SizedBox(height: 30),
              const Text(
                'Top Rated Movies',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              const MovieSlider(),
              const SizedBox(height: 30),
              const Text(
                'Upcoming Movies',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 30),
              const MovieSlider(),
            ],
          ),
        ),
      ),
          
        );
  }
}         