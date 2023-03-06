import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const ChatRoom(),
    );
  }
}

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final apiKey = "9dtqfpkev6vq";
  final client = StreamChatClient(
    '9dtqfpkev6vq',
    logLevel: Level.INFO,
  );

  final _finishedLoadingNotifier = ValueNotifier(false);

  late final Channel channel;

  @override
  void initState() {
    super.initState();
    setAndConnectUser();
  }

  void setAndConnectUser() async {
    await client.connectUser(
      User(
        id: 'new-user2',
        name: "Blake Man",
        image: "https://i.imgur.com/fR9Jz14.png",
      ),
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoibmV3LXVzZXIyIn0.ex3zllYgTjY8Lc16_XtEmOx80ABRTJouYyo_So-Qf0I',
    );

    channel = client.channel('messaging', id: 'some-channel');

    await channel.watch();

    _finishedLoadingNotifier.value = true;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: StreamChat(
        client: client,
        child: ValueListenableBuilder(
          valueListenable: _finishedLoadingNotifier,
          builder: (__, bool isFinished, _) {
            if (!isFinished) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return StreamChannel(
              channel: channel,
              child: Column(
                children: const [
                  StreamChannelHeader(),
                  Expanded(
                    child: StreamMessageListView(),
                  ),
                  StreamMessageInput(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
