import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String Id)async{
  await FirebaseFirestore.instance.collection("users").doc(Id).set(userInfoMap);}
}
Future addUserBooking(Map<String, dynamic> addBooking)async{
  await FirebaseFirestore.instance.collection("Bookings").add(addBooking);
}