import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/resources/domain/delivery_deliver_interactor.dart';

import '../../models/delivery_response.dart';
import '../delivery_deliver_api_service.dart';

class DeliveryDeliverInteractorImpl extends DeliveryDeliverInteractor {
  @override
  Stream<DeliveryResponse?> getEngineersList(bool isUrgent) => DeliveryDeliverAPIService.getData(isUrgent);
}
