import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'Cartmodel.dart';
import 'Dollae.dart';
import 'caatalogmodel.dart';
import 'main.dart';

class Finance extends StatefulWidget {
  const Finance({Key? key}) : super(key: key);

  @override
  State<Finance> createState() => _FinanceState();
}

class _FinanceState extends State<Finance> {


  void total(){
    for(int i=0; i<globalValue.length; i++){
      data=data+globalValue[i].price[i];
    }
  }
  final dataMap = <String, double>{
    "Total sales":globalValue[0].price[0],
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };
  final colorList = <Color>[
    const Color(0xfffdcb6e),
    const Color(0xff0984e3),
    const Color(0xfffd79a8),
    const Color(0xffe17055),
    const Color(0xff6c5ce7),
  ];
  @override
  Widget build(BuildContext context) {
    StreamBuilder<List<Catalogmodel>>(
        stream: readUser(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Text('something is wrong${snapshot.error}');
          }
          else if(snapshot.hasData){
            final users=snapshot.data!;
            globalValue=snapshot.data!;
            return Text('');
          }
          else return Center(child: CircularProgressIndicator(),);
        }
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Finance'),
      ),
      body: Column(
        children: [
          PieChart(
            dataMap: dataMap,
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(context).size.width / 3.2,
            colorList: colorList,
            initialAngleInDegree: 0,
            chartType: ChartType.ring,
            ringStrokeWidth: 32,
            centerText: "HYBRID",
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              showLegends: true,
              legendShape: BoxShape.circle,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: false,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
            // gradientList: ---To add gradient colors---
            // emptyColorGradient: ---Empty Color gradient---
          ),
          ElevatedButton(
              onPressed: (){
                print(data);
              }, child: Text('Click')),
        ],
      ),
    );
  }
  Stream<List<Catalogmodel>> readUser()=>FirebaseFirestore.instance.collection('orders')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc)=>Catalogmodel.fromJson(doc.data())).toList());
}

