import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen({this.parent, super.key});
  final Message? parent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StreamChannelHeader(),
      body: Column(
        children: [
          Expanded(
            child: StreamMessageListView(
              parentMessage: parent,
            ),
          ),
          const StreamMessageInput(),
        ],
      ),
    );
  }
}
