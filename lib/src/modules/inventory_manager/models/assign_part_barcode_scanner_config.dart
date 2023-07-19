import 'package:csh_annotation/annotation.dart';

part 'assign_part_barcode_scanner_config.g.dart';

@ConfigModel()
class AssignPartBarcodeScannerConfig {
  @ConfigKey(name: "none")
  String? none;

  AssignPartBarcodeScannerConfig({this.none});

  static AssignPartBarcodeScannerConfig fromConfig(Map<String, dynamic> data) =>
      _$AssignPartBarcodeScannerConfigFromConfig(data);
}
