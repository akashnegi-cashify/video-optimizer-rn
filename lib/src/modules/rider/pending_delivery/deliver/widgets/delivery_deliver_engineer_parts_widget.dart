import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/modules/rider/l10n.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/models/delivery_response.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/models/engineer_parts_response.dart';
import '../../../../../common/widgets/key_value_row_widget.dart';
import '../../receive/models/receive_response_model.dart';
import '../resources/delivery_deliver_api_service.dart';
import 'item_delivery_deliver_widget.dart';

class DeliveryDeliverEngineerPartsScreen extends StatelessWidget {
  const DeliveryDeliverEngineerPartsScreen({Key? key}) : super(key: key);
  static const route = "/rider/delivery/pending/received/parts";

  @override
  Widget build(BuildContext context) {
    return const _DeliveryDeliverEngineerPartsWidget();
  }
}

class _DeliveryDeliverEngineerPartsWidget extends StatelessWidget {
  const _DeliveryDeliverEngineerPartsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EngineerDetail? detail = ModalRoute.of(context)?.settings.arguments as EngineerDetail?;

    L10n l10n = L10n(context);

    assert(detail != null, "Engineer detail couldn't be retrieved");

    return Scaffold(
      appBar: TrcHeader(l10n.engineerParts),
      body: SafeArea(
        child: Column(
          children: [
            ItemDeliveryDeliverWidget(item: detail!),
            Expanded(
                child: _PartListWidget(
              engineerId: detail.id,
            ))
          ],
        ),
      ),
    );
  }
}

class _PartListWidget extends StatelessWidget {
  final int engineerId;

  const _PartListWidget({Key? key, required this.engineerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return StreamBuilder<EngineerPartsResponse?>(
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          CshSnackBar.error(
              context: context, message: ApiErrorHelper.getErrorMessage(snapshot.error) ?? l10n.somethingWentWrong);
        }
        List<Part>? partsList = snapshot.data?.parts;
        if (partsList != null) {
          return CshList(
            rowCount: partsList.length,
            getRowWidget: (index) {
              return _ItemDeliveryDeliverEngineerPart(
                part: partsList[index],
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
      stream: DeliveryDeliverAPIService.getEngineerParts(engineerId),
    );
  }
}

class _ItemDeliveryDeliverEngineerPart extends StatelessWidget {
  final Part part;

  const _ItemDeliveryDeliverEngineerPart({Key? key, required this.part}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return CshCard(
      child: Column(
        children: [
          KeyValueRowWidget(title: l10n.partName, value: part.partName),
          KeyValueRowWidget(title: l10n.partBarcode, value: part.partBarcode),
          KeyValueRowWidget(title: l10n.partSku, value: part.partSku),
          KeyValueRowWidget(title: l10n.deviceBarcode, value: part.deviceBarcode),
          KeyValueRowWidget(title: l10n.deviceName, value: part.deviceName),
        ],
      ),
    );
  }
}
