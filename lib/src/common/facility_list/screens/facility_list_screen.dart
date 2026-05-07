import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/facility_list/resources/facility_list_response.dart';
import 'package:flutter_trc/src/common/facility_list/widgets/facility_list_widget.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

class CommonFacilityListScreen extends StatelessWidget {
  final Function(FacilityListData facility) onFacilitySelected;
  final String apiUrl;
  final TRCServiceGroups serviceGroup;

  const CommonFacilityListScreen({
    super.key,
    required this.onFacilitySelected,
    this.apiUrl = '/facility/list',
    this.serviceGroup = TRCServiceGroups.rms,
  });

  static void openFacilityScreen(
    BuildContext context, {
    required Function(FacilityListData facility) onFacilitySelected,
    String apiUrl = '/facility/list',
    TRCServiceGroups serviceGroup = TRCServiceGroups.rms,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CommonFacilityListScreen(
          onFacilitySelected: onFacilitySelected,
          apiUrl: apiUrl,
          serviceGroup: serviceGroup,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrcHeader("Select Facility"),
      body: FacilityListWidget(
        onFacilitySelected,
        apiUrl: apiUrl,
        serviceGroup: serviceGroup,
      ),
    );
  }
}
