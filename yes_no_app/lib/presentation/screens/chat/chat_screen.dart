import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // leading: const Padding(
          //   padding: EdgeInsets.all(4),
          //   child: CircleAvatar(
          //     backgroundImage: NetworkImage(
          //         'https://w7.pngwing.com/pngs/404/357/png-transparent-star-wars-darth-vader-illustration-anakin-skywalker-mask-sith-costume-youtube-darth-vader-head-fictional-character-black-step.png'),
          //   ),
          // ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(4, 4, 18, 4),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://w7.pngwing.com/pngs/404/357/png-transparent-star-wars-darth-vader-illustration-anakin-skywalker-mask-sith-costume-youtube-darth-vader-head-fictional-character-black-step.png'),
                ),
              ),
              Text('TrollGPT 👻')
            ]
          ) ,
          centerTitle: false,
        ),
        body: _ChatView());
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                  controller: chatProvider.chartScrollController,
                    itemCount: chatProvider.messageList.length,
                    itemBuilder: (context, index) {
                      final message = chatProvider.messageList[index];

                      return (message.fromWho == FromWho.hers)
                      ? HerMessageBubble(message: message)
                      : MyMessageBubble(message: message);
                    }
                )
              ),
            // Meesage textbox
            MessageFieldBox(
              onValue: chatProvider.sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
