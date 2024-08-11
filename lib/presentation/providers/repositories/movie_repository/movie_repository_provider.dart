import 'package:flix_id_app/data/repositories/movie_repository.dart';
import 'package:flix_id_app/data/tmdb/tmdb_movie_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_repository_provider.g.dart';  // Pastikan ini sudah benar

@riverpod
MovieRepository movieRepository(MovieRepositoryRef ref) =>
  TmdbMovieRepository();