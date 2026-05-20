import 'package:flutter_trc/src/modules/laptop_assembly/resources/assembly_mark_done_response.dart';
import 'package:flutter_trc/src/modules/laptop_assembly/resources/assembly_parts_response.dart';
import 'package:flutter_trc/src/services/trc_service.dart';

class LaptopAssemblyService {
  static Stream<AssemblyPartsResponse?> getChildParts(String deviceBarcode) {
    Map<String, List<String>> params = {
      "dbr": [deviceBarcode],
    };
    return TrcService().get(
      "/laptop/assembly/device/parts",
      AssemblyPartsResponse.fromJson,
      params: params,
    );
  }

  static Stream<AssemblyMarkDoneResponse?> markDone(String deviceBarcode) {
    Map<String, List<String>> params = {
      "dbr": [deviceBarcode],
    };
    return TrcService().post(
      "/laptop/assembly/device/mark-done",
      AssemblyMarkDoneResponse.fromJson,
      params: params,
    );
  }
}
