import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_fonts/google_fonts.dart';

class Editnote extends StatefulWidget {
   final  String title, description;
   final DocumentReference ref;
   const Editnote({super.key, required this.title, required this.description, required this.ref});

  @override
  State<Editnote> createState() => _EditnoteState();
}

class _EditnoteState extends State<Editnote> {
  TextEditingController titleController = TextEditingController( );
  TextEditingController descriptionController = TextEditingController();

  

  



  
  @override
  Widget build(BuildContext context) {
    titleController.text=widget.title;
    descriptionController.text=widget.description;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit note"),

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
        updatetask();
        
      },
      child:const  Icon(Icons.edit),),
    );
  }
  
   updatetask()async {
    widget.ref.update(
    {
      'title': titleController.text,
      'description': descriptionController.text,
       
    }  
    ).then((value) =>  Navigator.of(context).pop());
    Fluttertoast.showToast(msg: 'Data Added');
   }
}