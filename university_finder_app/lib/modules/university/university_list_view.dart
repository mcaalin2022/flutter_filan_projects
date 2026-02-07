
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:university_finder_app/modules/university/university_controller.dart';

class UniversityListView extends GetView<UniversityController> {
  const UniversityListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Universities')),
      body: Center(child: Text('University List')),
    );
  }
}
