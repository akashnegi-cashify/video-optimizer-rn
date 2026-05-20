import 'package:flutter/material.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/modules/laptop_assembly/widgets/laptop_assembly_home_widget.dart';

class LaptopAssemblyHomeScreen extends StatelessWidget {
  static const String route = "/laptop_assembly_home_screen";

  const LaptopAssemblyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrcHeader("Laptop Assembly"),
      body: const LaptopAssemblyHomeWidget(),
    );
  }
}
