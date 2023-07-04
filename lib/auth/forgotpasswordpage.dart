import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Forgotpasswordpage extends StatefulWidget {
  const Forgotpasswordpage({super.key});

  @override
  State<Forgotpasswordpage> createState() => _ForgotpasswordpageState();
}

class _ForgotpasswordpageState extends State<Forgotpasswordpage> {
 final  TextEditingController _emailcontroller=TextEditingController();
 @override
  void dispose() {
    _emailcontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Enter your email we will send an password resetting link",
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(fontSize: 20),),
          Padding(
           padding: const EdgeInsets.all(8.0),
           child: TextFormField(
            controller: _emailcontroller,
             keyboardType: TextInputType.emailAddress,
             decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:const BorderSide() 
              ),
              hintText: "enter your email",
              labelStyle: GoogleFonts.roboto()
             ),
         
           ),
         ),
         MaterialButton(onPressed: () {
          passwordreset();
           
         },
         child: Text("Reset password"),
         color: Colors.purple,
         )
        ],
      ),
    );
  }
  
 Future< void> passwordreset() async{
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailcontroller.text.trim());

    showDialog(context: context, builder: (context) {
      return AlertDialog(
             content: Text("password reset link sent Check your email")
      );
    },);
  } catch (e) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
             content: Text(e.toString())
      );
    },);
    
  }
 }
}