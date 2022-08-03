import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tik_tok_flutter/controllers/auth_controller.dart';

// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

//FireBase

var firebaseAuth = FirebaseAuth.instance;
var fireStore = FirebaseFirestore.instance;
var firebaseStorage = FirebaseStorage.instance;

//Controller

var authController = AuthController.instance;
