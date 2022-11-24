import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

void main(List<String> args) {
  _uploadFile(args);
}

_uploadFile(List<String> args) async {
  var url = args[0];
  var source = args[1];
  var version = args[2];
  var module = args[3];
  var searchedFile = args[4];

  var file = await http.MultipartFile.fromPath(
    'file',
    searchedFile,
    filename: 'intl_en.arb',
    contentType: MediaType('application', 'json'),
  );

  print('request${file.contentType}-${file.field}');

  var request = new http.MultipartRequest("POST", Uri.parse(url));
  request.fields['ck'] = source;
  request.fields['cv'] = version;
  request.fields['ns'] = module;
  request.files.add(file);

  request.headers.addEntries([new MapEntry('Content-Type', 'multipart/form-data')]);

  print(request.headers);
  var response = await request.send();

  if (response.statusCode == 200) {
    print("Uploaded!");
    exit(0);
  } else {
    print("not Uploaded!${await response.stream.bytesToString()}");
    exit(0);
  }
}
