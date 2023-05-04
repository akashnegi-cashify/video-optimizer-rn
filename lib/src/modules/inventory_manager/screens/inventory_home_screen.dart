import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n.dart';
import '../providers/inventory_home_provider.dart';
import '../widgets/inventory_home_widget.dart';

class InventoryHomeScreen extends StatelessWidget {
  static const String route = '/inventory_home_screen';

  const InventoryHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);

    return ChangeNotifierProvider<InventoryHomeProvider>(
      create: (_) => InventoryHomeProvider(),
      lazy: false,
      builder: (BuildContext insideContext, __) {
        var provider = InventoryHomeProvider.of(insideContext);
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
              l10n.delivery,
              showBackBtn: true,
            ),
            body: Center(
              child: Row(
                children: [
                  const SizedBox.shrink(),
                  Expanded(
                    child: Text(
                      provider.errorMessage!,
                      style: theme.primaryTextTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return const InventoryHomeWidget();
        }
      },
    );
  }
}
