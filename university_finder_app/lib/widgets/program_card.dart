
import 'package:flutter/material.dart';

class ProgramCard extends StatelessWidget {
  const ProgramCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Program Name'),
        subtitle: Text('Duration'),
      ),
    );
  }
}
