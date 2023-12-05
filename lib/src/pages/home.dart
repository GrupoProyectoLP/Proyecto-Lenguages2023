import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_style_app/src/models/movies.dart';
import 'package:tmdb_style_app/src/providers/appProvider.dart';
import 'package:tmdb_style_app/src/widgets/MovieSlider.dart';
import 'package:tmdb_style_app/src/widgets/PopularMovies.dart';
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
  
@override
void initState(){
  super.initState();
  popularMovies = AppProvider().getPopularMovie();
  topRatedMovies = AppProvider().getTopRatedMovies();
  upcomingMovies = AppProvider().getUpcomingMovies();
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
              Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
            child: Text('Populares',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 25, fontFamily: 'muli'
                ),
              ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                child: FutureBuilder(
                future: popularMovies, 
                builder: (context, snapshot){
                  if(snapshot.hasError){
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }else if(snapshot.hasData){
                    return PopularMovies(snapshot: snapshot);
                  }else{
                    return const Center(child: CircularProgressIndicator(),);
                  }
                }),
              ),
              const SizedBox(height: 30),
              Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
            child: Text('Mejor Valoradas',
                style: TextStyle(
                  color: Colors.black87, 
                  fontSize: 25, fontFamily: 'muli'
                ),
              ),
              ),
              SizedBox(
                child: FutureBuilder(
                future: topRatedMovies, 
                builder: (context, snapshot){
                  if(snapshot.hasError){
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }else if(snapshot.hasData){
                    return MovieSlider(snapshot: snapshot);
                  }else{
                    return const Center(child: CircularProgressIndicator(),);
                  }
                }),
              ),
              const SizedBox(height: 30),
              Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
            child: Text('Próximos Estrenos',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 25, fontFamily: 'muli'
                ),
              ),
              ),
              SizedBox(
                child: FutureBuilder(
                future: upcomingMovies, 
                builder: (context, snapshot){
                  if(snapshot.hasError){
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }else if(snapshot.hasData){
                    return MovieSlider(snapshot: snapshot);
                  }else{
                    return const Center(child: CircularProgressIndicator(),);
                  }
                }),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
        );
  }
}         