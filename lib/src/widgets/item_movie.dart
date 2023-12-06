import 'package:flutter/material.dart';
import 'package:tmdb_style_app/src/models/movies.dart';

class RowMovie extends StatelessWidget {
  const RowMovie({
    super.key,
    required this.movie,
  });

  final Movies movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 100,
                height: 150,
                child: Image.network(
                  "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title ?? 'Sin título',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow),
                        const SizedBox(width: 5),
                        Text(
                          movie.voteAverage.toString(),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 16, 51, 163),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${movie.overview!.length < 150 ? movie.overview : movie.overview?.substring(0, 150)}...',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
