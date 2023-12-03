import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:tmdb_style_app/src/models/movies.dart';
import 'package:tmdb_style_app/src/providers/appProvider.dart';
import 'package:tmdb_style_app/src/widgets/constants.dart';
import 'package:tmdb_style_app/src/widgets/drawer.dart';
import 'package:tmdb_style_app/src/widgets/upcoming_slider.dart';

class Home extends StatefulWidget{
  Home({super.key});
  AppProvider get service => GetIt.I<AppProvider>();

  @override
  State<Home> createState() => _HomeState();
} 

class _HomeState extends State<Home>{
  late Future<List<Movies>> upcomingApiConsumer;
  
@override
void initState(){
  super.initState();
  upcomingApiConsumer = getUpcomingMovies(currentPage);
//  upcomingApiConsumer = loadMovies(context);
}

  int currentPage = 1;
  RxList<Movies> currentMovies = <Movies>[].obs;
@override
Widget build(BuildContext context){
  loadMovies(context);
 return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Image.asset('assets/images/HomeLogo.png', width: 250, height: 100, filterQuality: FilterQuality.high),
          centerTitle: true,
          ),
          
          drawer: DrawerElements(),

      body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Estrenos', style: TextStyle(fontSize: 20),),
            const SizedBox(height: 30),
            SizedBox(
              child: FutureBuilder(
                future: upcomingApiConsumer, builder: (context, snapshot){
                if (snapshot.hasError){
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if(snapshot.hasData){
                  return UpcomingClass(snapshot: snapshot,);
                }else{
                  return const Center(child: CircularProgressIndicator(),);
                }
              }),
            )
          ],
        ),
      ),
    )
          
        );
  }


  Future<List<Movies>> getUpcomingMovies(int page) async {
  final url = Uri.parse('${Constants.movieBasePath}''upcoming''${Constants.selectedLang}$page${Constants.key}');
    try {
      final res = await http.get(url);

      if (res.statusCode != 200) {
        throw Exception('Error al obtener los datos');
      }

      final String body = res.body;
      final bodyJson = json.decode(body)['results'] as List;
      
      return bodyJson.map((upcoming) => Movies.fromJson(upcoming)).toList();
    } catch (error) {
      throw Exception('Error al obtener los datos');
    }
  }

  Future<List<Movies>> loadMovies(BuildContext context) async {
    final scaffold = ScaffoldMessenger.of(context);
    try {
      final nextPage = currentPage + 1;
      final newMovies = await getUpcomingMovies(nextPage);
      currentMovies.addAll(newMovies);
      currentPage = nextPage;
      return currentMovies;
    } catch (e) {
      scaffold.showSnackBar(
        const SnackBar(
          content: Text("Error al cargar más películas"),
          duration: Duration(seconds: 2),
        ),
      );
      return [];
    }
  }
}         