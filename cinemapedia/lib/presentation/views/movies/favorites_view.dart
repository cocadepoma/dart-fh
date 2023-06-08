import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> with AutomaticKeepAliveClientMixin {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    
    ref.read(favouriteMoviesProvider.notifier).loadNextPage();
  }

  void loadNextPage() async {
    if(isLoading || isLastPage) return;

    isLoading = true;
    final movies = await ref.read(favouriteMoviesProvider.notifier).loadNextPage();

    isLoading = false;

    if(movies.isEmpty) {
      isLastPage = true;
    }
  }
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final favouriteMovies = ref.watch(favouriteMoviesProvider).values.toList();

    if(favouriteMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite_outline_sharp, size: 50, color: colors.primary),
            const SizedBox(height: 5),
            Text('Ohhh no!!', style: TextStyle(fontSize:25, color: colors.primary)),
            const SizedBox(height: 5),
            const Text('You don\'t have favourite films', style: TextStyle(fontSize: 18, color: Colors.white38)),

            const SizedBox(height: 30),
            FilledButton.tonal(
              onPressed: () => context.go('/home/0'), 
              child: const Text('Go and find films!')
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(
        movies: favouriteMovies,
        loadNextPage: loadNextPage,
      )
    );
  }
}