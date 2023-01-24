import 'package:get/get.dart';

class ExpandibleWidgetController extends GetxController {
  final RxBool isExpanded = RxBool(false);

  void changeState(bool expanded) => isExpanded.value = expanded;
}
