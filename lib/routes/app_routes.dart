import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/features/add/presentation/pages/create_new_contact.dart';
import 'package:ui/features/chat/presentation/pages/chat.dart';
import 'package:ui/features/home/presentation/pages/home.dart';
import 'package:ui/features/welcome/presentation/pages/welcome_page.dart';

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
            return ChatScreen(title: state.pathParameters['index']!);
          }),
      GoRoute(
        path: '/new-contact',
        builder: (context, state) => const NewContact(),
      )
    ],
  );
}
