import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo3/auth/authpage.dart';

import 'package:todo3/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo3/pages/homepage.dart';



 void  main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark,
      primaryColor: Colors.purple, 
      primarySwatch: Colors.purple),
      home:StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const  Homepage();
            
          }
          else {
            return const Authpage();
          }
        
      },)
    );
  }
}
          