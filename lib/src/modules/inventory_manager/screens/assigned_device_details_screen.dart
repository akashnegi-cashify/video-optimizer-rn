import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n.dart';
import '../providers/assigned_device_details_provider.dart';
import '../widgets/assiged_device_details_widget.dart';
import '../widgets/assinged_device_alloted_parts_list_widget.dart';

class AssignedDeviceDetailsArguments {
  final int did;

  AssignedDeviceDetailsArguments({
    required this.did,
  });
}

class AssignedDeviceDetailsScreen extends StatefulWidget {
  static const String route = "/assigned_Device_details_screen";

  const AssignedDeviceDetailsScreen({Key? key}) : super(key: key);

  @override
  State<AssignedDeviceDetailsScreen> createState() => _AssignedDeviceDetailsScreenState();
}

class _AssignedDeviceDetailsScreenState extends State<AssignedDeviceDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as AssignedDeviceDetailsArguments;
    var l10n = L10n(context);
    return ChangeNotifierProvider<AssignedDeviceDetailsProvider>(
      create: (_) => AssignedDeviceDetailsProvider(args.did),
      lazy: false,
      builder: (BuildContext innerContext, __) {
        var provider = AssignedDeviceDetailsProvider.of(innerContext);
        return Scaffold(
          appBar: CshHeader(
            l10n.assignedDeviceDetails,
            showBackBtn: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
            child: Column(
              children: [
                AssignedDeviceDetailsWidget(
                  dataModel: provider.assignedDeviceDetails?.detailsData,
                  isLoading: provider.isDataLoading,
                  errorMessage: provider.errMessage,
                ),
                const SizedBox(height: Dimens.space_8),
                Expanded(
                  child: AssignedDeviceAllottedPartsList(
                    dataModel: provider.deviceAllottedPartsResponse,
                    isLoading: provider.isListDataLoading,
                    errorMessage: provider.listErrorMessage,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
