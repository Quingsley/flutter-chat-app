import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/features/add/presentation/pages/create_new_contact.dart';
import 'package:ui/features/auth/data/models/user_model.dart';
import 'package:ui/features/chat/presentation/pages/chat.dart';
import 'package:ui/features/home/presentation/pages/home.dart';
import 'package:ui/features/auth/presentation/pages/auth_page.dart';

class AppRoutes {
  static GlobalKey<NavigatorState> mainNav = GlobalKey(debugLabel: 'Nav Key');
  static final router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) {
          return const Home();
        },
      ),
      GoRoute(
          path: '/chat',
          builder: (context, state) {
            User user = state.extra as User;
            return ChatScreen(contact: user);
          }),
      GoRoute(
        path: '/new-contact',
        builder: (context, state) => const NewContact(),
      )
    ],
  );
}

final appRouterProvider = Provider<GoRouter>((ref) {
  return AppRoutes.router;
});
