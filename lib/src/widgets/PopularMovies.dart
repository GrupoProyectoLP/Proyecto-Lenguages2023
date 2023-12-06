import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_style_app/src/models/movies.dart';
import 'package:tmdb_style_app/src/pages/movie_details.dart';

import 'package:tmdb_style_app/src/widgets/constants.dart';

class PopularMovies extends StatelessWidget {
  PopularMovies({super.key, required this.snapshot,});
final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: snapshot.data!.length,
        options: CarouselOptions(
          height: 300,
          autoPlay: true,
          viewportFraction: 0.55,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 1),
          enlargeCenterPage: true,
          pageSnapping: true,
        ),
       itemBuilder: (context, itemIndex, pageViewIndex) {
        Movies movie = snapshot.data[itemIndex];
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 300,
              width: 200,
              child: GestureDetector(
                child: Image.network(filterQuality: FilterQuality.high, fit: BoxFit.cover,
                        '${Constants.imagePath}${snapshot.data[itemIndex].posterPath}'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: ((context) => DetailsMovie(movie))));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
