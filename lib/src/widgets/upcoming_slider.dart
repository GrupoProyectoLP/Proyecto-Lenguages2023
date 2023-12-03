//import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
//import 'package:tmdb_style_app/src/models/movies.dart';
import 'package:tmdb_style_app/src/widgets/constants.dart';

class UpcomingClass extends StatelessWidget{
  UpcomingClass({
    super.key, required this.snapshot,
  });
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: double.infinity, 
            child: CarouselSlider.builder(
              itemCount: 10,
              options: CarouselOptions(
                height: 300, autoPlay: true, viewportFraction: 0.55, enlargeCenterPage: true, 
                pageSnapping: true, autoPlayAnimationDuration: const Duration(seconds: 3),
              ),
              itemBuilder: (context, index, pageViewIndex) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(height: 300, width: 200, 
                    child: Image.network( '${Constants.imagePath}${snapshot.data[index].posterPath}',
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                    )),
                );
              },            
            ),
            );
  }
}