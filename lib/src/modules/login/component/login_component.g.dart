// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

LoginCompParam fromMap(Map<String, dynamic> map) {
  LoginCompParam model = LoginCompParam(
    isLoginFromQC: map["qcl"],
  );
  return model;
}

Widget paramBuilder(Widget Function(LoginCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "qcl": provider.data["qcl"],
    },
    builder: (context, data, child) {
      LoginCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(LoginCompParam model) {
  var isLoginFromQC = model.isLoginFromQC;

  return isLoginFromQC != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_login_comp",
      "componentType": "Login",
      "isActive": true,
      "title": "Login Component",
      "cpm": [
        {"key": "qcl", "value": null}
      ],
      "configJson": {
        "config": [
          {
            "type": "String",
            "isRequired": false,
            "label": "none",
            "key": "none"
          }
        ]
      }
      //#admincomponent
    };
