import 'package:flutter/material.dart';

class CollectActivityProvider extends ChangeNotifier {
  String plotId;

  CollectActivityProvider({required this.plotId});

  void setPlotId(String newPlotId) {
    plotId = newPlotId;
    notifyListeners();
  }
}
