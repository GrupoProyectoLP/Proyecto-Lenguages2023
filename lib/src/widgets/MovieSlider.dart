import 'package:flutter/material.dart';
import 'package:tmdb_style_app/src/models/movies.dart';
import 'package:tmdb_style_app/src/pages/movie_details.dart';
import 'package:tmdb_style_app/src/widgets/constants.dart';

class MovieSlider extends StatelessWidget {
  const MovieSlider({
    super.key, required this.snapshot
  });
final AsyncSnapshot snapshot;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          Movies movie = snapshot.data[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox( 
                height: 200,
                width: 150,
                child: GestureDetector(
                  child: Image.network(filterQuality: FilterQuality.high, fit: BoxFit.cover,
                  '${Constants.imagePath}${snapshot.data![index].posterPath}'),
                  onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: ((context) => DetailsMovie(movie))));
                },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
