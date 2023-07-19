import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'calculation_screen.g.dart';

@CshPage(key: CalculationScreen.pageKey, pageGroup: PageGroup.calculatorPageKey)
class CalculationScreen extends BaseScreen {
  static const String pageKey = "calculation_screen";
  static const String route = "/calculator-screen";

  const CalculationScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}

// class CalculationScreen extends StatefulWidget {
//   const CalculationScreen({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<CalculationScreen> createState() => CalculationScreenState();
// }
//
// class CalculationScreenState extends State<CalculationScreen> with WidgetsBindingObserver {
//   bool _isMethodChannelDataLoading = true;
//   late MethodChannel platform;
//   MyCalculatorResponse? _calculatorResponse;
//
//   @override
//   void initState() {
//     WidgetsBinding.instance.addObserver(this);
//     super.initState();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.detached) {
//       _isMethodChannelDataLoading = true;
//       setState(() {});
//     }
//     if (state == AppLifecycleState.resumed) {
//       platform = const MethodChannel('com.cashify.calculator/result');
//
//       platform.invokeMethod('getCalculatorRequest').then(
//         (value) {
//           if (value != null) {
//             _calculatorResponse = MyCalculatorResponse.fromJson(jsonDecode(value));
//             _isMethodChannelDataLoading = false;
//             setState(() {});
//           }
//         },
//       );
//     }
//   }
//
//   //Method channel callback;
//   void _sendDataToNative(MyQuoteRequestData requestData, String? partialQuoteId, String? udid) {
//     var json = jsonEncode(requestData.toJson());
//     platform.invokeMethod<bool>('getCalculatorData', json).then((value) {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _isMethodChannelDataLoading
//         ? const Scaffold(
//             body: Center(
//               child: SizedBox(
//                 height: Dimens.space_30,
//                 width: Dimens.space_30,
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//           )

//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//
//     WidgetsBinding.instance.removeObserver(this);
//   }
//
//   void _showDisputedQuestions(List<ManualAuditQuestionItem>? manualAuditQuestions, QuoteRequestData requestData,
//       String? partialQuoteId, String? udid) {
//     Navigator.pushNamed(context, DisputedQuestionScreen.route,
//             arguments: DisputedQuestionScreenArg(manualAuditQuestions))
//         .then(
//       (value) {
//         if (value != null) {
//           if (value is List<int>) {
//             MyQuoteRequestData myQuoteRequestData =
//                 MyQuoteRequestData(manualAuditQuestion: value, requestData: requestData);
//             _sendDataToNative(myQuoteRequestData, partialQuoteId, udid);
//           }
//         } /*else {
//           var myQuoteRequestData = MyQuoteRequestData(requestData: requestData);
//           _sendDataToNative(myQuoteRequestData, partialQuoteId, udid);
//         }*/
//       },
//     );
//   }
// }
