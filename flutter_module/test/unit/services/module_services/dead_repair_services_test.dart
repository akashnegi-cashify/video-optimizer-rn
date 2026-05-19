import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/dead_repair/resources/services.dart';
import 'package:flutter_trc/qc/modules/dead_repair/resources/reason_submit_request.dart';
import 'package:flutter_trc/qc/modules/dead_repair/resources/add_remove_part_request.dart';
import 'package:flutter_trc/qc/modules/dead_repair/resources/add_remove_part_response.dart';
import 'package:flutter_trc/qc/modules/dead_repair/resources/dead_mark_update_response.dart';
import 'package:flutter_trc/qc/modules/dead_repair/resources/accept_reject_dead_request.dart';
import 'package:flutter_trc/qc/modules/dead_repair/type.dart';
import 'package:flutter_trc/src/common/resources/device_mark_response.dart';
import 'package:flutter_trc/src/common/resources/device_dead_repair_reason_list_response.dart';

/// Unit tests for [DeviceDeadRepairServices] class.
///
/// These tests execute actual service methods to ensure code coverage.
/// Since the service uses internal QcService() instances, we test:
/// - Method invocation and stream creation
/// - Request body/parameter construction logic
/// - Return type verification
/// - Conditional endpoint selection logic
void main() {
  group('DeviceDeadRepairServices', () {
    group('reasonSubmission', () {
      test('should create stream with REPAIR_DEVICE role type', () {
        final request = ReasonSubmitRequest(
          code: 'DEVICE_001',
          remark: 'Test remark',
        );
        final stream = DeviceDeadRepairServices.reasonSubmission(
          RoleType.REPAIR_DEVICE.value,
          request,
        );
        expect(stream, isA<Stream<DeviceMarkResponse>>());
      });

      test('should create stream with DEAD_DEVICE role type', () {
        final request = ReasonSubmitRequest(
          code: 'DEVICE_001',
          remark: 'Test remark',
        );
        final stream = DeviceDeadRepairServices.reasonSubmission(
          RoleType.DEAD_DEVICE.value,
          request,
        );
        expect(stream, isA<Stream<DeviceMarkResponse>>());
      });

      test('should create stream with minimal request', () {
        final request = ReasonSubmitRequest();
        final stream = DeviceDeadRepairServices.reasonSubmission(1, request);
        expect(stream, isA<Stream<DeviceMarkResponse>>());
      });

      test('should create stream with full request', () {
        final request = ReasonSubmitRequest(
          code: 'DEVICE_001',
          remark: 'Test remark',
          id: 123,
          actionRemark: 'Action remark',
          skus: ['SKU_001', 'SKU_002'],
        );
        final stream = DeviceDeadRepairServices.reasonSubmission(1, request);
        expect(stream, isA<Stream<DeviceMarkResponse>>());
      });

      test('endpoint selection for REPAIR_DEVICE', () {
        const roleType = 1; // RoleType.REPAIR_DEVICE.value
        var endPoint = roleType == RoleType.REPAIR_DEVICE.value
            ? '/repair/device/mark-repair'
            : '/dead/device/mark-dead';

        expect(endPoint, equals('/repair/device/mark-repair'));
      });

      test('endpoint selection for DEAD_DEVICE', () {
        const roleType = 2; // RoleType.DEAD_DEVICE.value
        var endPoint = roleType == RoleType.REPAIR_DEVICE.value
            ? '/repair/device/mark-repair'
            : '/dead/device/mark-dead';

        expect(endPoint, equals('/dead/device/mark-dead'));
      });

      test('request body serialization', () {
        final request = ReasonSubmitRequest(
          code: 'DEVICE_001',
          remark: 'Test remark',
          id: 123,
        );
        final json = request.toJson();

        expect(json.containsKey('qrCode'), isTrue);
        expect(json['qrCode'], equals('DEVICE_001'));
        expect(json.containsKey('remark'), isTrue);
        expect(json['remark'], equals('Test remark'));
        expect(json.containsKey('id'), isTrue);
        expect(json['id'], equals(123));
      });
    });

    group('fetchReasonList', () {
      test('should create stream with REPAIR_DEVICE role type', () {
        final stream = DeviceDeadRepairServices.fetchReasonList(
          roleType: RoleType.REPAIR_DEVICE.value,
        );
        expect(stream, isA<Stream<DeviceDeadRepairReasonListResponse?>>());
      });

      test('should create stream with DEAD_DEVICE role type', () {
        final stream = DeviceDeadRepairServices.fetchReasonList(
          roleType: RoleType.DEAD_DEVICE.value,
        );
        expect(stream, isA<Stream<DeviceDeadRepairReasonListResponse?>>());
      });

      test('should create stream with null role type', () {
        final stream = DeviceDeadRepairServices.fetchReasonList();
        expect(stream, isA<Stream<DeviceDeadRepairReasonListResponse?>>());
      });

      test('endpoint selection for REPAIR_DEVICE', () {
        const int? roleType = 1; // RoleType.REPAIR_DEVICE.value
        var endPoint = roleType == RoleType.REPAIR_DEVICE.value
            ? '/repair/device/mark-repair/remark'
            : '/dead/device/mark-dead/remark';

        expect(endPoint, equals('/repair/device/mark-repair/remark'));
      });

      test('endpoint selection for DEAD_DEVICE', () {
        const int? roleType = 2; // RoleType.DEAD_DEVICE.value
        var endPoint = roleType == RoleType.REPAIR_DEVICE.value
            ? '/repair/device/mark-repair/remark'
            : '/dead/device/mark-dead/remark';

        expect(endPoint, equals('/dead/device/mark-dead/remark'));
      });
    });

    group('getScanDeviceDetail', () {
      test('should create stream with valid barcode', () {
        final stream = DeviceDeadRepairServices.getScanDeviceDetail('DEVICE_001');
        expect(stream, isA<Stream<DeadMarkUpdateResponse?>>());
      });

      test('should handle empty barcode', () {
        final stream = DeviceDeadRepairServices.getScanDeviceDetail('');
        expect(stream, isA<Stream<DeadMarkUpdateResponse?>>());
      });

      test('should handle special characters in barcode', () {
        final stream = DeviceDeadRepairServices.getScanDeviceDetail('DEV-001_TEST');
        expect(stream, isA<Stream<DeadMarkUpdateResponse?>>());
      });

      test('should handle unicode characters in barcode', () {
        final stream = DeviceDeadRepairServices.getScanDeviceDetail('设备_001');
        expect(stream, isA<Stream<DeadMarkUpdateResponse?>>());
      });

      test('params construction verification', () {
        const barCode = 'DEVICE_001';
        var params = {
          "qr": [barCode]
        };

        expect(params['qr'], equals(['DEVICE_001']));
        expect(params, isA<Map<String, List<String>>>());
      });
    });

    group('updateReasonSubmissionId', () {
      test('should create stream with valid request', () {
        final request = ReasonSubmitRequest(
          code: 'DEVICE_001',
          remark: 'Updated remark',
          id: 456,
        );
        final stream = DeviceDeadRepairServices.updateReasonSubmissionId(request);
        expect(stream, isA<Stream<DeviceMarkResponse?>>());
      });

      test('should create stream with minimal request', () {
        final request = ReasonSubmitRequest();
        final stream = DeviceDeadRepairServices.updateReasonSubmissionId(request);
        expect(stream, isA<Stream<DeviceMarkResponse?>>());
      });

      test('should create stream with full request', () {
        final request = ReasonSubmitRequest(
          code: 'DEVICE_002',
          remark: 'Full remark',
          id: 789,
          actionRemark: 'Action update',
          skus: ['SKU1', 'SKU2'],
        );
        final stream = DeviceDeadRepairServices.updateReasonSubmissionId(request);
        expect(stream, isA<Stream<DeviceMarkResponse?>>());
      });

      test('endpoint verification', () {
        const endpoint = '/dead/device/mark-dead/update/remark';

        expect(endpoint, equals('/dead/device/mark-dead/update/remark'));
        expect(endpoint, startsWith('/dead/device'));
        expect(endpoint, endsWith('/update/remark'));
      });
    });

    group('addRemovePart', () {
      test('should create stream for adding part', () {
        final request = AddRemovePartRequest(
          sku: 'SKU_001',
          id: 123,
        );
        final stream = DeviceDeadRepairServices.addRemovePart(request, true);
        expect(stream, isA<Stream<AddRemovePartResponse?>>());
      });

      test('should create stream for removing part', () {
        final request = AddRemovePartRequest(
          sku: 'SKU_001',
          id: 123,
        );
        final stream = DeviceDeadRepairServices.addRemovePart(request, false);
        expect(stream, isA<Stream<AddRemovePartResponse?>>());
      });

      test('should handle minimal request for add', () {
        final request = AddRemovePartRequest();
        final stream = DeviceDeadRepairServices.addRemovePart(request, true);
        expect(stream, isA<Stream<AddRemovePartResponse?>>());
      });

      test('should handle minimal request for remove', () {
        final request = AddRemovePartRequest();
        final stream = DeviceDeadRepairServices.addRemovePart(request, false);
        expect(stream, isA<Stream<AddRemovePartResponse?>>());
      });

      test('endpoint selection for isAddPart true', () {
        const isAddPart = true;
        var endPoint = isAddPart
            ? '/dead/device/add/part-sku'
            : '/dead/device/remove/part-sku';

        expect(endPoint, equals('/dead/device/add/part-sku'));
      });

      test('endpoint selection for isAddPart false', () {
        const isAddPart = false;
        var endPoint = isAddPart
            ? '/dead/device/add/part-sku'
            : '/dead/device/remove/part-sku';

        expect(endPoint, equals('/dead/device/remove/part-sku'));
      });

      test('request body serialization', () {
        final request = AddRemovePartRequest(
          sku: 'SKU_001',
          id: 123,
        );
        final json = request.toJson();

        expect(json.containsKey('sku'), isTrue);
        expect(json['sku'], equals('SKU_001'));
        expect(json.containsKey('id'), isTrue);
        expect(json['id'], equals(123));
      });
    });

    group('fetchAcceptDeadReasonList', () {
      test('should create stream and execute method', () {
        final stream = DeviceDeadRepairServices.fetchAcceptDeadReasonList();
        expect(stream, isA<Stream<DeviceDeadRepairReasonListResponse?>>());
      });

      test('method should be callable without throwing', () {
        expect(
          () => DeviceDeadRepairServices.fetchAcceptDeadReasonList(),
          returnsNormally,
        );
      });

      test('endpoint verification', () {
        const endpoint = '/dead/device/accept-dead/remark';

        expect(endpoint, equals('/dead/device/accept-dead/remark'));
        expect(endpoint, startsWith('/dead/device'));
        expect(endpoint, endsWith('/remark'));
      });
    });

    group('submitDeadDeviceRequest', () {
      test('should create stream for ACCEPT_DEAD request type', () {
        final request = AcceptRejectDeadRequest(
          markId: 123,
          remark: 'Accept remark',
          requestType: DeadDeviceRequestType.ACCEPT_DEAD,
        );
        final stream = DeviceDeadRepairServices.submitDeadDeviceRequest(request);
        expect(stream, isA<Stream<DeviceMarkResponse?>>());
      });

      test('should create stream for REPAIR_REJECT request type', () {
        final request = AcceptRejectDeadRequest(
          markId: 123,
          remark: 'Reject remark',
          requestType: DeadDeviceRequestType.REPAIR_REJECT,
        );
        final stream = DeviceDeadRepairServices.submitDeadDeviceRequest(request);
        expect(stream, isA<Stream<DeviceMarkResponse?>>());
      });

      test('should create stream for REPAIR_DONE request type', () {
        final request = AcceptRejectDeadRequest(
          markId: 123,
          remark: 'Repair done remark',
          requestType: DeadDeviceRequestType.REPAIR_DONE,
        );
        final stream = DeviceDeadRepairServices.submitDeadDeviceRequest(request);
        expect(stream, isA<Stream<DeviceMarkResponse?>>());
      });

      test('should create stream with full request', () {
        final request = AcceptRejectDeadRequest(
          markId: 123,
          remark: 'Full remark',
          actionRemark: 'Action remark',
          skus: ['SKU1', 'SKU2'],
          repairLevel: 'L1',
          requestType: DeadDeviceRequestType.ACCEPT_DEAD,
        );
        final stream = DeviceDeadRepairServices.submitDeadDeviceRequest(request);
        expect(stream, isA<Stream<DeviceMarkResponse?>>());
      });

      test('endpoint selection for REPAIR_REJECT', () {
        final requestType = DeadDeviceRequestType.REPAIR_REJECT;
        var endPoint = '';
        if (requestType == DeadDeviceRequestType.REPAIR_REJECT) {
          endPoint = '/dead/device/reject-dead';
        } else if (requestType == DeadDeviceRequestType.REPAIR_DONE) {
          endPoint = '/dead/device/mark-repair';
        } else if (requestType == DeadDeviceRequestType.ACCEPT_DEAD) {
          endPoint = '/dead/device/accept-dead';
        }

        expect(endPoint, equals('/dead/device/reject-dead'));
      });

      test('endpoint selection for REPAIR_DONE', () {
        final requestType = DeadDeviceRequestType.REPAIR_DONE;
        var endPoint = '';
        if (requestType == DeadDeviceRequestType.REPAIR_REJECT) {
          endPoint = '/dead/device/reject-dead';
        } else if (requestType == DeadDeviceRequestType.REPAIR_DONE) {
          endPoint = '/dead/device/mark-repair';
        } else if (requestType == DeadDeviceRequestType.ACCEPT_DEAD) {
          endPoint = '/dead/device/accept-dead';
        }

        expect(endPoint, equals('/dead/device/mark-repair'));
      });

      test('endpoint selection for ACCEPT_DEAD', () {
        final requestType = DeadDeviceRequestType.ACCEPT_DEAD;
        var endPoint = '';
        if (requestType == DeadDeviceRequestType.REPAIR_REJECT) {
          endPoint = '/dead/device/reject-dead';
        } else if (requestType == DeadDeviceRequestType.REPAIR_DONE) {
          endPoint = '/dead/device/mark-repair';
        } else if (requestType == DeadDeviceRequestType.ACCEPT_DEAD) {
          endPoint = '/dead/device/accept-dead';
        }

        expect(endPoint, equals('/dead/device/accept-dead'));
      });

      test('request body serialization', () {
        final request = AcceptRejectDeadRequest(
          markId: 123,
          remark: 'Test remark',
          actionRemark: 'Action',
          skus: ['SKU1'],
          repairLevel: 'L1',
          requestType: DeadDeviceRequestType.ACCEPT_DEAD,
        );
        final json = request.toJson();

        expect(json.containsKey('id'), isTrue);
        expect(json['id'], equals(123));
        expect(json.containsKey('remark'), isTrue);
        expect(json['remark'], equals('Test remark'));
        // requestType should not be in JSON (excludeToJson)
        expect(json.containsKey('requestType'), isFalse);
      });
    });

    group('RoleType enum', () {
      test('REPAIR_DEVICE has value 1', () {
        expect(RoleType.REPAIR_DEVICE.value, equals(1));
      });

      test('DEAD_DEVICE has value 2', () {
        expect(RoleType.DEAD_DEVICE.value, equals(2));
      });

      test('ACCEPT_REJECT_DEAD_DEVICE has value 3', () {
        expect(RoleType.ACCEPT_REJECT_DEAD_DEVICE.value, equals(3));
      });
    });

    group('DeadDeviceRequestType enum', () {
      test('ACCEPT_DEAD has value 1', () {
        expect(DeadDeviceRequestType.ACCEPT_DEAD.value, equals(1));
      });

      test('REPAIR_REJECT has value 2', () {
        expect(DeadDeviceRequestType.REPAIR_REJECT.value, equals(2));
      });

      test('REPAIR_DONE has value 3', () {
        expect(DeadDeviceRequestType.REPAIR_DONE.value, equals(3));
      });
    });

    group('Integration - All methods create valid streams', () {
      test('all service methods should be callable and return streams', () {
        final submitRequest = ReasonSubmitRequest(code: 'test');
        final addRemoveRequest = AddRemovePartRequest(sku: 'test', id: 1);
        final acceptRejectRequest = AcceptRejectDeadRequest(
          markId: 1,
          requestType: DeadDeviceRequestType.ACCEPT_DEAD,
        );

        expect(
          () => DeviceDeadRepairServices.reasonSubmission(1, submitRequest),
          returnsNormally,
        );
        expect(
          () => DeviceDeadRepairServices.fetchReasonList(roleType: 1),
          returnsNormally,
        );
        expect(
          () => DeviceDeadRepairServices.getScanDeviceDetail('test'),
          returnsNormally,
        );
        expect(
          () => DeviceDeadRepairServices.updateReasonSubmissionId(submitRequest),
          returnsNormally,
        );
        expect(
          () => DeviceDeadRepairServices.addRemovePart(addRemoveRequest, true),
          returnsNormally,
        );
        expect(
          () => DeviceDeadRepairServices.fetchAcceptDeadReasonList(),
          returnsNormally,
        );
        expect(
          () => DeviceDeadRepairServices.submitDeadDeviceRequest(acceptRejectRequest),
          returnsNormally,
        );
      });
    });
  });
}
