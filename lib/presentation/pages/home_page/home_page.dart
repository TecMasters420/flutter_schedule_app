import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedulemanager/data/models/reminder_model.dart';
import '../../../app/services/auth_service.dart';
import '../../../app/services/reminder_service.dart';
import '../../../app/utils/responsive_util.dart';

import '../../../app/utils/text_styles.dart';
import '../../widgets/user_profile_picture.dart';
import 'widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ReminderService>(context, listen: false).getData();
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final AuthService auth = Provider.of<AuthService>(context);
    final ReminderService service = Provider.of<ReminderService>(context);

    int remindersWithTasks = 0;
    double totalProgress = 0;
    for (final ReminderModel r in service.notExpiredReminders) {
      if (r.tasks.isNotEmpty) {
        remindersWithTasks += 1;
        totalProgress += r.progress;
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 32,
                right: 32,
                top: 50,
                bottom: 80,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: resp.hp(5)),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Welcome!',
                          style: TextStyles.w500(resp.sp20),
                        ),
                      ),
                      UserProfilePicture(
                        height: resp.hp(5),
                        width: resp.wp(10),
                        userImage: auth.userInformation!.imageURL ?? '',
                      )
                    ],
                  ),
                  SizedBox(height: resp.hp(2.5)),
                  Text(
                    'My daily activities',
                    style: TextStyles.w700(resp.sp30),
                  ),
                  SizedBox(height: resp.hp(2)),
                  SizedBox(
                    height: resp.hp(28),
                    width: resp.width,
                    child: const HomeActivitiesShow(),
                  ),
                  SizedBox(height: resp.hp(5)),
                  ActivitiesTypes(
                    initialTabIndex: 1,
                    remindersPerType: {
                      'Expired': service.expiredReminders,
                      'Current': service.notExpiredReminders,
                      'Completed': service.expiredReminders,
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
