import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/facility_list/resources/facility_list_response.dart';
import 'package:flutter_trc/src/common/facility_list/screens/facility_list_screen.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

class CurrentFacilityWidget extends StatefulWidget {
  final String apiUrl;
  final TRCServiceGroups serviceGroup;
  final FacilityListData? Function() getFacility;
  final Future<void> Function(FacilityListData facility) setFacility;
  final bool showForce;

  const CurrentFacilityWidget({
    super.key,
    required this.getFacility,
    required this.setFacility,
    this.apiUrl = '/facility/list',
    this.serviceGroup = TRCServiceGroups.rms,
    this.showForce = false,
  });

  @override
  State<CurrentFacilityWidget> createState() => CurrentFacilityWidgetState();
}

class CurrentFacilityWidgetState extends State<CurrentFacilityWidget> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    FacilityListData? facility = widget.getFacility();
    if (facility == null && widget.showForce == false) {
      return const SizedBox.shrink();
    }
    return CshCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CshTextNew.subTitle2("Current Facility:"),
                CshTextNew.overLine(facility?.name ?? "NA"),
              ],
            ),
          ),
          CshMediumOutlineButton(
              text: Validator.isNullOrEmpty(facility?.name) ? "Select Facility" : "Change",
              onPressed: () {
                CommonFacilityListScreen.openFacilityScreen(
                  context,
                  apiUrl: widget.apiUrl,
                  serviceGroup: widget.serviceGroup,
                  onFacilitySelected: (facility) {
                    Navigator.pop(context);
                    widget.setFacility(facility).then((_) => setState(() {}));
                  },
                );
              }),
        ],
      ),
    );
  }
}
