import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DemoTeacherPage extends StatefulWidget {
  @override
  _DemoTeacherPageState createState() => _DemoTeacherPageState();
}

class _DemoTeacherPageState extends State<DemoTeacherPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    String id;
    String pass;
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('This is teacher Page'),
          Container(
            padding: EdgeInsets.fromLTRB(10,2,10,2),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: "Email address",
              ),
              onChanged: (value){
                id = value;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10,2,10,2),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: "Password",
              ),
              onChanged: (value){
              pass = value;
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(onPressed: () async{
                if(id!=null && pass!=null){
                 await firestore.collection('Students').doc().set({
                  'email':id,
                    'password':pass
                  });
                 _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                         content:  Text('New user added as Student!')
                     )
                 );
                }
              }, child: Text('As as Student'),color: Colors.grey,),
              SizedBox(width: 20,),
              FlatButton(onPressed: ()async{
                if(id!=null && pass!=null){
                 await firestore.collection('Teacher').doc().set({
                    'email':id,
                    'password':pass
                  });
                 _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                         content:  Text('New user added as Teacher!')
                     )
                 );
                }
              }, child: Text('As as Teacher'),color: Colors.grey,),
            ],
          ),
        ],
      ),
    );
  }
}
