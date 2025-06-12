import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'pages/chat_page.dart';

void main() async {
 await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginPage.screenRoute,
      routes: {
        LoginPage.screenRoute: (context) => LoginPage(),
        RegisterPage.screenRoute: (context) => RegisterPage(),
        ChatPage.screenRoute: (context) => ChatPage(),

      
      },
      
      
    );
  }
}
