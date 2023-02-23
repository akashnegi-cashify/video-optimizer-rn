import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common_models/elss_device_details_response.dart';
import '../l10n.dart';
import '../providers/channel_option_provider.dart';
import '../widgets/channel_option_widget.dart';

class AllowedOptionScreeArguments {
  final String scannedBarcode;
  final ElssDeviceDetailsResponse? detailsDataModel;

  AllowedOptionScreeArguments(this.scannedBarcode, {this.detailsDataModel});
}

class AllowedOptionScreen extends StatefulWidget {
  static const String route = "/allowed_options_screen.dart";

  const AllowedOptionScreen({Key? key}) : super(key: key);

  @override
  State<AllowedOptionScreen> createState() => _AllowedOptionScreenState();
}

class _AllowedOptionScreenState extends State<AllowedOptionScreen> {
  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var args = ModalRoute.of(context)?.settings.arguments as AllowedOptionScreeArguments;
    var theme = Theme.of(context);
    return ChangeNotifierProvider<ChannelOptionProvider>(
      create: (_) => ChannelOptionProvider(args.scannedBarcode),
      lazy: false,
      builder: (BuildContext innerContext, __) {
        var provider = ChannelOptionProvider.of(innerContext);
        return Scaffold(
          appBar: CshHeader(
            l10n.channelOptions,
            showBackBtn: true,
          ),
          body: (provider.isOptionDataLoading)
              ? const Center(
                  child: SizedBox(
                    height: Dimens.space_30,
                    width: Dimens.space_30,
                    child: CircularProgressIndicator(),
                  ),
                )
              : (provider.isOptionDataLoading == false && provider.channelOptionResponse == null)
                  ? Center(
                      child: Text(
                        (provider.errorOfChannel.isNotEmpty) ? provider.errorOfChannel : l10n.noDataFound,
                        style: theme.primaryTextTheme.headline3,
                      ),
                    )
                  : ChannelOptionWidget(
                      args.scannedBarcode,
                      detailsDataModel: args.detailsDataModel,
                    ),
        );
      },
    );
  }
}
