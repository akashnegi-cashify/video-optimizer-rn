// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

LoginCompParam fromMap(Map<String, dynamic> map) {
  LoginCompParam model = LoginCompParam(
    loginType: map["lt"],
  );
  return model;
}

Widget paramBuilder(Widget Function(LoginCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "lt": provider.data["lt"],
    },
    builder: (context, data, child) {
      LoginCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(LoginCompParam model) {
  var loginType = model.loginType;

  return loginType != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_login_comp",
      "componentType": "Login",
      "isActive": true,
      "title": "Login Component",
      "cpm": [
        {"key": "lt", "value": null}
      ],
      "configJson": {
        "type": "list",
        "config": [
          {
            "type": "String",
            "isRequired": false,
            "label": "None",
            "key": "none"
          }
        ]
      }
      //#admincomponent
    };
