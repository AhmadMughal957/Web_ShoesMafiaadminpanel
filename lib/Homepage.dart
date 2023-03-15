import 'package:adminpanel/Orders.dart';
import 'package:adminpanel/Stores.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

import 'Finance.dart';
import 'RemoveItems.dart';
import 'caatalogmodel.dart';
import 'main.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()
      ..init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1A237E),
        title: Text('Homepage'),
      ),
      body: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FireBase()));
            },
            child: Padding(
              padding: scaler.getPaddingLTRB(2, 2, 0, 0),
              child: Stack(
                  children: [
                    Container(
                      height: scaler.getHeight(25),
                      width: scaler.getWidth(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade100,
                              Colors.blueAccent.shade200
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 5),
                            ),

                          ]
                      ),
                    ),
                    Padding(
                      padding: scaler.getPaddingLTRB(7, 5, 0, 0),
                      child: Icon(Icons.shopping_cart,
                        size: scaler.getTextSize(18),),
                    ),
                    Padding(
                      padding: scaler.getPaddingLTRB(5, 16, 0, 0),
                      child: Text('Today Orders', style: TextStyle(
                          fontSize: scaler.getTextSize(10),
                          fontWeight: FontWeight.bold),),
                    )

                  ]),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Stores()));
            },
            child: Padding(
              padding: scaler.getPaddingLTRB(2, 2, 0, 0),
              child: Stack(
                  children: [
                    Container(
                      height: scaler.getHeight(25),
                      width: scaler.getWidth(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFC6FF00),
                              Color(0xFFE6EE9C)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 5),
                            ),

                          ]
                      ),
                    ),
                    Padding(
                      padding: scaler.getPaddingLTRB(7, 5, 0, 0),
                      child: Icon(Icons.store,
                        size: scaler.getTextSize(18),),
                    ),
                    Padding(
                      padding: scaler.getPaddingLTRB(5, 16, 0, 0),
                      child: Text('Add To Store', style: TextStyle(
                          fontSize: scaler.getTextSize(10),
                          fontWeight: FontWeight.bold),),
                    )

                  ]),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Remove()));
            },
            child: Padding(
              padding: scaler.getPaddingLTRB(2, 2, 0, 0),
              child: Stack(
                  children: [
                    Container(
                      height: scaler.getHeight(25),
                      width: scaler.getWidth(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFE65100),
                              Color(0xFFFFCC80)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 5),
                            ),

                          ]
                      ),
                    ),
                    Padding(
                      padding: scaler.getPaddingLTRB(7, 5, 0, 0),
                      child: Icon(Icons.remove_shopping_cart_outlined,
                        size: scaler.getTextSize(18),),
                    ),
                    Padding(
                      padding: scaler.getPaddingLTRB(5, 16, 0, 0),
                      child: Text('Remove Items', style: TextStyle(
                          fontSize: scaler.getTextSize(10),
                          fontWeight: FontWeight.bold),),
                    )

                  ]),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Finance()));
            },
            child: Padding(
              padding: scaler.getPaddingLTRB(2, 2, 0, 0),
              child: Stack(
                  children: [
                    Container(
                      height: scaler.getHeight(25),
                      width: scaler.getWidth(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              Colors.pink,
                              Colors.purple
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 5),
                            ),

                          ]
                      ),
                    ),
                    Padding(
                      padding: scaler.getPaddingLTRB(7, 5, 0, 0),
                      child: Icon(Icons.attach_money,
                        size: scaler.getTextSize(18),),
                    ),
                    Padding(
                      padding: scaler.getPaddingLTRB(7, 16, 0, 0),
                      child: Text('Finance', style: TextStyle(
                          fontSize: scaler.getTextSize(10),
                          fontWeight: FontWeight.bold),),
                    )

                  ]),
            ),
          ),


        ],
      ),
    );
  }
}
