import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'main.dart';

class Insert extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return InsertState();
  }

}
class InsertState extends State<Insert>{
  TextEditingController title = TextEditingController();
  TextEditingController details = TextEditingController();
  final key = GlobalKey<FormState>();
  File image;
  String imgUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20),
                  child: InkWell(
                    onTap: ()async{
                      var imageGal =  await ImagePicker.pickImage(source: ImageSource.gallery);
                   setState(() {
                     image = imageGal;
                   });

                    },
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: image !=null ? FileImage(image) : NetworkImage("null"),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    controller: title,
                    decoration: InputDecoration(labelText: "title"),
                    validator: (v){
                     if(v.isEmpty){
                       return "you should add the title...";
                     }else{
                       return null;
                     }
                    },

                  )
                ),
                Padding(
                    padding: EdgeInsets.all(20),
                    child: TextFormField(
                      controller: details,
                      decoration: InputDecoration(labelText: "details"),
                      validator: (v){
                        if(v.isEmpty){
                          return "you should add the details...";
                        }else{
                          return null;
                        }
                      },

                    )
                ),
                Row(
                   children: <Widget>[
                     Padding(
                       padding: EdgeInsets.all(20),
                       child: RaisedButton(
                         color: Colors.yellow,
                         child: Text("insert data"),
                         onPressed: ()async {
                           if (key.currentState.validate()) {
                             var imageStorage = FirebaseStorage.instance.ref()
                                 .child(image.path)
                                 .putFile(image);
                             imgUrl = await (await imageStorage.onComplete).ref
                                 .getDownloadURL();
                             await Firestore.instance.collection("students")
                                 .add({
                               'title': title.text,
                               'img': imgUrl,
                               'details': details.text
                             });
                           }
                         },
                       ),
                     ),
                     Padding(
                       padding: EdgeInsets.all(20),
                       child: RaisedButton(
                         color: Colors.yellow,
                         child: Text("show data"),
                         onPressed: (){
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FireApp()));
                         },
                       ),
                     ),
                   ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}


