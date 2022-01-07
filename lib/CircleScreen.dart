import 'package:flutter/material.dart';

class CircleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CircleScreenState();
}

class CircleScreenState extends State<CircleScreen> {
  @override
  Widget build(BuildContext context) {
    print("222");
    return Scaffold(
      appBar: AppBar(
        title: Text('Square'),
      ),
    );
  }
}