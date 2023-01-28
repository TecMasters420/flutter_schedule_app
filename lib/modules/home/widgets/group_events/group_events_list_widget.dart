import 'dart:math';

import 'package:flutter/material.dart';
import '../../../../app/config/constants.dart';
import '../../../../app/utils/responsive_util.dart';
import '../../../../app/utils/text_styles.dart';
import '../../../../widgets/custom_button.dart';

class GroupEventsListWidget extends StatelessWidget {
  const GroupEventsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final styles = TextStyles.of(context);
    const int containers = 10;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
            containers,
            (x) => Padding(
              padding: EdgeInsets.only(right: x < containers - 1 ? 20 : 0),
              child: Container(
                height: resp.hp(20),
                width: resp.wp(60),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: containerBg,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Container(
                            width: resp.wp(1.5),
                            decoration: BoxDecoration(
                              color:
                                  colors[Random().nextInt(colors.length - 1)],
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          SizedBox(width: resp.wp(2.5)),
                          Expanded(
                            flex: 15,
                            child: Text(
                              'Testing group events in schedule app',
                              style: styles.w700(14),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: resp.hp(1)),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(
                            child: Stack(
                              children: List.generate(3, (x) {
                                final pos = resp.wp(5) * x;
                                return Positioned(
                                  left: pos.toDouble(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: Image.asset(
                                      'assets/images/user.png',
                                      height: resp.hp(2.5),
                                      width: resp.wp(5),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.location_on_sharp,
                                      color: lightGrey,
                                      size: 15,
                                    ),
                                    SizedBox(width: resp.wp(1.5)),
                                    Expanded(
                                      child: Text(
                                        'BC, México (400km).',
                                        style: styles.w500(12, lightGrey),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: resp.hp(0.25)),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.access_time_filled,
                                      color: lightGrey,
                                      size: 15,
                                    ),
                                    SizedBox(width: resp.wp(1.5)),
                                    Expanded(
                                      child: Text(
                                        'In 14 minutes',
                                        style: styles.w500(12, lightGrey),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          text: 'Details',
                          color: blueAccent,
                          style: styles.w500(12, Colors.white),
                          onTap: () {},
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
