import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:flutter/material.dart';

void main() async{

  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      routes: {
         LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        // ChatPage.id : (context) => ChatPage()
      },
         initialRoute: LoginPage.id,
    );
  }
}
