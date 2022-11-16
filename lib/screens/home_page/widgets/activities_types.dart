import 'package:flutter/material.dart';
import 'package:schedulemanager/utils/responsive_util.dart';
import 'package:schedulemanager/utils/text_styles.dart';

import '../../../constants/constants.dart';

class ActivitiesTypes extends StatefulWidget {
  static const List<String> _types = ['Next', 'Not completed', 'Canceled'];
  const ActivitiesTypes({super.key});

  @override
  State<ActivitiesTypes> createState() => _ActivitiesTypesState();
}

class _ActivitiesTypesState extends State<ActivitiesTypes> {
  late int _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedType = 1;
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return Row(
      children: [
        ...List.generate(
          ActivitiesTypes._types.length,
          (x) => Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedType = x;
                });
              },
              child: Container(
                alignment: Alignment.center,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      // scale: animation,
                      child: child,
                    );
                  },
                  child: Text(
                    key: Key('${x == _selectedType}'),
                    ActivitiesTypes._types[x],
                    style: x == _selectedType
                        ? TextStyles.w700(resp.dp(1.55))
                        : TextStyles.w600(resp.dp(1.55), grey),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
