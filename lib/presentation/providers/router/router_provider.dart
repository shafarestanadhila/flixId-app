import 'package:flix_id_app/domain/entities/movie.dart';
import 'package:flix_id_app/presentation/pages/detail_page/detail_page.dart';
import 'package:flix_id_app/presentation/pages/login_page/login_page.dart';
import 'package:flix_id_app/presentation/pages/main_page/main_page.dart';
import 'package:flix_id_app/presentation/pages/register_page/register_page.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouter> router(RouterRef ref) => GoRouter(routes: [
  GoRoute(
    path: '/main',
    name: 'main',
    builder: (context, state) => MainPage(),
  ),
  GoRoute(
    path: '/login',
    name: 'login',
    builder: (context, state) => LoginPage(),
  ),
  GoRoute(
    path: '/register',
    name: 'register',
    builder: (context, state) => const RegisterPage(),
  ),
  GoRoute(
    path: '/detail',
    name: 'detail',
    builder: (context, state) => DetailPage(movie: state.extra as Movie),
  )
], initialLocation: '/login', debugLogDiagnostics: false);