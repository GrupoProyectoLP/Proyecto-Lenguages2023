import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tmdb_style_app/src/models/credits.dart';
import 'package:tmdb_style_app/src/models/movies.dart';
import 'package:tmdb_style_app/src/models/user_login.dart';
import 'package:tmdb_style_app/src/widgets/constants.dart';

class AppProvider{
  Future<dynamic> loginProv(String username, String password){
    final credentials = UserLogin(username: username, password: password);
    return http.post(Uri.parse('${Constants.loginUrl}'), 
    body: credentials.toJson()).then((data) {
      if(data.statusCode == 200){
        final jsonData = json.decode(data.body);
        return jsonData;
      }
    }).catchError((err) => print(err));
  }


  List<Cast> credits = [];

  Future<List<Movies>> getPopularMovie(int page) async {
    final url = Uri.parse('${Constants.movieBasePath}''popular''${Constants.selectedLang}$page${Constants.key}');

    try {
      final res = await http.get(url);

      if (res.statusCode != 200) {
        throw Exception('Error al obtener los datos');
      }

      final String body = res.body;
      final bodyJson = json.decode(body)['results'] as List;
      
      return bodyJson.map((popular) => Movies.fromJson(popular)).toList();
    } catch (error) {
      throw Exception('Error al obtener los datos');
    }
  }

  Future<List<Movies>> getTopRatedMovies(int page) async {
    final url = Uri.parse('${Constants.movieBasePath}''top_rated''${Constants.selectedLang}$page${Constants.key}');
    
    try {
      final res = await http.get(url);

      if (res.statusCode != 200) {
        throw Exception('Error al obtener los datos');
      }

      final String body = res.body;
      final bodyJson = json.decode(body)['results'] as List;
      
      return bodyJson.map((topRated) => Movies.fromJson(topRated)).toList();
    } catch (error) {
      throw Exception('Error al obtener los datos');
    }
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

    Future<void> getCredits(Result movie) async {
    final url = Uri.parse('${Constants.movieBasePath}${movie.id}''/credits''${Constants.selectedLang}${Constants.key}');
    
    try {
      final res = await http.get(url);

      if (res.statusCode != 200) {
        throw Exception('Error al obtener los datos');
      }

      final Map<String, dynamic> data = json.decode(res.body);
      final List<dynamic> results = data['credits'];
      credits = results.map((results) => Cast.fromJson(results)).toList();
    } catch (error) {
      throw Exception('Error al obtener los datos');
    }
  }
}