import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/l10n.dart';
import 'package:flutter_trc/src/common/utils/time_utils.dart';

class DateRangePickerDropdownWidget extends StatelessWidget {
  final Function(String startDate, String endDate) onRangeSelected;

  final DateDropDownData data;

  const DateRangePickerDropdownWidget(this.onRangeSelected, {Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return CshDropDown(
      selectedItem: data.getDropDownItems(l10n)[data.selectedItemIndex],
      items: data.getDropDownItems(l10n),
      onChanged: (DropDownItem selectedItem) async {
        if (selectedItem.label == l10n.custom) {
          DateTimeRange? range = await showDateRangePicker(
              context: context, firstDate: DateTime(DateTime.now().year - 30), lastDate: DateTime.now());
          if (range != null) {
            onRangeSelected(
              range.start.formatToSimpleDate(),
              range.end.formatToSimpleDate(),
            );
          }
        } else {
          DateTimeRange range = selectedItem.extraData;
          onRangeSelected(
            range.start.formatToSimpleDate(),
            range.end.formatToSimpleDate(),
          );
        }
      },
    );
  }
}

class DateDropDownData {
  final int selectedItemIndex;

  DateDropDownData(this.selectedItemIndex);

  List<DropDownItem> getDropDownItems(L10n l10n) => [
        DropDownItem("0", l10n.yesterday,
            extraData: DateTimeRange(
              start: previousNthDayStart(1),
              end: previousNthDayEnd(1),
            )),
        DropDownItem("1", l10n.lastWeek,
            extraData: DateTimeRange(
              start: previousNthDayStart(7),
              end: previousNthDayEnd(1),
            )),
        DropDownItem("2", l10n.thisMonth,
            extraData: DateTimeRange(
              start: thisMonthStart(),
              end: DateTime.now(),
            )),
        DropDownItem("3", l10n.lastMonth,
            extraData: DateTimeRange(
              start: lastMonthStart(),
              end: lastMonthEnd(),
            )),
        DropDownItem("4", l10n.custom),
      ];
}
