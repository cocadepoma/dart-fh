import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>>Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;

  SearchMovieDelegate({
    required this.searchMovies
  });
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
        FadeIn(
          animate: query.isNotEmpty,
          duration: const Duration(milliseconds: 300),
          child: IconButton(
            onPressed: () => query = '',
            icon: const Icon(Icons.clear) ,
          ),
        )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searchMovies(query),
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(
            movie: movies[index],
            onMovieSelected: close,
          ),
        );
      },
    );
  }

@override
  String? get searchFieldLabel => 'Search movie';
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({
    required this.movie,
    required this.onMovieSelected
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            // Image
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
                ),
              ),
            ),
    
            const SizedBox(width: 10),
    
            SizedBox(
              width: size.width * 0.7,
              child: SizedBox(
                // height: 150,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyles.titleMedium),
                    const SizedBox(height: 10),
                  
                    (movie.overview.length > 70)
                      ? Text('${movie.overview.substring(0, 70)}...')
                      : Text(movie.overview),
    
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.star_half_rounded, color: Colors.yellow.shade800),
                        Text(
                          HumanFormats.number(movie.voteAverage, 1),
                          style: textStyles.bodyMedium!.copyWith(color: Colors.yellow.shade900),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
            // Description
          ],
    
        ),
      ),
    );
  }
}
