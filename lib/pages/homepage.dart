import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:todo3/pages/addnote.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo3/pages/description.dart';



class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  FirebaseAuth auth=FirebaseAuth.instance;
  CollectionReference ref=FirebaseFirestore.instance.collection("notes").
    doc(FirebaseAuth.instance.currentUser!.uid).collection("mynotes");
  String uid='';
  @override
  void initState() {
    getuid();
    
    super.initState();
  }
  getuid()async{
    
    setState(() {
      uid=auth.currentUser!.uid;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          title:const Text('Notes'),
          actions: [
          IconButton(
              icon:const Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              }),
        ],
      ),
      body:StreamBuilder(stream: FirebaseFirestore.instance.collection("notes").
    doc(auth.currentUser!.uid).collection("mynotes").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState==ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
            
          }
          else{
            
            return ListView.builder(
              itemCount: snapshot.data!.docs.length
              ,itemBuilder:(context, index) {
                var time=(snapshot.data!.docs[index]['timestamp']as Timestamp).toDate();
                return InkWell(onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                  Editnote(title:snapshot.data!.docs[index]['title'],
                   description: snapshot.data!.docs[index]['description'],
                    ref: snapshot.data!.docs[index].reference,),));
                },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Expanded(
                      child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white
                                      
                        )
                      ),
                      
                        child: Slidable(endActionPane:ActionPane(motion: const StretchMotion()
                        , children: [
                          SlidableAction(onPressed: (context) async{
                            await FirebaseFirestore.instance.collection("notes").
                        doc(auth.currentUser!.uid).collection("mynotes").doc(snapshot.data!.docs[index]["time"]).delete();
                            
                          },autoClose: true,
                          borderRadius: BorderRadius.circular(10),
                          icon: Icons.delete,foregroundColor: Colors.red,)
                        ]) ,
                        child:  Container(
                                margin:const EdgeInsets.all( 10),
                              
                              width: MediaQuery.of(context).size.width,
                              
                        
                        
                              
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text( snapshot.data!.docs[index]['title'],
                                    style:GoogleFonts.roboto(fontSize: 20) ,),
                                  ),
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text( snapshot.data!.docs[index]['description']),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text(DateFormat.yMd().add_jm().format(time)),
                                   )
                                ],
                              ),
                            ),
                          
                        ),
                      ),
                    ),
                  ),
                );
              }, );
          }
        },),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const Addnote(),));
        
      },
      child: const Icon(Icons.edit),),
       );
  }
}