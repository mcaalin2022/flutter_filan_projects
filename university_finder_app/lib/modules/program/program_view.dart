
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:university_finder_app/modules/program/program_controller.dart';

class ProgramView extends GetView<ProgramController> {
  const ProgramView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Program')),
      body: Center(child: Text('Program View')),
    );
  }
}
