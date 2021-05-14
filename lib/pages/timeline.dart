// import 'package:flutter/material.dart';
// import '../widgets/header.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// final CollectionReference usersRef = Firestore.instance.collection('users');
// final postsRef = Firestore.instance.collection('posts');
//
// class Timeline extends StatefulWidget {
//   @override
//   _TimelineState createState() => _TimelineState();
// }
//
// class _TimelineState extends State<Timeline> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   buildComments() {
//     return StreamBuilder(
//       stream: postsRef
//           .document()
//           .collection('userPosts')
//           .orderBy("timestamp", descending: false)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return circularProgress();
//         }
//         List<Comment> comments = [];
//         snapshot.data.documents.forEach((doc) {
//           comments.add(Comment.fromDocument(doc));
//         });
//         return ListView(
//           children: comments,
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(context) {
//     return Scaffold(
//       appBar: header(context, isAppTitle: true),
//       body: Text("TimeLine"),
//     );
//   }
// }
