import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((ref) {
  final getActors = ref.watch(actorsRepositoryProvider).getActorsByMovie;
  return ActorsByMovieNotifier(getActors: getActors);
});

typedef GetActorsCallback = Future<List<Actor>> Function({required String movieId});

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  ActorsByMovieNotifier({required this.getActors}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final List<Actor>actors = await getActors(movieId: movieId);

    state = {...state, movieId: actors};
  }
}
