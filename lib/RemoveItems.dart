import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Remove extends StatefulWidget {
  const Remove({Key? key}) : super(key: key);

  @override
  State<Remove> createState() => _RemoveState();
}

class _RemoveState extends State<Remove> {
  TextEditingController _name = TextEditingController();
  TextEditingController _price = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Remove')),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            TextFormField(
              controller: _name,
              decoration: InputDecoration(
                  hintText: 'Enter the Product name'
              ),
            ),

            ElevatedButton(
                onPressed: () {
                  Remove(_name.text);
                }, child: Text('Remove'))
          ],
        ),
      ),
    );
  }
  void Remove(String name){
    final docUser=FirebaseFirestore.instance.collection('shops').doc('${name}');
    docUser.delete();
  }
}
