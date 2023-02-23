import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/rider/l10n.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/models/delivery_response.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/receive/providers/pickup_receive_engineer_parts_presenter.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/receive/resources/pickup_receive_api_service.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/receive/widgets/pickup_receive_barcode_scanner_widget.dart';
import '../../../engineer_card_widget.dart';
import '../../../pending_delivery/deliver/models/engineer_parts_response.dart';
import '../../../pending_delivery/receive/models/receive_response_model.dart';

class PickupReceiveEngineerPartsScreen extends StatelessWidget {
  const PickupReceiveEngineerPartsScreen({Key? key}) : super(key: key);
  static const route = "/rider/return/pending/parts";

  @override
  Widget build(BuildContext context) {
    return const _PickupReceiveEngineerPartsWidget();
  }
}

class _PickupReceiveEngineerPartsWidget extends StatefulWidget {
  const _PickupReceiveEngineerPartsWidget({Key? key}) : super(key: key);

  @override
  State<_PickupReceiveEngineerPartsWidget> createState() => _PickupReceiveEngineerPartsWidgetState();
}

class _PickupReceiveEngineerPartsWidgetState extends State<_PickupReceiveEngineerPartsWidget> {
  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);

    EngineerDetail? detail = ModalRoute.of(context)?.settings.arguments as EngineerDetail?;

    assert(detail != null, "Couldn't retrieve Engineer Detail");

    return Scaffold(
      appBar: CshHeader(l10n.engineerParts),
      body: Column(
        children: [
          EngineerCardWidget(detail: detail!),
          Expanded(
              child: _PartListWidget(
            engineerId: detail.id,
            onPartReceive: () {
              CshSnackBar.success(context: context, message: l10n.partReceivedSuccessfully);
              // To refresh list
              setState(() {});
            },
          ))
        ],
      ),
    );
  }
}

class _PartListWidget extends StatelessWidget {
  final int engineerId;

  final Function onPartReceive;

  const _PartListWidget({super.key, required this.engineerId, required this.onPartReceive});

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);

    PickupReceiveEngineerPartsPresenter presenter = PickupReceiveEngineerPartsPresenter();

    return StreamBuilder<EngineerPartsResponse?>(
      builder: (context, snapshot) {
        List<Part>? parts = snapshot.data?.parts;
        if (parts != null) {
          return CshList(
            rowCount: parts.length,
            getRowWidget: (index) {
              return CshCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CshTextNew(parts[index].partName),
                        CshTextNew(parts[index].partBarcode),
                        CshTextNew(parts[index].partSku),
                      ],
                    ),
                    CshMediumButton(
                        text: l10n.receive,
                        onPressed: () {
                          Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                            return PickupReceiveBarcodeScannerWidget(
                              onPartReceive: (String result) {
                                Navigator.pop(context);
                                CshLoading().showLoading(context);
                                presenter.receivePart(parts[index].partId, result).listen((event) {
                                  CshLoading().hideLoading(context);
                                  onPartReceive();
                                }).onError((error) {
                                  CshLoading().hideLoading(context);
                                  String errMessage = ApiErrorHelper.getErrorMessage(error) ?? l10n.somethingWentWrong;
                                  CshSnackBar.error(context: context, message: errMessage);
                                });
                              },
                              part: parts[index],
                            );
                          }));
                        })
                  ],
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
      stream: PickupReceiveAPIService.getEngineerParts(engineerId),
    );
  }
}
