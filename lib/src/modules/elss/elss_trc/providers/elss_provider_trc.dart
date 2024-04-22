import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common_models/elss_device_details_response.dart';
import '../../common_models/elss_option_response.dart';
import '../../common_models/elss_part.dart';
import '../../common_models/elss_part_submit_response.dart';
import '../../common_models/part_device_list.dart';
import '../../common_models/upload_fault_images_response.dart';
import '../../common_resources/elss_option.dart';
import '../../common_resources/elss_service.dart';

class ELssProviderTrc extends CshChangeNotifier {
  static ELssProviderTrc of(BuildContext context, {bool listen = true}) {
    return Provider.of<ELssProviderTrc>(context, listen: listen);
  }

  ELssProviderTrc(String barcode,
      {Function(String, {ElssDeviceDetailsResponse? detailsData})? onProductIdMissingCallback}) {
    _getDeviceDetailsData(barcode, onProductIdMissingCallback: onProductIdMissingCallback);
    _getElssOptionsList(barcode);
  }

  bool isDetailsDataLoading = true;
  ElssDeviceDetailsResponse? elssDeviceDetails;
  bool isElssOptionsLoading = true;
  ElssOptionResponse? elssOptionResponse;
  List<OptionResponse> productOptionList = [];
  List<ElssPart> elssPartList = [];
  List<ElssPart> searchedElssPartList = [];
  List<ElssPart> manualAddedPartsList = [];
  int selectedOptionKey = -1;
  String submitButtonName = "Select Option";
  bool isGc = false, isPna = false, isra = false;
  UploadFaultImagesResponse? uploadFaultImagesResponse;
  String apiErrorMessage = "";
  ElssPartSubmitResponse? elssPartSubmitResponse;

  _getDeviceDetailsData(String scannedBarcode,
      {Function(String, {ElssDeviceDetailsResponse? detailsData})? onProductIdMissingCallback}) {
    ElssService.getElssDeviceDetails(scannedBarcode).listen((event) {
      if (event != null) {
        elssDeviceDetails = event;
        if (elssDeviceDetails?.deviceDetailsData?.productId == null) {
          if (onProductIdMissingCallback != null) {
            onProductIdMissingCallback(scannedBarcode, detailsData: elssDeviceDetails);
          }
        } else {
          if (!Validator.isListNullOrEmpty(event.deviceDetailsData?.repairPartList)) {
            int k = 1;
            for (var element in event.deviceDetailsData!.repairPartList!) {
              element.elssPartId = k;
              element.partsImageList = ["", "", "", "", "", ""];
              element.action = "Repairable";
              elssPartList.add(element);
              k++;
            }
          }
        }
      }
      isDetailsDataLoading = false;
      notifyListeners();
    }, onError: (error) {
      String errMessage = ApiErrorHelper.getErrorMessage(error) ?? "Someting went wrong";
      apiErrorMessage = errMessage;
      Logger.debug('mydebug------ELssProvider._getDeviceDetailsData', [errMessage]);
      isDetailsDataLoading = false;
      notifyListeners();
    });
  }

  _getElssOptionsList(String scannedBarcode) {
    ElssService.getElssOptions(scannedBarcode).listen(
      (event) {
        if (event != null) {
          elssOptionResponse = event;
          if (!Validator.isListNullOrEmpty(event.listOfOptions)) {
            productOptionList = event.listOfOptions!;
            _checkIsOptionRequires();
          }
        }
        isElssOptionsLoading = false;
        notifyListeners();
      },
      onError: (error) {
        String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "something went wrong";
        Logger.debug('mydebug------ELssProvider._getElssOptionsList', [errorMessage]);
        isElssOptionsLoading = false;
        notifyListeners();
      },
    );
  }

  _checkIsOptionRequires() {
    for (var element in productOptionList) {
      if (element.getIsApplicableOptionsPresent()) {
        element.isApplicableReasonRequired = true;
      }
    }
  }

  searchItemDataUpdate(int id, {String? action}) {
    Logger.debug('mydebug------ELssProvider.searchItemDataUpdate', [id, action]);
    if (!Validator.isListNullOrEmpty(elssPartList)) {
      for (var element in elssPartList) {
        if (element.elssPartId == id && !Validator.isNullOrEmpty(action)) {
          element.action = action!;
          break;
        }
      }
    }
    notifyListeners();
  }

  getSearchResults(String data) {
    if (!Validator.isListNullOrEmpty(elssPartList)) {
      searchedElssPartList = elssPartList.where((element) {
        if (!Validator.isNullOrEmpty(element.partName)) {
          return element.partName!.toLowerCase().contains(data.toLowerCase());
        }
        return false;
      }).toList();
      notifyListeners();
    }
  }

  addNewPartsFromAddParts(List<PartItemDataResponse> dataList) {
    for (var element in dataList) {
      ElssPart data = ElssPart(
        partName: element.productName,
        partColour: element.productColour,
        action: null,
        sku: element.sku,
        isManualAdded: true,
        categoryCode: element.categoryCode,
      );
      data.elssPartId = elssPartList.length + 1;
      data.partsImageList = ["", "", "", "", "", ""];

      elssPartList.add(data);
      manualAddedPartsList.add(data);
    }
    notifyListeners();
  }

  removeExternalAddedPart(int id) {
    elssPartList.removeWhere((element) => element.elssPartId == id);
    manualAddedPartsList.removeWhere((element) => element.elssPartId == id);
    int k = 0;
    for (var element in elssPartList) {
      element.elssPartId = k;
      k++;
    }
    notifyListeners();
  }

  removeAddedDataFromSearchAndMasterList(int id) {
    searchedElssPartList.removeWhere((element) => element.elssPartId == id);
    removeExternalAddedPart(id);
  }

  clearSearchResults() {
    searchedElssPartList.clear();
    notifyListeners();
  }

  setSelectedOptionKey(int key) {
    selectedOptionKey = key;
    int index = productOptionList.indexWhere((element) {
      if (element.key != null) {
        return (element.key! == selectedOptionKey);
      }
      return false;
    });

    if (index != -1) {
      submitButtonName = productOptionList[index].optionName ?? "";
    }
    notifyListeners();
  }

  resetSelectedOptions() {
    selectedOptionKey = -1;
    submitButtonName = "Select Option";
    for (var element in productOptionList) {
      if (element.isApplicableReasonRequired ?? false) {
        element.isRub = false;
        element.isPNA = false;
        element.isGc = false;
      }
    }
    notifyListeners();
  }

  setApplicableReasonsToOptions(int key, {bool? isGca, bool? isPnaa, bool? isRuba}) {
    int index = productOptionList.indexWhere((element) {
      if (element.key != null) {
        return element.key! == key;
      }
      return false;
    });
    if (index != -1) {
      productOptionList[index].isPNA = isPnaa;
      productOptionList[index].isRub = isRuba;
      productOptionList[index].isGc = isGca;
    }
    notifyListeners();
  }

  addS3UrlToListOfPartsImage(int partId, int ind, String s3Url) {
    if (!Validator.isListNullOrEmpty(elssPartList)) {
      int index = elssPartList.indexWhere((element) => element.elssPartId == partId);
      if (index != -1) {
        elssPartList[index].partsImageList![ind] = s3Url;

        Logger.debug('mydebug------ELssProvider.addS3UrlToListOfPartsImage', [elssPartList[index].partsImageList]);
      }
    }
    notifyListeners();
  }

  getDetailsPostDatMap(String scannedBarcode) {
    Map<String, dynamic> dataMap = {};

    if (selectedOptionKey != -1) {
      dataMap["ac"] = selectedOptionKey;
      if (selectedOptionKey == 1 || selectedOptionKey == 2 || selectedOptionKey == 3) {
        int index = productOptionList.indexWhere((element) {
          if (element.key != null) {
            return (element.key! == selectedOptionKey);
          }
          return false;
        });
        if (index != -1) {
          isGc = productOptionList[index].isGc ?? false;
          isPna = productOptionList[index].isPNA ?? false;
          isra = productOptionList[index].isRub ?? false;
          dataMap["isGc"] = isGc;
          dataMap["isPna"] = isPna;
          dataMap["isra"] = isra;
        }
      }
      ElssOption? option = ElssOption.getEnumFromValue(selectedOptionKey);
      if (option != null) {
        dataMap["rt"] = ElssOption.getOptionName(option);
      }
    }
    List<Map<String, dynamic>> rprlList = [];
    for (var data in elssPartList) {
      Logger.debug('mydebug------_PartSelectionWidgetTrcState._showElssOptionsModal', [data.toJson()]);
    }
    if (elssPartList.isNotEmpty) {
      rprlList = List.generate(elssPartList.length, (index) {
        return {
          "isManualAdded": elssPartList[index].isManualAdded,
          "isPnaSelected": elssPartList[index].isPnaSelected,
          "pcl": elssPartList[index].partColour,
          "pc": 1,
          if (!Validator.isNullOrEmpty(elssPartList[index].action)) "ac": elssPartList[index].action,
          "pn": elssPartList[index].partName,
          "sku": elssPartList[index].sku,
          "selectedPos": elssPartList[index].isManualAdded == true ? -1 : 0,
          "_v": 0,
          "cc": elssPartList[index].categoryCode,
        };
      });
    }

    dataMap["rprl"] = rprlList;
    dataMap["version"] = 0;
    dataMap["dbr"] = scannedBarcode;
    return dataMap;
  }

  getSelectedPartsFaultImages() {
    Map<String, List<String>> imageDataMap = {};
    if (!Validator.isListNullOrEmpty(elssPartList)) {
      List<String> listOfSkus = [];
      for (var element in elssPartList) {
        if (!listOfSkus.contains(element.sku)) {
          listOfSkus.add(element.sku ?? "");
        }
      }

      for (String skuName in listOfSkus) {
        List<String> clubbedSkuImage = [];
        for (var item in elssPartList) {
          if (item.sku == skuName) {
            List<String> shortUrlList = [];
            for (String s3Url in item.partsImageList!) {
              if (s3Url.isNotEmpty) {
                shortUrlList.add(s3Url.substring(0, s3Url.indexOf("?")));
              }
            }
            clubbedSkuImage.addAll(shortUrlList);
          }
        }
        imageDataMap[skuName] = clubbedSkuImage;
      }
    }
    Logger.debug('mydebug------ELssProvider.getSelectedPartsFaultImages', [imageDataMap]);
    return imageDataMap;
  }

  submitPartsFaultImages(String scannedBarcode, Map<String, List<String>> imagesDataMap) {
    ElssService.uploadPartsFaultImages(scannedBarcode, imagesDataMap).listen((event) {
      if (event != null) {
        uploadFaultImagesResponse = event;
      }
    }, onError: (error) {
      String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      Logger.debug('mydebug------ELssProvider.submitPartsFaultImages', [errorMessage]);
    }, onDone: () {
      notifyListeners();
    });
  }

  Future<bool> submitElssPartRequest(String scannedBarcode) {
    Map<String, dynamic> dataMap = getDetailsPostDatMap(scannedBarcode);
    var completer = Completer<bool>();
    try {
      ElssService.elssSubmitPartsRequest(dataMap).listen((event) {
        if (event != null) {
          elssPartSubmitResponse = event;
          if (event.isSuccess ?? false) {
            completer.complete(true);
          } else {
            completer.completeError(event.errorMessage ?? "Error in submitting details!!");
          }
        }
      }, onError: (error) {
        String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Some error occurred";
        completer.completeError(errorMessage);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }

    return completer.future;
  }

  getIsPnaSelectedOrNot(int key) {
    int index = productOptionList.indexWhere((element) {
      if (element.key != null) {
        return element.key! == key;
      }
      return false;
    });
    if (index != -1) {
      var option = productOptionList[index];
      if (option.isPNA != null && option.isPNA == true) {
        return true;
      }
    }
    return false;
  }

  bool checkPartsManuallyAdded() {
    if (!Validator.isListNullOrEmpty(elssPartList)) {
      for (var element in elssPartList) {
        if (element.isManualAdded == true) {
          return true;
        }
      }
    }
    return false;
  }

  checkIsSkuIsMarkedForPna(List<ElssPart> dataList) {
    if (!Validator.isListNullOrEmpty(dataList)) {
      for (var element in dataList) {
        if (element.isPnaSelected == true) {
          return true;
        }
      }
    }

    return false;
  }

  clearPnaStatusWhenPop() {
    if (!Validator.isListNullOrEmpty(elssPartList)) {
      for (var element in elssPartList) {
        element.isPnaSelected = false;
      }
    }
  }
}
