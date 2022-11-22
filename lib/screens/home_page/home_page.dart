import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../../services/reminder_service.dart';
import '../../utils/responsive_util.dart';

import '../../constants/constants.dart';
import '../../utils/text_styles.dart';
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
                  Text('Hello ${auth.user!.displayName ?? 'NoName'}!',
                      style: TextStyles.w400(resp.sp16, lightGrey)),
                  Text(
                    'My daily activities',
                    style: TextStyles.w700(resp.sp30),
                  ),
                  SizedBox(height: resp.hp(2)),
                  SizedBox(
                    height: resp.hp(25),
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
