import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

Future<void> handleFirstVerifiedLogin(User user ,Logger logger) async {

  ///TODO , checking if the document /users/userid exist in the firestore and user data (here we get the riverpod additional create account data , or if it fail to find the additional data we ask user to implement again the data)
  ///TODO , opening connection with firestore for getting new snapshots 
  ///TODO , checking fcm tokens current state , so it know what it should do e.g  asking user for notification access , updating fcm token
   
}