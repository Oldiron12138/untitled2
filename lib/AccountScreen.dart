import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AccountScreenState();
}

class AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    print("333");
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
    );
  }
}