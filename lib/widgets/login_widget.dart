import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    // Expanded(
    //   flex: 2,
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(),
    //     child: Container(
    //       constraints: const BoxConstraints.expand(),
    //       padding: const EdgeInsets.symmetric(
    //         horizontal: 15,
    //         vertical: 20,
    //       ),
    //       decoration: BoxDecoration(
    //         color: Colors.white,
    //         borderRadius: BorderRadius.circular(20),
    //       ),
    //       child: Column(
    //         children: [
    //           Text(
    //             'Hello Again!',
    //             style: TextStyles.w500(20),
    //           ),
    //           Text(
    //             'aliquam consectetur et tincidunt praesent enim massa pellentesque velit odio neque',
    //             style: TextStyles.w100(12, Colors.grey[400]!),
    //             textAlign: TextAlign.center,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // ),
    return Container();
  }
}
