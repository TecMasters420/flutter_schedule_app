import 'package:flutter/material.dart';
import 'package:schedulemanager/constants/constants.dart';
import 'package:schedulemanager/utils/responsive_util.dart';

import '../utils/text_styles.dart';

class ActivitiesDetails extends StatelessWidget {
  static final Map<IconData, Map<String, List<Widget>>> _bodyElements = {
    Icons.calendar_today_rounded: {'Wednesday, 26 July': []},
    Icons.access_time_sharp: {'12:00 - 14:00': []},
    Icons.supervised_user_circle_outlined: {'Three': []},
    Icons.location_on_outlined: {
      'South Portland CA, Apple Juice ST.': [
        Image.asset(
          'assets/images/testMap.png',
          height: 150,
          width: 500,
          fit: BoxFit.cover,
        )
      ]
    },
    Icons.sunny: {
      'Expected weather for that day': [
        Container(
          height: 30,
          width: 70,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.75),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '10° C',
            style: TextStyles.w900(20, Colors.white),
            textAlign: TextAlign.center,
          ),
        )
      ]
    }
  };
  const ActivitiesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 80,
            right: 35,
            left: 35,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.arrow_back_ios_rounded),
              SizedBox(height: resp.hp(2.5)),
              Center(
                child: Text(
                  'Uber car rentals assistant',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.w700(25),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: resp.hp(2.5)),
              Text(
                'You have three reservations coming up today, besides that we have same priorities as always.',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.w400(14),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: resp.hp(5)),
              ..._bodyElements.entries.map(
                (e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Icon(
                              e.key,
                              color: grey,
                            ),
                          ),
                        ),
                        SizedBox(width: resp.wp(2.5)),
                        Flexible(
                          flex: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...e.value.keys.map(
                                (e) => Text(
                                  e,
                                  style: TextStyles.w600(16),
                                ),
                              ),
                              SizedBox(height: resp.hp(1)),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Column(
                                  children: e.value.values.map((e) => e).first,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: resp.wp(5)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
