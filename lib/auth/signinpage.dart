import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo3/auth/forgotpasswordpage.dart';

class Signinpage extends StatefulWidget {
  final VoidCallback showregisterpage;
  const Signinpage({super.key, required this.showregisterpage});

  @override
  State<Signinpage> createState() => _SigninpageState();
}

class _SigninpageState extends State<Signinpage> {
    TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10,top: 80),
              child: Text("Sign in your account",style: GoogleFonts.roboto(fontSize: 30),),
            ),
           const SizedBox(height: 20,),
           
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
            Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextFormField(
              controller: _passwordcontroller,
               keyboardType: TextInputType.emailAddress,
               decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:const BorderSide() 
                ),
                hintText: "enter your password",
                labelStyle: GoogleFonts.roboto()
               ),
           
             ),
           ),
           
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 25),
             child: Row(mainAxisAlignment: MainAxisAlignment.end,
             children: [
              GestureDetector(onTap:() {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => const Forgotpasswordpage(),));
              },
                child: Text("Forgot password", style: GoogleFonts.roboto(
                  color: Colors.blue
                ),),
              )
             ],
           
             ),
           ),
           const SizedBox(height: 20,),
           Container(padding:const EdgeInsets.all(5),
           width: double.infinity,
           height: 70,
           decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
           
           ),
           child: ElevatedButton(onPressed: () {
            signin();
            
             
           },
           
             child: Text('Sign in',
              style: GoogleFonts.roboto(fontSize: 16)),
              
           ),


           ),
          const  SizedBox(
            height: 30,
           ),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Not an member ?",style: GoogleFonts.roboto(),),
             const SizedBox(width: 5,),
              GestureDetector(onTap:widget.showregisterpage ,
                child: Text("registor now",style: GoogleFonts.roboto(color: Colors.blue),))
            ],
           )
          ],
        ),
      ),
    );
  }
  
  Future<void> signin()async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailcontroller.text.trim(),
       password: _passwordcontroller.text.trim());
  }
  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
   
    super.dispose();
  }
}