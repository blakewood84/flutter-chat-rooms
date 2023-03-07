import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_rooms/firebase_options.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'package:flutter_chat_rooms/config/key.dart';
import 'package:flutter_chat_rooms/rooms/rooms.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

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
          client: StreamChatClient(
            apiKey,
            logLevel: Level.INFO,
          ),
          child: widget,
        );
      },
      home: const RoomsScreen(),
    );
  }
}
