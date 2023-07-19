import 'package:builder_project/builder_project.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../models/assigned_device_details.dart';
import '../models/assigned_part_details_comp_param.dart';
import '../providers/assinged_part_details_provider.dart';
import '../widgets/assiged_device_details_widget.dart';
import '../widgets/assigned_part_details_widget.dart';

part 'assigned_part_details_screen.g.dart';

class AssignedPartDetailsArguments {
  final AssignDeviceDetailsData? assignDeviceDetailsData;
  final int prid;

  AssignedPartDetailsArguments({this.assignDeviceDetailsData, required this.prid});
}

@CshPage(
  key: AssignedPartDetailsScreen.pageKey,
  pageGroup: PageGroup.assignedPartDetailsPageKey,
  params: AssignedPartDetailsCompParamKeys.values,
)
class AssignedPartDetailsCompArguments extends BaseArguments {
  final AssignedPartDetailsArguments? args;

  AssignedPartDetailsCompArguments({this.args}) : super(AssignedPartDetailsScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[AssignedPartDetailsCompParamKeys.arguments.value] = args;
    return data;
  }
}

class AssignedPartDetailsScreen extends BaseScreen<AssignedPartDetailsCompArguments> {
  static const String pageKey = "TRC_assigned_part_details_screen";
  static const String route = "/assigned_part_details_screen";

  const AssignedPartDetailsScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}

class AssignedPartDetailsCompWidget extends StatefulWidget {
  final AssignedPartDetailsArguments? arguments;

  const AssignedPartDetailsCompWidget({
    Key? key,
    this.arguments,
  }) : super(key: key);

  @override
  State<AssignedPartDetailsCompWidget> createState() => _AssignedPartDetailsCompWidgetState();
}

class _AssignedPartDetailsCompWidgetState extends State<AssignedPartDetailsCompWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);

    return ChangeNotifierProvider<AssignedPartDetailsProvider>(
      create: (_) => AssignedPartDetailsProvider(widget.arguments?.prid),
      lazy: false,
      builder: (BuildContext innerContext, __) {
        var provider = AssignedPartDetailsProvider.of(innerContext);
        if (provider.isDataLoading) {
          return const Scaffold(
            body: Center(
              child: SizedBox(
                height: Dimens.space_30,
                width: Dimens.space_30,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (provider.isDataLoading == false && !Validator.isNullOrEmpty(provider.errorMessage)) {
          return Scaffold(
            appBar: CshHeader(
              l10n.assignPartsDetailsScreen,
              showBackBtn: true,
            ),
            body: Center(
              child: Row(
                children: [
                  const SizedBox.shrink(),
                  Expanded(
                    child: Text(
                      provider.errorMessage,
                      style: theme.primaryTextTheme.headline4,
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: CshHeader(
              l10n.assignPartsDetailsScreen,
              showBackBtn: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
              child: Column(
                children: [
                  AssignedDeviceDetailsWidget(
                    dataModel: widget.arguments?.assignDeviceDetailsData,
                    isLoading: false,
                    errorMessage: "",
                  ),
                  const SizedBox(height: Dimens.space_8),
                  AssignedPartDetailsWidget(
                      prid: widget.arguments?.prid ?? 0, detailsData: provider.assignedPartsDetails),
                  const Expanded(
                    child: SizedBox.shrink(),
                  ),
                  ComboButton(
                    firstBtnText: l10n.cancel,
                    secondBtnText: l10n.goBack,
                    isFirstPrimary: true,
                    buttonType: ButtonType.mini,
                    firstBtnClick: (!Validator.isNullOrEmpty(provider.assignedPartsDetails?.data?.status) &&
                            provider.assignedPartsDetails!.data!.status == "Cancelled")
                        ? null
                        : () {
                            _showCancelModal(innerContext, theme, l10n, widget.arguments?.prid ?? 0);
                          },
                    secondBtnClick: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }

  _showCancelModal(BuildContext context, ThemeData theme, L10n l10n, int prid) {
    showCshBottomSheet(
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
        child: Column(
          children: [
            Text(
              l10n.areYouSureYouWantToCancel,
              style: theme.primaryTextTheme.headline3,
            ),
            const SizedBox(height: Dimens.space_16),
            ComboButton(
              firstBtnText: l10n.no,
              secondBtnText: l10n.yes,
              buttonType: ButtonType.mini,
              isFirstPrimary: true,
              firstBtnClick: () {
                Navigator.of(context).pop();
              },
              secondBtnClick: () {
                Navigator.of(context).pop();
                _cancelAssignedPart(context, l10n);
              },
            )
          ],
        ),
      ),
    );
  }

  _cancelAssignedPart(BuildContext context, L10n l10n) {
    var provider = AssignedPartDetailsProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.cancelAssignedPart().then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        CshSnackBar.success(context: context, message: l10n.partCanceledSuccessfully);
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
