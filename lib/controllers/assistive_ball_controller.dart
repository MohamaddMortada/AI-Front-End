import 'package:get/get.dart';

class AssistiveBallController extends GetxController {
  var isExpanded = false.obs; 
  var ballX = 0.0.obs; 
  var ballY = 0.0.obs; 

  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }

  void updateBallPosition(double dx, double dy) {
    if (!isExpanded.value) {
      ballX.value += dx;
      ballY.value += dy;
    }
  }

  void collapseBall() {
    if (isExpanded.value) {
      isExpanded.value = false;
    }
  }
}
