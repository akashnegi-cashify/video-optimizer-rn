import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/validate_awb_response.dart';

class StockInProvider extends CshChangeNotifier {
  final ValidateAwbResponse? stockInProductDetail;

  StockInProvider(this.stockInProductDetail);

  static StockInProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<StockInProvider>(context, listen: listen);
  }

  void updateItemSelectionStatus(int grpIndex, int itemIndex) {
    var item = stockInProductDetail?.groups?[grpIndex]?.items?[itemIndex];
    if(item == null) return;
    item.isChecked = item.isChecked !=null  ? !item.isChecked! : false ;
    notifyListeners();
  }

  bool getItemSelectionStatus(int grpIndex, int itemIndex){
    var item = stockInProductDetail?.groups?[grpIndex]?.items?[itemIndex];
    if(item == null) return false;
    return item.isChecked ?? false;
  }
}
