import 'package:flutter/material.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://w7.pngwing.com/pngs/404/357/png-transparent-star-wars-darth-vader-illustration-anakin-skywalker-mask-sith-costume-youtube-darth-vader-head-fictional-character-black-step.png'),
          ),
        ),
        title: const Text('Mi amor 🦁'),
        centerTitle: false,
      ),
      body: _ChatView()
    );
  }
}

class _ChatView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return (index % 2 == 0)
                  ? const HerMessageBubble()
                  : const MyMessageBubble();
              })
            ),
            // Meesage textbox
            const MessageFieldBox(),
          ],
        ),
      ),
    );
  }
}