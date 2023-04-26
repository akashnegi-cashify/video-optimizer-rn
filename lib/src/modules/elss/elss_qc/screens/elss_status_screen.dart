import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/modules/elss/common_screen/elss_home_screen.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/providers/elss_status_provider.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/resources/elss_status.dart';
import 'package:provider/provider.dart';
import '../l10n.dart';
import '../widgets/elss_device_details_widget.dart';

class ElssStatusScreenArg {
  ElssStatus elssStatus;
  final String barcode;

  ElssStatusScreenArg({
    required this.elssStatus,
    required this.barcode,
  });
}

class ElssStatusScreen extends StatelessWidget {
  static String routeName = "/elss-status";

  const ElssStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ElssStatusScreenArg? arg = ModalRoute.of(context)!.settings.arguments as ElssStatusScreenArg?;
    assert(arg != null);
    var l10n = L10n(context);
    ThemeData theme = Theme.of(context);

    return ChangeNotifierProvider<ElssStatusProvider>(
      create: (_) => ElssStatusProvider(arg!.barcode),
      lazy: false,
      builder: (BuildContext innerContext, __) {
        var provider = ElssStatusProvider.of(innerContext);
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
        } else if (provider.isDataLoading == false && !Validator.isNullOrEmpty(provider.errMessage)) {
          return Scaffold(
            appBar: TrcHeader(l10n.elssStatus),
            body: Center(
              child: Row(
                children: [
                  const SizedBox.shrink(),
                  Expanded(
                    child: Text(
                      provider.errMessage!,
                      style: theme.primaryTextTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return _body(innerContext, theme, l10n, arg!);
        }
      },
    );
  }

  _body(BuildContext context, ThemeData theme, L10n l10n, ElssStatusScreenArg arg) {
    var provider = ElssStatusProvider.of(context);
    var statusData = _getStatusData(arg.elssStatus, l10n);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.elssStatus, style: theme.primaryTextTheme.headline3),
        automaticallyImplyLeading: false,
        backgroundColor: theme.backgroundColor,
        elevation: 0.0,
        shadowColor: theme.backgroundColor,
      ),
      body: CshCard(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CshCard(
                      radius: CshRadius.rad8,
                      elevation: CardElevation.dimen_10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(statusData.imagePath, height: 100, width: 100),
                          const SizedBox(height: Dimens.space_24),
                          Row(
                            children: [
                              const SizedBox.shrink(),
                              Expanded(
                                child: Text(
                                  statusData.description,
                                  textAlign: TextAlign.center,
                                  style: theme.primaryTextTheme.headline2,
                                  maxLines: 2,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: Dimens.space_20),
                    if (Validator.isNullOrEmpty(provider.errMessage))
                      ElssDeviceDetailsWidget(dataModel: provider.deviceDetails),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: Dimens.space_16,
            ),
            SizedBox(
              width: double.infinity,
              child: CshBigButton(
                text: l10n.home,
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, ElssHomeScreen.route, (route) => false, arguments: true);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _ElssStatusData _getStatusData(ElssStatus status, L10n l10n) {
    switch (status) {
      case ElssStatus.submit:
        return _ElssStatusData("assets/images/ic_elss_accept.png", l10n.elssSubmitDescription);
      case ElssStatus.reject:
        return _ElssStatusData("assets/images/ic_elss_reject.png", l10n.rejectDescription);
      case ElssStatus.pna:
        return _ElssStatusData("assets/images/ic_pna.png", l10n.pnaDescription);
    }
  }
}

class _ElssStatusData {
  String imagePath;
  String description;

  _ElssStatusData(this.imagePath, this.description);
}
