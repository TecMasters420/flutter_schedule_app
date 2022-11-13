import 'package:flutter/material.dart';
import 'package:schedulemanager/utils/text_styles.dart';

import '../constants/constants.dart';

class ActivitiesTypes extends StatelessWidget {
  static const List<String> _types = ['Next', 'Not completed', 'Canceled'];
  const ActivitiesTypes({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
          _types.length,
          (x) => Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                _types[x],
                style: x == 0 ? TextStyles.w600(16) : TextStyles.w400(16, grey),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
