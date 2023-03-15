import 'dart:typed_data';

import 'package:adminpanel/Grid/List.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:uuid/uuid.dart';

import 'Catalogmodel2.dart';
import 'caatalogmodel.dart';
class Stores extends StatefulWidget {
  const Stores({Key? key}) : super(key: key);

  @override
  State<Stores> createState() => _StoresState();
}

class _StoresState extends State<Stores> {
  List<String> S_array = [];
  List<String> C_array = [];
  void _addSize(String input) {
    setState(() {
      S_array.add(input);
    });
  }
  void _addColors(String input) {
    setState(() {
      C_array.add(input);
    });
  }
  TextEditingController _name = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _desc = TextEditingController();
  TextEditingController _color = TextEditingController();
  TextEditingController _size = TextEditingController();
  TextEditingController _image = TextEditingController();
  var size=[];
  var color=[];
  List<String> _locations = ['Sneakers', 'Boots', 'Loafers', 'Jogers','sandles']; // Option 2
  String? _selectedLocation;

  List<String> arr=['List','Grid'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1A237E),
        title: Text("Orders"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            DropdownButton(
              hint: Text('Select Category'), // Not necessary for Option 1
              value: _selectedLocation,
              onChanged: (newValue) {
                setState(() {
                  _selectedLocation = newValue;
                });
              },
              items: _locations.map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            ),
            Card(
              color: Colors.grey.shade200,
              child: TextFormField(
                controller: _name,
                decoration: InputDecoration(
                    hintText: 'Enter the Product name'
                ),
              ),
            ),
            Card(
              color: Colors.grey.shade200,
              child: TextFormField(
                controller: _desc,
                decoration: InputDecoration(
                    hintText: 'Enter the Product Description'
                ),
              ),
            ),
            Card(
              color: Colors.grey.shade200,
              child: TextFormField(
                controller: _price,
                decoration: InputDecoration(
                    hintText: 'Enter the Product Price'
                ),
              ),
            ),
            Card(
              color: Colors.grey.shade200,
              child: TextFormField(
                controller: _image,
                decoration: InputDecoration(
                    hintText: 'Enter the Image url'
                ),
              ),
            ),

            Card(
              color: Colors.grey.shade200,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter the Sizes'
                ),
                onSubmitted: (input) {
                  _addSize(input);
                },
              ),
            ),
            Card(
              color: Colors.grey.shade200,
              child: Padding(
                padding: const EdgeInsets.only(right: 450),
                child: Container(
                  height: 50,
                  width: 500,
                  child: ListView.builder(
                    itemCount: S_array.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Text("Size :${S_array[index]}"),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.grey.shade200,
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Enter the Colors'
                ),
                onSubmitted: (input) {
                  _addColors(input);
                },
              ),
            ),
            Card(
              color: Colors.grey.shade200,
              child: Padding(
                padding: const EdgeInsets.only(right: 450),
                child: Container(
                  height: 50,
                  width: 500,
                  child: ListView.builder(
                    itemCount: C_array.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Text("Color :${C_array[index]}"),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1A237E),
              ),
                onPressed: () {
                  createUser(name: _name.text, price: int.parse(_price.text),desc: _desc.text,color: C_array,size: S_array,image: _image.text);
                }, child: Text('Add')),

            SizedBox(
              height: 20,
            ),
            // ElevatedButton(
            //     onPressed: _openPicker, child: Text('Upload')),
            Text('Select your View'),
            SizedBox(
              height: 10,
            ),
            ToggleSwitch(
              initialLabelIndex: 1,
              totalSwitches: 2,
              labels: arr,
              onToggle: (index) {
                print('switched to: $index');
                View(index:index);
              },
            ),

          ],
        ),
      ),
    );
  }
  void _openPicker() async {
    FilePickerResult result;
    result = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png']
    ))!;
    if(result!=null){
     Uint8List? uploadFile= result.files.single.bytes;

     String filename=result.files.single.name;
     Reference reference=FirebaseStorage.instance.ref().child(Uuid().v1());
     final UploadTask uploadTask=reference.putData(uploadFile!);
     uploadTask.whenComplete(() {

     });
    }
  }


Future View({required var index}) async{
  final docUser = FirebaseFirestore.instance.collection('View').doc('View');
  docUser.update({
    'Value':arr[index]
  }
  );
}
  Future createUser({required String name,required price,required color,required size,required desc, required image}) async {
    final docUser = FirebaseFirestore.instance.collection(_selectedLocation!).doc(name);

    final user = Catalogmodel2(
      image:image,
      id: 2,
      name: name,
      price: price,
      desc: desc,
      size: size,
      color: color,
    );
    final json = user.toJson();
    await docUser.set(json);
  }
}
