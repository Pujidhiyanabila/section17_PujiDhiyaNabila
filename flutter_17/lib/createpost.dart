import 'package:flutter/material.dart';
import 'package:flutter_17/drawer_screen.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostPage createState() => _CreatePostPage();
}

class _CreatePostPage extends State<CreatePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
      ),
      drawer: DrawerScreen(),
      
    );
  }
}