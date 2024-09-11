import 'package:flutter/material.dart';

class FontSize with ChangeNotifier{
  double _size = 15;
  double get size => _size;

  void increment() {
    _size ++;
    notifyListeners();
  }

  void decrement(){
    _size --;
    notifyListeners();
  }

}