/**the provider for parent */

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


//ParentClass
class ParentInf  {

  final String id;
  final String schoolID;
  final String studentID;
  final String name;
  final String email;
  final String address;
  final String number;
  final String dateOfRegister;

  ParentInf({this.id,this.schoolID,this.studentID,this.name,this.email,this.address,this.number,this.dateOfRegister});

}

// the class for the provider

class Parent with ChangeNotifier{

  ParentInf _inf; // we will put the data that we will get at this variable

  // we will get the _inf variable by calling this function
    ParentInf getParentInf(){

      return _inf;
  }


  // we will insert the data using this function
  void setParentInf(ParentInf inf){

      _inf=inf;
      print(_inf);
      notifyListeners();

  }


  //we will use this function to login and get parent infromation by passing the username and password to it
  // we use it Future Boolean <so when we use it we check if the user logged properly return true other wise return false>
   Future<bool> loginParentAndGetInf(String user,String pass) async{
     FirebaseFirestore firestore = FirebaseFirestore.instance;
     try {
       QuerySnapshot docs = await firestore.collection('Students').get();
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

   return false;
    
  }

// i just used this function to make the code more organised and not so messed
  insertInf(dynamic datauser){

       ParentInf parentInf = ParentInf(
          id: datauser[0]['id'],
          studentID: datauser[0]['student_id'],
          schoolID: datauser[0]['school_id'],
          name: datauser[0]['name'],
          address: datauser[0]['address'],
          number: datauser[0]['number'],
          email: datauser[0]['email'],
          dateOfRegister: datauser[0]['date_of_register']);
          // after inserting then pass it to setParentInf to insert the data to our _inf variable
          setParentInf(parentInf);

  }

  
  logOut(){
    _inf=new ParentInf(); // we will empty the _inf variable cause the user logged out
    notifyListeners();
    print(_inf.id);
  }
  
  

}