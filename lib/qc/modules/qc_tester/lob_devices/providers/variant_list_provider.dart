import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/calculator_service.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';
import 'package:flutter_trc/src/common/searchable.dart';
import 'package:provider/provider.dart';

class VariantListProvider extends CalculatorServiceInitProvider with Searchable {
  static VariantListProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<VariantListProvider>(context, listen: listen);
  }

  final int productId;
  final String seriesName;

  VariantListProvider(this.productId, this.seriesName);
}
