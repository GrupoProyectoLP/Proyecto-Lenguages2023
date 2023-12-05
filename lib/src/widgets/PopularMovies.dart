import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:tmdb_style_app/src/widgets/constants.dart';

class PopularMovies extends StatelessWidget {
  PopularMovies({
    super.key, required this.snapshot,
  });
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
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 300,
              width: 200,
              child: Image.network(filterQuality: FilterQuality.high, fit: BoxFit.cover,
                      '${Constants.imagePath}${snapshot.data[itemIndex].posterPath}'),
            ),
          );
        }, //itemBilder
      ),
    );
  }
}
