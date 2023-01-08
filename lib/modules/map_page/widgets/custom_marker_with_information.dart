import 'dart:async';

import 'package:flutter/material.dart';
import 'package:schedulemanager/app/utils/responsive_util.dart';

import '../../../app/utils/text_styles.dart';
import '../../../widgets/animated_marker.dart';

class CustomMarkerWithInformation extends StatefulWidget {
  final String label;

  const CustomMarkerWithInformation({
    super.key,
    required this.label,
  });

  @override
  State<CustomMarkerWithInformation> createState() =>
      _CustomMarkerWithInformationState();
}

class _CustomMarkerWithInformationState
    extends State<CustomMarkerWithInformation> {
  late bool _showData;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _showData = true;
    _timer = Timer.periodic(
      const Duration(milliseconds: 1500),
      (timer) {
        setState(() {
          _showData = false;
        });
        return timer.cancel();
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.translate(
          offset: Offset(0, resp.hp(2.5)),
          child: AnimatedOpacity(
            opacity: _showData ? 1 : 0,
            duration: const Duration(milliseconds: 250),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Text(
                widget.label,
                style: TextStyles.w500(14),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _showData = !_showData;
            });
          },
          child: const AnimatedMarker(),
        ),
      ],
    );
  }
}
