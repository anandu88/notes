import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class Signuppage extends StatefulWidget {
  final VoidCallback showloginpage;
  const Signuppage({super.key, required this.showloginpage});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  final TextEditingController _emailcontroller = TextEditingController();
 final  TextEditingController _passwordcontroller = TextEditingController();
 final  TextEditingController _usernamecontroller=TextEditingController();
 final TextEditingController _conformpasswordcontroller=TextEditingController();
  

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _conformpasswordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body:SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10,top: 80),
              child: Text("Create New account",style: GoogleFonts.roboto(fontSize: 30),),
            ),
           const SizedBox(height: 20,),
            Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextFormField(
              controller: _usernamecontroller,
               keyboardType: TextInputType.emailAddress,
               decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:const BorderSide() 
                ),
                hintText: "enter your username",
                labelStyle: GoogleFonts.roboto()
               ),
           
             ),
           ),
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
             padding: const EdgeInsets.all(8.0),
             child: TextFormField(
              controller: _conformpasswordcontroller,
               keyboardType: TextInputType.emailAddress,
               decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:const BorderSide() 
                ),
                hintText: "conform your password",
                labelStyle: GoogleFonts.roboto()
               ),
           
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
            signup();
             
           },
           
             child: Text('SignUp',
              style: GoogleFonts.roboto(fontSize: 16)),
              
           ),


           ),
           const  SizedBox(
            height: 30,
           ),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("ALready an member ?",style: GoogleFonts.roboto(),),
              GestureDetector(onTap: widget.showloginpage,
                child: Text("sign in now",style: GoogleFonts.roboto(color: Colors.blue),))
            ],
           )
          ],
        ),
      ),
    );
  }
  
  Future<void > signup()async {
    //create user
    if (passwordisconform()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailcontroller.text.trim(),
       password: _passwordcontroller.text.trim());

       //add user details
          adduserdetails(_usernamecontroller.text.trim());
      
    }
   
  }Future adduserdetails(String username)async{
    FirebaseFirestore.instance.collection("users").add({
      'username':username

    });
  }
  bool passwordisconform(){
    if (_passwordcontroller.text.trim()==_conformpasswordcontroller.text.trim()) {

      return true;
      
    }else{
      return false;
    }
    

  }
  
 
}