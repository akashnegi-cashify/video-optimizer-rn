import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/store_out/types.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../../../../src/app_builder/app_builder_groups/groups.dart';
import '../models/index.dart';
import '../widgets/index.dart';

part 'lot_items_scan_component.g.dart';

@CshComponent(
  key: LotItemsScanComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: ComponentGroup.StoreOutLotItemsScan,
  paramModel: LotItemsScanCompParam,
  params: LotItemsScanCompParamKeys.values,

)
class LotItemsScanComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_qc_lot_items_scan_component";

  const LotItemsScanComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return  paramBuilder((paramModel) {

      if(!LotType.isValid(paramModel.lotType)){
        return Center(child: CshTextNew.h3("Lot Type Must Not Be Null or Empty."));
      }

      if(paramModel.lotType == LotType.NORMAL_LOT.value){
        // Normal Lot requires lotId
        if(paramModel.lotId == null){
          return Center(child: CshTextNew.h3("Lot ID Must Not Be Null or Empty."));
        }
        return NormalLotScanContainer(lotId: paramModel.lotId!, lotType: paramModel.lotType!, lotName: paramModel.lotName);
      }
      else if(paramModel.lotType == LotType.BIN_LOT.value){
        // Bin Lot requires lotName (lotId can be null - uses lotName as identifier)
        if(isEmpty(paramModel.lotName)){
          return Center(child: CshTextNew.h3("Lot Name Must Not Be Null or Empty."));
        }
        return BinLotScanContainer(lotId: paramModel.lotId ?? 0, lotType: paramModel.lotType!, lotName: paramModel.lotName);
      }
      else {
        return Container();
      }


    } );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
