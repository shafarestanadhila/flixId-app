import 'package:flix_id_app/data/repositories/movie_repository.dart';
import 'package:flix_id_app/domain/entities/actor.dart';
import 'package:flix_id_app/domain/entities/result.dart';
import 'package:flix_id_app/domain/usecases/get_actors/get_actors_param.dart';
import 'package:flix_id_app/domain/usecases/usecase.dart';

class GetActors implements Usecase <Result<List<Actor>>, GetActorsParam> {
  final MovieRepository _movieRepository;

  GetActors({required MovieRepository movieRepository}) : _movieRepository = movieRepository;

  @override
  Future<Result<List<Actor>>>call(GetActorsParam params) async {
    var actorListResult = await _movieRepository.getActors(id: params.movieId);

    return switch(actorListResult) {
      Success(value: final actorList) => Result.success(actorList),
      Failed(:final message) => Result.failed(message)
    };
  }
}