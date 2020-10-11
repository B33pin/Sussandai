/**the provider for teacher */

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//TeacherClass
class TeacherInf  {

  final String id;
  final String schoolID;
  final String name;
  final String subject;
  final String email;
  final String address;
  final String number;
  final String dateOfRegister;

  TeacherInf({this.id,this.schoolID,this.name,this.subject,this.email,this.address,this.number,this.dateOfRegister});

}

// the class for the provider
class Teacher with ChangeNotifier{

  TeacherInf _inf; // we will put the data that we will get at this variable

// we will get the _inf variable by calling this function
    TeacherInf getTeacherInf(){

      return _inf;
  }


    // we will insert the data using this function
  void setTeacherInf(TeacherInf inf){

      _inf=inf;
      print(_inf);
      notifyListeners();

  }

  //we will use this function to login and get parent infromation by passing the username and password to it
  // we use it Future Boolean <so when we use it we check if the user logged properly return true other wise return false>
   Future<bool> loginTeacherAndGetInf(String user,String pass) async{
     FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
     QuerySnapshot docs = await firestore.collection('Teacher').get();
      if(docs.size>0){
      final users = docs.docs;
      bool count = false;
      for(int i = 0; i<docs.size;i++){
        if((users[i].data()['email']==user) &&(users[i].data()['password']==pass)){
          count = true;
        }
      } if (count == true){
        return true;
      } else {
        return false;
      }
      }
    }catch(e){
      print(e); // else print the error then return false
      
    }
  }

// i just used this function to make the code more organised and not so messed
  insertInf(dynamic datauser){

       TeacherInf parentInf = TeacherInf(
          id: datauser[0]['id'],
         
          schoolID: datauser[0]['school_id'],
          name: datauser[0]['name'],
          subject: datauser[0]['subject'],
          address: datauser[0]['address'],
          number: datauser[0]['number'],
          email: datauser[0]['email'],
          dateOfRegister: datauser[0]['date_of_register']);
          setTeacherInf(parentInf);

  }

  
    logOut(){
    _inf=new TeacherInf(); // we will empty the _inf variable cause the user logged out
    notifyListeners();
    print(_inf.id);
  }

  
  
  
  

}