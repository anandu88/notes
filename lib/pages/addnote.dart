import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class Addnote extends StatefulWidget {
  const Addnote({super.key});

  @override
  State<Addnote> createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();



  addtasktofirebase()async{
    FirebaseAuth auth=FirebaseAuth.instance;
    var time=DateTime.now();
    await FirebaseFirestore.instance.collection("notes").
    doc(auth.currentUser!.uid).collection("mynotes").doc(time.toString()).set({
      'title': titleController.text,
      'description': descriptionController.text,
      'time': time.toString(),
      'timestamp': time
    }).then((value) =>  Navigator.of(context).pop());
    Fluttertoast.showToast(msg: 'Data Added');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create new note"),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(keyboardType:TextInputType.text,
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: GoogleFonts.roboto(),
                  border: InputBorder.none
                ),
                
                
              ),
              const SizedBox(height: 10,),
              TextFormField(keyboardType: TextInputType.multiline,
              maxLines: null,
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: "Note",
                  hintStyle: GoogleFonts.roboto(),
                  border: InputBorder.none
                ),
                
              )
            ],
          ),
        ),
      ),
      floatingActionButton:  FloatingActionButton(onPressed: () {
        
        addtasktofirebase();

        
      },
      child:const  Icon(Icons.save),),
    );
  }
}