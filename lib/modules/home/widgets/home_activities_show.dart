import 'package:flutter/material.dart';
import 'package:schedulemanager/modules/home/widgets/tasks_home_progress_container.dart';

class HomeActivitiesShow extends StatelessWidget {
  const HomeActivitiesShow({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      clipBehavior: Clip.none,
      physics: const BouncingScrollPhysics(),
      children: const [
        TasksHomeProgressContainer(),
      ],
    );
  }
}
