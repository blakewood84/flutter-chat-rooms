import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() async {
  final client = StreamChatClient(
    '9dtqfpkev6vq',
    logLevel: Level.INFO,
  );

  await client.connectUser(
    User(
      id: 'new-user3',
      role: 'admin',
      name: "Blake Man",
      image: "https://i.imgur.com/fR9Jz14.png",
    ),
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoibmV3LXVzZXIzIn0.yLO8ARkaBtpAVteaHyU7W5xlN75EMsNhK95av8xasF4',
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
      title: 'Flutter Demo',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      builder: (context, widget) {
        return StreamChat(
          client: client,
          child: widget,
        );
      },
      home: ChatRoom(
        client: client,
      ),
    );
  }
}

class ChatRoom extends StatefulWidget {
  const ChatRoom({
    required this.client,
    super.key,
  });

  final StreamChatClient client;

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final _finishedLoadingNotifier = ValueNotifier(false);
  late final Channel channel;

  @override
  void initState() {
    super.initState();
    setAndConnectUser();
  }

  void setAndConnectUser() async {
    channel = widget.client.channel('messaging', id: 'some-channel');

    await channel.watch();

    _finishedLoadingNotifier.value = true;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // return const SizedBox.shrink();
    return Scaffold(
      body: ValueListenableBuilder(
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
    );
  }
}
