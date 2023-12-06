import 'package:flutter/material.dart';
import 'package:tmdb_style_app/src/models/credits.dart';
import 'package:tmdb_style_app/src/widgets/constants.dart';

class Credit extends StatelessWidget {
  const Credit({
    super.key,
    required this.credits,
  });

  final List<Cast> credits;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: credits.map((index) {
          return Card(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                      width: 100,
                      height: 150,
                      child: (index.profilePath != null)
                          ? Image.network(
                              '${Constants.imagePath}${index.profilePath}',
                              fit: BoxFit.cover,
                            )
                          : const Center(
                              child: Icon(
                                Icons.person_2,
                                size: 120,
                              ),
                            )),
                ),
                Text(index.name),
                Text(index.character)
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
