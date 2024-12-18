import 'package:get/get.dart';

class AssistiveBallController extends GetxController {
  var isExpanded = false.obs; 
 

  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }

}
