import 'dart:io';

import 'package:localization/commands/printer.dart';

void main(List<String> arg) {
  if (arg.isEmpty) {
    print("Pass arguments to read git version, example - flutter_admin_ui or flutter_packages");
    return;
  }

  final expression = arg[0];


  // Read the file line by line and print the previous two lines, the matching line, and the next two lines
  var lines = File('./pubspec.yaml').readAsLinesSync();
  println("Current version available are :-");
  for (var i = 0; i < lines.length; i++) {
    if (lines[i].contains(expression)) {
      var previousLine2 = i >= 2 ? lines[i - 2] : null;
      var previousLine1 = i >= 1 ? lines[i - 1] : null;
      var matchingLine = lines[i];
      var nextLine1 = i < lines.length - 1 ? lines[i + 1] : null;
      var nextLine2 = i < lines.length - 2 ? lines[i + 2] : null;

      print(previousLine2?.trim());
      print(previousLine1?.trim());
      print(matchingLine.trim());
      print(nextLine1?.trim());
      println(nextLine2?.trim());
      println("");
      // print("\n");
    }
  }


  // /url: https:\/\/github.com\/reglobe\/flutter_admin_ui.git\n\s*ref:\sv[0-9]*\.[0-9]*\.[0-9]*\n\s*path:\s.*/gm
  // RegExp exp = RegExp(
  //     r'url: https:\/\/github.com\/reglobe\/"' '$projectName' '".git\n\s*ref:\sv[0-9]*\.[0-9]*\.[0-9]*\n\s*path:\s.*',
  //     multiLine: true);
}
