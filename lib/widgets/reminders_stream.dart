import 'package:flutter/material.dart';
import 'package:schedulemanager/services/reminder_service.dart';

import '../models/reminder_model.dart';

class RemindersStream extends StatelessWidget {
  final ReminderService _reminderService = ReminderService();

  RemindersStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Reminder>>(
      stream: _reminderService.getReminders(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Has error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Text(
              'Complete or Connected, ${snapshot.data!.length} element/s loaded.');
        }
      },
    );
  }
}
