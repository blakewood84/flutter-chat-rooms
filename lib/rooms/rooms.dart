import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'dart:developer' as devtools;

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  late final client = StreamChat.of(context).client;
  late final _listController = StreamChannelListController(
    client: client,
    filter: Filter.and(
      [
        Filter.equal('type', 'messaging'),
      ],
    ),
    limit: 20,
  );

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initiateClient(client);
    });
  }

  void initiateClient(StreamChatClient client) async {
    await client.connectUser(
      User(id: 'hello-world'),
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiaGVsbG8td29ybGQifQ.Z7c_-kw2NyYAy_Q_za9m5b2YyZjgtqoIr37EBb8APns',
    ); // final channel = client.channel('messaging', id: 'some-channel');
    // await channel.watch();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _listController.dispose();
    client.disconnectUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Material(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: StreamChannelListView(
        controller: _listController,
        onChannelTap: (channel) {
          devtools.log('${channel.id}');
        },
      ),
    );
  }
}
