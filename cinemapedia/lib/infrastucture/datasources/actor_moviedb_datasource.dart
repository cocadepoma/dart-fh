import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastucture/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastucture/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movieDbKey,
        'language': 'en-US'
      }
    )
  );

  List<Actor> _jsonToActor(Map<String, dynamic> json) {
    final movieDBResponse = CreditsResponse.fromJson(json);
    final List<Actor> actors = movieDBResponse.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();

    return actors;
  }

  @override
  Future<List<Actor>> getActorsByMovie({ required String movieId}) async {
    final response = await dio.get('/movie/$movieId/credits');

    final List<Actor> actors = _jsonToActor(response.data);
    return actors;
  }

}