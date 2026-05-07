import 'package:components/components.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

import '../resources/facility_list_response.dart';

class FacilityListWidget extends StatelessWidget {
  final Function(FacilityListData facility)? onFacilitySelected;
  final String apiUrl;
  final TRCServiceGroups serviceGroup;

  const FacilityListWidget(
    this.onFacilitySelected, {
    super.key,
    this.apiUrl = '/facility/list',
    this.serviceGroup = TRCServiceGroups.rms,
  });

  @override
  Widget build(BuildContext context) {
    return CshApiList<FacilityListData>(
        apiConfig: ListApiConfig(apiUrl: apiUrl, serviceGroup: serviceGroup),
        pageSize: 10,
        shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
        filterConfig: FilterConfig(filterData: [
          CshFilterData(
            label: "Search facility name",
            field: 'name',
            crudFilter: 'name',
            filterType: CshFilterType.input,
            valueType: CshFilterValueType.contains,
            position: FilterPosition.top,
            keyboardType: TextInputType.text,
            filterGroup: FilterGroupType.multipleTypeSearch,
          ),
        ]),
        getRowWidget: (data, index) {
          return GestureDetector(
            onTap: () {
              onFacilitySelected?.call(data!);
            },
            child: _Item(data?.name, data?.city, key: ValueKey(data?.facilityCode ?? "")),
          );
        },
        verticalRowSpacing: Dimens.space_16,
        itemFromJson: FacilityListData.fromJson);
  }
}

class _Item extends StatelessWidget {
  final String? name;
  final String? city;

  const _Item(this.name, this.city, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CshCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CshTextNew.subTitle2(name ?? ''),
            CshTextNew.subTitle2(city ?? ''),
          ],
        ),
      ),
    );
  }
}
