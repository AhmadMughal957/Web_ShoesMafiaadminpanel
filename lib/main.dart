import 'package:adminpanel/Grid/Login%20Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Cartmodel.dart';
import 'Finance.dart';
import 'Homepage.dart';
import 'Orders.dart';
import 'caatalogmodel.dart';
import 'package:firebase_core/firebase_core.dart';

/// This is a reimplementation of the default Flutter application using provider + [ChangeNotifier].
List globalValue = [];
 double data=0;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAr_-j8pyAN8VS-G7LTimxRj6yFTi8WuWI",
      projectId: "foodma-c3eab",
      messagingSenderId: "987361706862",
      storageBucket: "foodma-c3eab.appspot.com",
      appId: "1:987361706862:web:e50011ef0579e33ab0777f",
    )
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: const MaterialApp(
        home: Homepage(),
      ),
    ),
  );
}



