import 'package:cinemapedia/infrastucture/datasources/actor_moviedb_datasource.dart';
import 'package:cinemapedia/infrastucture/repositories/actors_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorsRepositoyImpl(ActorMovieDbDatasource());
});
