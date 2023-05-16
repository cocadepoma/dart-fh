import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

class ActorsRepositoyImpl extends ActorsRepository {
  final ActorsDatasource datasource;
  ActorsRepositoyImpl(this.datasource);

  @override
  Future<List<Actor>> getActorsByMovie({ required String movieId}) {
    return datasource.getActorsByMovie(movieId: movieId);
  }
  
}