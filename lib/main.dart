import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:ui/routes/app_routes.dart';

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoutes.router,
      theme: FlexColorScheme.light(
        scheme: FlexScheme.hippieBlue,
        useMaterial3: true,
      ).toTheme,
      darkTheme: FlexColorScheme.dark(
        scheme: FlexScheme.hippieBlue,
        useMaterial3: true,
      ).toTheme,
      themeMode: ThemeMode.system,
    );
  }
}

// void connectToServer() {
//   try {
//     // Configure socket transports must be specified
//     Socket socket = io('http://192.168.3.57:3000', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': false,
//     });

//     // Connect to websocket
//     socket.connect();

//     // Handle socket events
//     socket.on('connect', (_) => print('connect: ${socket.id}'));
//     // socket.on('location', handleLocationListen);
//     // socket.on('typing', handleTyping);
//     // socket.on('message', handleMessage);
//     socket.on('disconnect', (_) => print('disconnect'));
//     socket.on('fromServer', (_) => print(_));
//   } catch (e) {
//     print(e.toString());
//   }
// }
