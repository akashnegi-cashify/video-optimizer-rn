import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/models/pending_dispatch_detail_param_model.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/providers/pending_dispatch_detail_provider.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/utils/media_upload/providers/image_upload_provider.dart';
import 'package:flutter_trc/src/utils/media_upload/widgets/general_image_upload_card.dart';
import 'package:provider/provider.dart';

part 'pending_dispatch_detail_component.g.dart';

@CshComponent(
  key: PendingDispatchDetailComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: QcComponentGroup.qcStockTransferPendingDispatchDetailComponentKey,
  params: PendingDispatchDetailParamModelKeys.values,
  paramModel: PendingDispatchDetailParamModel,
)
class PendingDispatchDetailComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_pending_dispatch_detail_component";

  const PendingDispatchDetailComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((model) {
      return ChangeNotifierProvider(
        create: (_) => PendingDispatchDetailProvider(model.scannedInvoiceNo, model.lotName),
        child: _PendingDispatchWidget(),
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}

class _PendingDispatchWidget extends StatefulWidget {
  _PendingDispatchWidget({super.key});

  @override
  State<_PendingDispatchWidget> createState() => _PendingDispatchWidgetState();
}

class _PendingDispatchWidgetState extends State<_PendingDispatchWidget> {
  final TextEditingController _controller = TextEditingController();

  String? _awbNo;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PendingDispatchDetailProvider>(context);
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(Dimens.space_16),
        child: Column(
          children: [
            CshTextNew.h3("Lot Name - ${provider.lotName}"),
            const SizedBox(height: Dimens.space_16),
            CshTextNew.h4("Invoice No - ${provider.scannedInvoiceNo}"),
            const SizedBox(height: Dimens.space_32),
            ChangeNotifierProvider(
              create: (_) => ImageUploadProvider(),
              child: GeneralImageUploadCard(
                cardHeight: MediaQuery.of(context).size.height * 0.4,
                cardWidth: MediaQuery.of(context).size.width * 0.8,
                imageUrl: provider.invoiceUrl,
                onMediaUploaded: (url) {
                  provider.invoiceUrl = url;
                },
              ),
            ),
            const SizedBox(height: Dimens.space_16),
            CshTextFormField(
                controller: _controller,
                hintText: "Awb Number",
                suffixIcon: InkWell(
                  child: const Icon(Icons.qr_code_2),
                  onTap: () {
                    CshMlScannerUtil().openScanner(context, onScanned: (scannedData, controller) {
                      Navigator.pop(context); // dismiss scanner screen
                      setState(() {
                        _controller.text = scannedData;
                      });
                    });
                  },
                ),
                onChanged: (value) {
                  setState(() {
                    _awbNo = value;
                  });
                }),
            const SizedBox(height: Dimens.space_16),
            CshBigButton(
              text: "Scan Invoice",
              onPressed: () {
                CshMlScannerUtil().openScanner(
                  context,
                  onScanned: (scannedData, controller) {
                    Navigator.pop(context); // dismiss scanner screen
                    provider.onNewInvoiceScanned(scannedData);
                  },
                );
              },
            ),
            const SizedBox(height: Dimens.space_16),
            CshBigButton(
              text: "Complete Dispatch",
              onPressed: provider.isAllDataFilled(_awbNo)
                  ? () {
                      CshLoading().showLoading(context);
                      provider.completeDispatch(_awbNo).then((value) {
                        CshLoading().hideLoading(context);
                        Navigator.pop(context, true);
                      }, onError: (error) {
                        CshLoading().hideLoading(context);
                        CshSnackBar.error(context: context, message: error);
                      });
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
