import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static const String screenRoute = 'ChatPage';

  final _controller = ScrollController();

  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesCollections,
  );
  TextEditingController controller = TextEditingController();

  void sendMessage(String email) {
    if (controller.text.isNotEmpty) {
      messages.add({
        kMessage: controller.text,
        kCreatedAt: DateTime.now(),
        'id': email,
      });
      controller.clear();
      _controller.animateTo(
        0,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Image.asset(kLogo, height: 50), Text('chat')],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBuble(message: messagesList[index])
                          : ChatBubleForFriend(message: messagesList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (_) => sendMessage(email),
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send, color: kPrimaryColor),
                        onPressed: () => sendMessage(email),
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text('Loading...');
        }
      },
    );
  }
}
