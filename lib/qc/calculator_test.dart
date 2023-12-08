import 'package:calculator/calculator.dart';
import 'package:calculator_ui/calculator_ui.dart';
import 'package:flutter/material.dart';

import 'dummy_cal_response.dart';

class CalculatorTest extends StatefulWidget {
  static const String route = "/calculatorTest";
  static const title = 'Calculator';

  const CalculatorTest({Key? key}) : super(key: key);

  @override
  State<CalculatorTest> createState() => _CalculatorTestState();
}

class _CalculatorTestState extends State<CalculatorTest> {
  // CalculatorResponse data = calcResponse;
  CalculatorResponse data = CalculatorResponse.fromJson(mobileDummyResponse);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return CalculatorScreen(
      CalculatorScreenArgs(
        isCurrentDevice: 0,
        pickupMode: 'cashify',
        productInfo: ProductInfo(productLineName: "Laptop", productLineId: 19, brandId: 21),
        exppt: 'launch_calc',
        serviceId: '2',
        sourceId: '1',
        preSelection: data.userSelection,
        isQuickQuote: false,
        calculatorResponse: data,
        // mode: CalculatorMode.getCalculatorModeByString(data.selectionType),
        // calculatorResponse: mobileCal,
        showHint: false,
      ),
      deviceId: "d_id",
      showSummary: true,
      handleQuoteRequest: (QuoteRequestData requestData, String? partialQuoteId, String? udid) {
        // Navigator.popUntil(context, (route) => route.settings.name == "/calculatorTest");
        // Navigator.pop(context, requestData);
        print("mhydebug--------Quote Request Data: ${requestData.toJson()}");
      },
    );
    // return ChangeNotifierProvider<CalculatorTestProvider>(
    //   create: (_) => CalculatorTestProvider(),
    //   lazy: false,
    //   builder: (BuildContext innerContext, __) {
    //     var provider = CalculatorTestProvider.of(innerContext);
    //     if (provider.isLoadingData) {
    //       return const Scaffold(
    //         appBar: CshHeader("Device Details"),
    //         body: Center(
    //           child: SizedBox(
    //             height: Dimens.space_28,
    //             width: Dimens.space_28,
    //             child: CircularProgressIndicator(),
    //           ),
    //         ),
    //       );
    //     }
    //     if (provider.calculatorResponse != null) {
    //       return CalculatorScreen(
    //         CalculatorScreenArgs(
    //           true,
    //           isCurrentDevice: 0,
    //           pickupMode: 'cashify',
    //           productInfo: ProductInfo(productLineName: "Laptop", productLineId: 19, brandId: 21),
    //           exppt: 'launch_calc',
    //           serviceId: '2',
    //           sourceId: '1',
    //           preSelection: null,
    //           mode: CalculatorMode.defaultMode,
    //           calculatorResponse: provider.calculatorResponse!,
    //         ),
    //         deviceId: "d_id",
    //         handleQuoteRequest: (QuoteRequestData requestData, String? partialQuoteId, String? udid) {},
    //       );
    //     }
    //     return Scaffold(
    //       appBar: const CshHeader("Device Details"),
    //       body: Center(
    //         child: Text("No Data Found", style: theme.primaryTextTheme.headlineMedium),
    //       ),
    //     );
    //   },
    // );
  }
}
