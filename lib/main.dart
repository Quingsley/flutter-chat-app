import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/routes/app_routes.dart';

void main() {
  runApp(const ProviderScope(child: ChatApp()));
}

class ChatApp extends ConsumerWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var router = ref.watch(appRouterProvider);
    var isDarkMode = ref.watch(switchThemeStateProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: FlexColorScheme.light(
        scheme: FlexScheme.outerSpace,
        useMaterial3: true,
      ).toTheme,
      darkTheme: FlexColorScheme.dark(
        scheme: FlexScheme.outerSpace,
        useMaterial3: true,
      ).toTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }
}

final switchThemeStateProvider =
    StateProvider<bool>((ref) => true); // default is dark theme