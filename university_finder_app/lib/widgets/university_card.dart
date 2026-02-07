
import 'package:flutter/material.dart';

class UniversityCard extends StatelessWidget {
  const UniversityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('University Name'),
        subtitle: Text('Location'),
      ),
    );
  }
}
