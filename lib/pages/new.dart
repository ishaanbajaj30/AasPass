import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/header.dart';
import 'package:fluttershare/widgets/progress.dart';
import 'home.dart';
import 'package:timeago/timeago.dart' as timeago;

final postsRef = Firestore.instance.collection('posts');

class Comments extends StatefulWidget {
  @override
  CommentsState createState() => CommentsState();
}

class CommentsState extends State<Comments> {
  // TextEditingController commentController = TextEditingController();
  // final String postId;
  // final String postOwnerId;
  // final String postMediaUrl;
  //
  // CommentsState({
  //   this.postId,
  //   this.postOwnerId,
  //   this.postMediaUrl,
  // });

  buildComments() {
    return StreamBuilder(
      stream: postsRef
          .document("106119420584115575134")
          .collection('userPosts')
          .orderBy("timestamp", descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        List<Comment> comments = [];
        snapshot.data.documents.forEach((doc) {
          comments.add(Comment.fromDocument(doc));
        });
        return ListView(
          children: comments,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: "TimeLine"),
      body: Column(
        children: <Widget>[
          Expanded(child: buildComments()),
          Divider(),
        ],
      ),
    );
  }
}

class Comment extends StatelessWidget {
  final String username;
  // final String userId;
  final String mediaUrl;
  final String description;
  final Timestamp timestamp;

  Comment({
    this.username,
    // this.userId,
    this.mediaUrl,
    this.description,
    this.timestamp,
  });

  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
      username: doc['username'],
      // userId: doc['userId'],
      description: doc['description'],
      timestamp: doc['timestamp'],
      mediaUrl: doc['mediaUrl'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(description),
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(mediaUrl),
          ),
          subtitle: Text(timeago.format(timestamp.toDate())),
        ),
        Divider(),
      ],
    );
  }
}
