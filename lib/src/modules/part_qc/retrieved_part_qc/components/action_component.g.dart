// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

ActionItemParams fromMap(Map<String, dynamic> map) {
  ActionItemParams model = ActionItemParams(
    barcode: map["bc"],
  );
  return model;
}

Widget paramBuilder(Widget Function(ActionItemParams model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "bc": provider.data["bc"],
    },
    builder: (context, data, child) {
      ActionItemParams model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(ActionItemParams model) {
  var barcode = model.barcode;

  return barcode != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_action_component",
      "componentType": "Action",
      "isActive": true,
      "title": "Action Component",
      "cpm": [
        {"key": "bc", "value": null}
      ], //#admincomponent
    };
