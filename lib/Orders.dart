import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';
import 'Cartmodel.dart';
import 'Dollae.dart';
import 'RemoveItems.dart';
import 'Stores.dart';
import 'caatalogmodel.dart';
import 'main.dart';
class FireBase extends StatefulWidget {
  const FireBase({Key? key}) : super(key: key);

  @override
  State<FireBase> createState() => _FireBaseState();
}

class _FireBaseState extends State<FireBase> {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    bool isTotalCalculated = false;
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Color(0xFF1A237E),
        title: Text("Orders"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: scaler.getPaddingLTRB(7, 12, 0, 0),
              child: Card(
                child: Container(
                  color: Colors.orange,
                  height: scaler.getHeight(9),
                  width: scaler.getWidth(69),
                  child: Row(
                    children: [
                      Padding(
                        padding: scaler.getPaddingLTRB(2, 0, 0, 0),
                        child: Text('Order-List:',
                        style: TextStyle(fontSize: scaler.getTextSize(10)),),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: scaler.getPaddingLTRB(7, 3, 0, 0),
              child: Container(
                height: scaler.getHeight(50),
                width: scaler.getWidth(70),
                child: StreamBuilder<List<Catalogmodel>>(
                    stream: readUser(),
                    builder: (context, snapshot){
                      if(snapshot.hasError){
                        return Text('something is wrong${snapshot.error}');
                      }
                      else if(snapshot.hasData){
                        final users=snapshot.data!;
                        if(isTotalCalculated==false) {
                          for (int i = 0; i < users.length; i++) {
                            for (int i = 0; i < users[i].price.length; i++) {
                              data = data + users[i].price[i];
                            }

                          }
                          isTotalCalculated=true;
                        }
                        globalValue=snapshot.data!;
                        context.watch<Cart>().total=snapshot.data!;
                        return ListView.builder(
                          itemCount:  users.length,
                            itemBuilder:(context, index){
                            return Card(
                              color: Colors.grey.shade200,
                              child: ListTile(
                                title: (Text('Date: ${users[index].date}         Time: ${users[index].time}           Email: ${users[index].email}              Address: ${users[index].address}              Phone-No: ${users[index].phone}')),
                                trailing: TextButton(
                                    onPressed: (){
                                      showDialog<void>(
                                        context: context,
                                        barrierDismissible: false, // user must tap button!
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Order Details'),
                                            content: SingleChildScrollView(
                                              child: Container(
                                                height: 200,
                                                width: 700,
                                                child: Column(
                                                  children:  <Widget>[
                                                    for(int i=0; i<users[index].name.length; i++)...
                                                    {
                                                      Row(
                                                        children: [
                                                          Card(
                                                            color:Colors.grey.shade200,
                                                            child: Container(
                                                                alignment: Alignment.center,
                                                              height:50,
                                                                width:200,
                                                                child: Text('Name: ${users[index].name[i]}')),
                                                          ),
                                                          Card(
                                                            color:Colors.grey.shade200,
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(left: 50),
                                                              child: Container(
                                                                  alignment: Alignment.center,
                                                                height:50,
                                                                  width:100,
                                                                  child: Text('Color: ${users[index].colors[i]}')),
                                                            ),
                                                          ),
                                                          Card(
                                                            color:Colors.grey.shade200,
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(left: 50),
                                                              child: Container(
                                                                alignment: Alignment.center,
                                                                height:50,
                                                                width:100,
                                                                child: Text('Size: ${users[index].size[i]}'),
                                                              ),
                                                            ),
                                                          ),
                                                          Card(
                                                            color:Colors.grey.shade200,
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(left: 50),
                                                              child: Container(
                                                                alignment: Alignment.center,
                                                                height:50,
                                                                  width:100,
                                                                  child: Text('Price: \$${users[index].price[i]}')),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    },
                                                  ],
                                                ),
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('Approve'),
                                                onPressed: () {
                                                  Text('${globalValue.length}');
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }, child: Icon(Icons.add)),

                              ),
                            );
                            });
                      }
                      else return Center(child: CircularProgressIndicator(),);
                    }
                ),
              ),
            ),
            Text('Total Orders: ${globalValue.length}',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: scaler.getTextSize(12)
            ),),
            Text('Total Cash: ${data}',style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: scaler.getTextSize(12)
            ),)
          ],
        ),
      ),
    );
  }

  Stream<List<Catalogmodel>> readUser()=>FirebaseFirestore.instance.collection('orders')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc)=>Catalogmodel.fromJson(doc.data())).toList());
}

