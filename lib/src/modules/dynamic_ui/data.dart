var data = '''

{
    "id": 5,
    "key": "datawipeUserDashboard",
    "name": "Datawipe User Dashboard",
    "isActive": true,
    "widgetList": [
        {
            "id": 48,
            "key": "datawipeTotalEraserDevicesCount",
            "name": "Total Erasures",
            "priority": 1,
            "isHidden": false,
            "config": "",
            "configJson": {
                "colSpan": 10,
                "hideImage": false,
                "titleValueAlign": "vertical",
                "titleFontSize": 16,
                "textAlign": "start"
            },
            "ui": {
                "key": "card",
                "name": "Card",
                "colSpan": 3,
                "config": "{colSpan:10,hideImage:false,titleValueAlign:vertical,titleFontSize:16,textAlign:start}",
                "configJson": null,
                "jsonSchemaKey": "card_layout"
            },
            "templateFilterList": [
                {
                    "key": "datawipeOperator",
                    "name": "Datawipe Operator",
                    "type": "string",
                    "isMandatory": false,
                    "templateId": 86
                },
                {
                    "key": "endDate",
                    "name": "End Date",
                    "type": "date",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "loggedInCompany",
                    "name": "loggedInCompany",
                    "type": "string",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "operatingSystem",
                    "name": "operatingSystem",
                    "type": "string",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "startDate",
                    "name": "Start Date",
                    "type": "date",
                    "isMandatory": false,
                    "templateId": null
                }
            ]
        },
        {
            "id": 50,
            "key": "datawipeTotalSuccessfulDevicesCount",
            "name": "Successful Erasures",
            "priority": 2,
            "isHidden": false,
            "config": "",
            "configJson": {
                "colSpan": 10,
                "hideImage": false,
                "titleValueAlign": "vertical",
                "titleFontSize": 16,
                "textAlign": "start"
            },
            "ui": {
                "key": "card",
                "name": "Card",
                "colSpan": 3,
                "config": "{colSpan:10,hideImage:false,titleValueAlign:vertical,titleFontSize:16,textAlign:start}",
                "configJson": null,
                "jsonSchemaKey": "card_layout"
            },
            "templateFilterList": [
                {
                    "key": "datawipeOperator",
                    "name": "Datawipe Operator",
                    "type": "string",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "endDate",
                    "name": "End Date",
                    "type": "date",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "loggedInCompany",
                    "name": "Logged In Company",
                    "type": "string",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "operatingSystem",
                    "name": "operating system",
                    "type": "string",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "startDate",
                    "name": "Start Date",
                    "type": "date",
                    "isMandatory": false,
                    "templateId": null
                }
            ]
        },
        {
            "id": 52,
            "key": "dataWipeTotalFailedDevicesCount",
            "name": "Failed Erasures",
            "priority": 3,
            "isHidden": false,
            "config": "",
            "configJson": {
                "colSpan": 10,
                "hideImage": false,
                "titleValueAlign": "vertical",
                "titleFontSize": 16,
                "textAlign": "start"
            },
            "ui": {
                "key": "card",
                "name": "Card",
                "colSpan": 3,
                "config": "{colSpan:10,hideImage:false,titleValueAlign:vertical,titleFontSize:16,textAlign:start}",
                "configJson": null,
                "jsonSchemaKey": "card_layout"
            },
            "templateFilterList": [
                {
                    "key": "datawipeOperator",
                    "name": "Datawipe Operator",
                    "type": "string",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "endDate",
                    "name": "End Date",
                    "type": "date",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "loggedInCompany",
                    "name": "Logged In Company",
                    "type": "string",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "operatingSystem",
                    "name": "operating system",
                    "type": "string",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "startDate",
                    "name": "Start Date",
                    "type": "date",
                    "isMandatory": false,
                    "templateId": null
                }
            ]
        },
        {
            "id": 58,
            "key": "datawipeTotalErasuredData",
            "name": "Total Erased Data",
            "priority": 4,
            "isHidden": false,
            "config": "{colSpan:6,hideImage:false,titleValueAlign:vertical,titleFontSize:28,textAlign:start}",
            "configJson": {
                "colSpan": 6,
                "hideImage": false,
                "titleValueAlign": "vertical",
                "titleFontSize": 28,
                "textAlign": "start"
            },
            "ui": {
                "key": "card",
                "name": "Card",
                "colSpan": 3,
                "config": "{colSpan:10,hideImage:false,titleValueAlign:vertical,titleFontSize:16,textAlign:start}",
                "configJson": null,
                "jsonSchemaKey": "card_layout"
            },
            "templateFilterList": [
                {
                    "key": "datawipeOperator",
                    "name": "Datawipe Operator",
                    "type": "string",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "endDate",
                    "name": "End Date",
                    "type": "date",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "loggedInCompany",
                    "name": "Logged In Company",
                    "type": "string",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "operatingSystem",
                    "name": "operating system",
                    "type": "string",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "startDate",
                    "name": "Start Date",
                    "type": "date",
                    "isMandatory": false,
                    "templateId": null
                }
            ]
        },
        {
            "id": 59,
            "key": "datawipeErasuredSpeed",
            "name": "Erasure Speed",
            "priority": 5,
            "isHidden": false,
            "config": "",
            "configJson": {
                "colSpan": 10,
                "hideImage": false,
                "titleValueAlign": "vertical",
                "titleFontSize": 16,
                "textAlign": "start"
            },
            "ui": {
                "key": "card",
                "name": "Card",
                "colSpan": 3,
                "config": "{colSpan:10,hideImage:false,titleValueAlign:vertical,titleFontSize:16,textAlign:start}",
                "configJson": null,
                "jsonSchemaKey": "card_layout"
            },
            "templateFilterList": [
                {
                    "key": "datawipeOperator",
                    "name": "Datawipe Operator",
                    "type": "string",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "endDate",
                    "name": "End Date",
                    "type": "date",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "loggedInCompany",
                    "name": "Logged In Company",
                    "type": "string",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "operatingSystem",
                    "name": "operating system",
                    "type": "string",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "startDate",
                    "name": "Start Date",
                    "type": "date",
                    "isMandatory": false,
                    "templateId": null
                }
            ]
        },
        {
            "id": 53,
            "key": "datawipeDeviceProcessCountDateWise",
            "name": "Device Processed",
            "priority": 6,
            "isHidden": false,
            "config": "",
            "configJson": {},
            "ui": {
                "key": "compositeTableTime",
                "name": "Composite Table Time",
                "colSpan": 12,
                "config": null,
                "configJson": null,
                "jsonSchemaKey": null
            },
            "templateFilterList": [
                {
                    "key": "datawipeOperator",
                    "name": "Datawipe Operator",
                    "type": "string",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "endDate",
                    "name": "End Date",
                    "type": "date",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "loggedInCompany",
                    "name": "Logged In Company",
                    "type": "string",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "operatingSystem",
                    "name": "operating system",
                    "type": "string",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "startDate",
                    "name": "Start Date",
                    "type": "date",
                    "isMandatory": false,
                    "templateId": null
                }
            ]
        },
        {
            "id": 55,
            "key": "datawipeMostActiveUsers",
            "name": "Most Active Users",
            "priority": 9,
            "isHidden": false,
            "config": "",
            "configJson": {},
            "ui": {
                "key": "compositeBarGraph",
                "name": "Composite Bar Graph",
                "colSpan": 12,
                "config": null,
                "configJson": null,
                "jsonSchemaKey": null
            },
            "templateFilterList": [
                {
                    "key": "datawipeOperator",
                    "name": "Datawipe Operator",
                    "type": "string",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "endDate",
                    "name": "End Date",
                    "type": "date",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "loggedInCompany",
                    "name": "Logged In Company",
                    "type": "string",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "operatingSystem",
                    "name": "operating system",
                    "type": "string",
                    "isMandatory": false,
                    "templateId": null
                },
                {
                    "key": "startDate",
                    "name": "Start Date",
                    "type": "date",
                    "isMandatory": false,
                    "templateId": null
                }
            ]
        }
    ]
}

''';