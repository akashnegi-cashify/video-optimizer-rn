import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/environments/environment_config.dart';
import '../l10n.dart';
import '../../../resources/user_details.dart';
import '../screens/inventory_home_screen.dart';
import '../screens/return_page.dart';
import '../screens/summary_screen.dart';

class InventoryDrawerWidget extends StatelessWidget {
  const InventoryDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Dimens.space_60,
              width: double.infinity,
              color: theme.primaryColor,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
              child: Row(
                children: [
                  Container(
                    height: Dimens.space_40,
                    width: Dimens.space_40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: theme.colorScheme.surface),
                    ),
                  ),
                  const SizedBox(width: Dimens.space_16),
                  if (!Validator.isNullOrEmpty(UserDetails().userDetailsData?.userName))
                    Expanded(
                      child: Text(
                        "Hi ${UserDetails().userDetailsData!.userName!}",
                        style: theme.primaryTextTheme.displaySmall?.copyWith(color: theme.colorScheme.surface),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                ],
              ),
            ),
            const SizedBox(height: Dimens.space_10),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text(l10n.delivery, style: theme.primaryTextTheme.headlineMedium),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(InventoryHomeScreen.route);
                    },
                  ),
                  Divider(color: theme.shadowColor),
                  ListTile(
                    title: Text(l10n.returns, style: theme.primaryTextTheme.headlineMedium),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(ReturnScreen.route);
                    },
                  ),
                  Divider(color: theme.shadowColor),
                  ListTile(
                    title: Text(l10n.summary, style: theme.primaryTextTheme.headlineMedium),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(SummaryScreen.route);
                    },
                  )
                ],
              ),
            ),
            Divider(color: theme.shadowColor),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${l10n.appVersion} -  ${environment?.appVersion}",
                  style: theme.primaryTextTheme.headlineSmall,
                ),
              ),
            ),
            const SizedBox(height: Dimens.space_30),
          ],
        ),
      ),
    );
  }
}
