import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'package:flutter_chat_rooms/config/key.dart';
import 'package:flutter_chat_rooms/rooms/rooms.dart';

void main() async {
  final client = StreamChatClient(
    apiKey,
    logLevel: Level.INFO,
  );

  runApp(MyApp(
    client: client,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.client, super.key});

  final StreamChatClient client;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Rooms Demo',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      builder: (context, widget) {
        return StreamChat(
          client: client,
          child: widget,
        );
      },
      home: const RoomsScreen(),
    );
  }
}
