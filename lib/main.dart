import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'insert.dart';


void main()=>runApp(MaterialApp(home: Insert(),));
class FireApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("firestore app example"),),
      body: StreamBuilder(
        stream: Firestore.instance.collection("students").snapshots(),
        builder: (context, snap){
          return ListView.builder(
            itemCount: snap.data.documents.length,
            itemBuilder: (context, index){
              DocumentSnapshot course = snap.data.documents[index];
              return Card(
                elevation: 5,
                child: ListTile(
                  title: course["title"] == null? Text("title"): Text(course["title"]),
                  subtitle: course["details"] == null? Text("details"): Text(course["details"]),
                  leading: Image.network(course['img']),
                ),
              );
            },
          );
        },
      ),
    );
  }

}