// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disputed_question_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

DisputedQuestionParam fromMap(Map<String, dynamic> map) {
  DisputedQuestionParam model = DisputedQuestionParam(
    disputedQuestionList: map["dql"],
  );
  return model;
}

Widget paramBuilder(Widget Function(DisputedQuestionParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "dql": provider.data["dql"],
    },
    builder: (context, data, child) {
      DisputedQuestionParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(DisputedQuestionParam model) {
  var disputedQuestionList = model.disputedQuestionList;

  return disputedQuestionList != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "disputed_questions",
      "componentType": "Disputed Questions",
      "isActive": true,
      "title": "Disputed Questions Component",
      "cpm": [
        {"key": "dql", "value": null}
      ],
      "configJson": {
        "type": "list",
        "config": [
          {
            "uiType": "input",
            "type": "String",
            "isRequired": false,
            "label": "None",
            "key": "none"
          }
        ]
      }
      //#admincomponent
    };
