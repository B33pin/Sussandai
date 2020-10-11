import 'package:flutter/material.dart';

class DemoParentPage extends StatefulWidget {
  @override
  _DemoParentPageState createState() => _DemoParentPageState();
}

class _DemoParentPageState extends State<DemoParentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('This is parents page'),
      ),
    );
  }
}
