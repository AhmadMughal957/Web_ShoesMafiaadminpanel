import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'caatalogmodel.dart';
class Cart with ChangeNotifier {
  List<Catalogmodel> items=[];
  double price=0.0;
   List total=[];

  void add(Catalogmodel item){
    items.add(item);
    price=price+0;
    notifyListeners();
  }
  int get count {
    return items.length;

  }
  void remove(Catalogmodel item){
    price=price-0;
    items.remove(item);
    notifyListeners();
  }

}