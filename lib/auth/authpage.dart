import 'package:flutter/material.dart';
import 'package:todo3/auth/signinpage.dart';
import 'package:todo3/auth/signuppage.dart';

class Authpage extends StatefulWidget {
  const Authpage({super.key});

  @override
  State<Authpage> createState() => _AuthpageState();
}

class _AuthpageState extends State<Authpage> {
  bool showloginpage=true;
  void togglescreens(){
    setState(() {
      showloginpage=!showloginpage;
    });

  }
  @override
  Widget build(BuildContext context) {
    if (showloginpage) {
      return Signinpage(showregisterpage: togglescreens,);
      
    }else{
    return Signuppage(showloginpage: togglescreens,);
    }
  }
}