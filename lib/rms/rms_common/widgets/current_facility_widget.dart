import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/rms/modules/facility_list/resources/facility_list_response.dart';
import 'package:flutter_trc/rms/modules/facility_list/screens/facility_list_screen.dart';
import 'package:flutter_trc/src/libraries/shared_prefrences/app_prefrences.dart';

import '../l10n.dart';

class CurrentFacility extends StatefulWidget {
  const CurrentFacility({super.key});

  @override
  State<CurrentFacility> createState() => CurrentFacilityState();
}

class CurrentFacilityState extends State<CurrentFacility> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    FacilityListData? facility = AppPreferences().getFacility();
    if (facility == null) {
      return const SizedBox.shrink();
    }
    var l10n = L10n(context);
    return CshCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CshTextNew.subTitle2("${l10n.currentFacility}:"),
                CshTextNew.overLine(facility.name ?? ""),
              ],
            ),
          ),
          CshMediumOutlineButton(
              text: l10n.change,
              onPressed: () {
                FacilityListScreen.openFacilityScreen(context, onFacilitySelected: (facility) {
                  Navigator.pop(context); // Close the facility list screen
                  AppPreferences().setFacility(facility).then((_) => setState(() {}));
                });
              }),
        ],
      ),
    );
  }
}
