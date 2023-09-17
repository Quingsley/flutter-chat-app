import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/features/chat/pages/chat.dart';
import 'package:ui/features/home/pages/home.dart';
import 'package:ui/features/welcome/pages/welcome_page.dart';

class AppRoutes {
  static GlobalKey<NavigatorState> mainNav = GlobalKey(debugLabel: 'Nav Key');
  static final router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) {
          return const Home();
        },
      ),
      GoRoute(
          path: '/chat/:index',
          builder: (context, state) {
            return Chat(title: state.pathParameters['index']!);
          }),
    ],
  );
}
