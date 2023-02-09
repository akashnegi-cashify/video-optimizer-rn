
import '../../models/delivery_response.dart';

abstract class DeliveryDeliverInteractor {
  Stream<DeliveryResponse?> getEngineersList(bool isUrgent);
}
