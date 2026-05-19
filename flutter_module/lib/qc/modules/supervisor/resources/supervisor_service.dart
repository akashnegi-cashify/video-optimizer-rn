import 'dart:convert';

import 'package:flutter_trc/qc/modules/supervisor/resources/supervisor_device_detail_response.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class SupervisorService {
  static Stream<SupervisorDeviceDetailResponse?> getDeviceDetails(String? deviceBarcode,
      {bool isFullResponse = false}) {
    return QcService()
        .get('/supervisor/device-report/$deviceBarcode?idr=$isFullResponse', SupervisorDeviceDetailResponse.fromJson);
  }

  static Stream<SupervisorDeviceDetailResponse?> submitDeviceData(
    String? deviceBarcode,
    Map<String, dynamic> mismatchedData, {
    String? remarks,
  }) {
    Map<String, dynamic> request = {
      "remarks": remarks,
      "mismatch": mismatchedData,
    };

    return QcService().post('/supervisor/device-report/$deviceBarcode', SupervisorDeviceDetailResponse.fromJson,
        body: jsonEncode(request));
  }

  static String getDummyData() {
    return '{"r_id":"09356982-0e6f-4885-8e09-d52b87d910e7","mtb":"Akash Sharma QA","mta":1690790266000,"ctb":"Surbhi","cta":1687939830000,"pv":[{"pi":377,"pn":"Mobile Switch On","v":{"2451":"Not Working"},"svi":2452,"svn":"Working","c":"Does the Mobile Switch on?"},{"pi":378,"pn":"Touchscreen Check","v":{"2454":"Not Working","2455":"Not Tested"},"svi":2453,"svn":"Yes its Working","c":"Screen Condition"},{"pi":385,"pn":"Wifi condition","v":{"2481":"Not Working","2482":"wifi Not Tested"},"svi":2480,"svn":"Working","c":"Functional Condition"},{"pi":387,"pn":"Bluetooth","v":{"2487":"Bluetooth not working","2488":"Not Tested"},"svi":2486,"svn":"Bluetooth Working","c":"Functional Condition"},{"pi":412,"pn":"Physical Condition","v":{"2567":"Minor Scratches","2568":"Minor Dents","2569":"Major Dents","2570":"Cracked or Broken Panel","2571":"Bent","2572":"Missing Panel","2573":"Not Checked","400276":"Heavy Scratches","400992":"Heavy Scratches"},"svi":2566,"svn":"No Scratches","c":"Phones overall condition"},{"pi":434,"pn":"Physical Condition Scratch","v":{"3008":"Minor Scratch","3009":"Major Scratch","3010":"Not Checked","400993":"Normal sign of usage","400994":"Minor paint peel-off/Bubble","400995":"Major paint peel-off/Bubble","401040":"Major Scratch on Body","401041":"Minor Scratch on Body"},"svi":3007,"svn":"No Scratches","c":"Phones overall condition"},{"pi":435,"pn":"Physical Condition Dent","v":{"3012":"Minor Dents","3013":"Major Dents","3014":"Not Checked"},"svi":3011,"svn":"No Dents","c":"Phones overall condition"},{"pi":436,"pn":"Physical Condition Panel","v":{"3016":"Missing Panel","3017":"Not Checked","3018":"NO Defect in Panel","3044":"Loose Panel","400297":"Glass Panel Damaged"},"svi":3015,"svn":"Cracked or Broken Panel","c":"Phones overall condition"},{"pi":437,"pn":"Physical Condition Bent","v":{"3020":"Loose Screen","3021":"Not Checked","3022":"Phone not Bent"},"svi":3019,"svn":"Bent Panel","c":"Phones overall condition"},{"pi":414,"pn":"Icloud/Id lock (For Iphone)","v":{"2643":"Icloud Locked","2644":"Not Checked"},"svi":2642,"svn":"Icloud Not Locked","c":"Icloud/Id lock/Brand lock"},{"pi":400271,"pn":"Country Lock","v":{"400776":"Country Lock Enabled\t"},"svi":400775,"svn":"Country Lock Not Enabled\t","c":"Icloud/Id lock/Brand lock"},{"pi":400302,"pn":"Battery Health","v":{"400850":"Battery health 50 to 80%","400851":"Battery health less than 50%","400852":"Battery Health 50 to 60%","400853":"Battery Health 40 to 50%","400854":"Battery Health 30 to 40%","400855":"Battery Health 20 to 30%","400856":"Battery is in poor health"},"svi":400849,"svn":"Battery health above 80%","c":"Battery Health"},{"pi":396,"pn":"Proximity Sensor","v":{"2515":"Proximity Sensor Not Working","2516":"Not Tested"},"svi":2514,"svn":"Proximity Sensor Working","c":"Functional Condition"},{"pi":404,"pn":"Sim Tray","v":{"2539":"Sim Tray Missing","2540":"Sim Tray Broken","2541":"Not Tested"},"svi":2538,"svn":"Sim Tray Available","c":"Functional Condition"},{"pi":444,"pn":"Back Flashlight","v":{"3042":"Back Flashlight Not Working"},"svi":3043,"svn":"Back Flashlight Working","c":"Functional Condition"}],"dm":[{"r_id":"09356982-0e6f-4885-8e09-d52b87d910e7","n":"bottom panel","p":"https://s3n.stage.cashify.in/trc/5087b7dd096046cebc985abcf471d3e4.webp","iv":false},{"r_id":"09356982-0e6f-4885-8e09-d52b87d910e7","n":"Screen","p":"https://s3n.stage.cashify.in/trc/284aea2f0b944ad19b8414d6acb88a4b.webp","iv":false},{"r_id":"09356982-0e6f-4885-8e09-d52b87d910e7","n":"Back panel Image","p":"https://s3n.stage.cashify.in/trc/f8ab45a11ae643c2a3992ff7d4504fd1.webp","iv":false},{"r_id":"09356982-0e6f-4885-8e09-d52b87d910e7","n":"Top Image","p":"https://s3n.stage.cashify.in/trc/791d07fe7f7448dc98c42e1302c16d28.mp4","iv":true}]}';
  }
}
