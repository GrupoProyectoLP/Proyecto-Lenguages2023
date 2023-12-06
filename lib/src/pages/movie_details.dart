import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tmdb_style_app/src/models/credits.dart';
import 'package:tmdb_style_app/src/models/movies.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tmdb_style_app/src/widgets/item_credits.dart';
import 'package:tmdb_style_app/src/widgets/constants.dart';

//ignore: must_be_immutable
class DetailsMovie extends StatelessWidget {
  final Movies movie;
  DetailsMovie(this.movie);

  List<Cast> credits = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('${movie.title}', style: TextStyle(color: Color.fromARGB(255, 13, 37, 63)),),
        leading: IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 13, 37, 63))),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 350,
              child: Stack(children: [
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: CachedNetworkImage(
                    placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(strokeWidth: 4)),
                    errorWidget: (context, url, error) => const Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud_off),
                        Text("Sin conexión"),
                      ],
                    ),
                    imageUrl:
                        '${Constants.imagePath}${movie.backdropPath}',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 50,
                  left: MediaQuery.of(context).size.width * 0.5 - 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(strokeWidth: 4)),
                      errorWidget: (context, url, error) => const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.cloud_off),
                          Text("Sin conexión"),
                        ],
                      ),
                      imageUrl:
                          '${Constants.imagePath}${movie.posterPath}',
                      width: 200,
                      height: 300,
                    ),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.calendar_month),
                      Text(movie.releaseDate ?? 'No hay fecha de lanzamiento disponible'),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.language),
                      Text(
                          'Lenguaje: ${(movie.originalLanguage).toUpperCase()}'),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const RowStars(),
                      Text(
                        'Calificación: ${movie.voteAverage}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Descripción",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(movie.overview ?? 'Sin descripción disponible'),
                    const Text(
                      "Reparto",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    FutureBuilder(
                        future: getCredits(movie),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Credit(credits: credits),
                            );
                          } else if (snapshot.hasError) {
                            return const Text('Error al obtener los créditos.');
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getCredits(Movies movie) async {
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

class RowStars extends StatelessWidget {
  const RowStars({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.star,
          color: Colors.amber,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
        ),
      ],
    );
  }
}
