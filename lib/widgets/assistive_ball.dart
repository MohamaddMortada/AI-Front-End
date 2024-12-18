import 'package:flutter/material.dart';
import 'package:front_end/controllers/assistive_ball_controller.dart';
import 'package:get/get.dart';

class AssistiveBall extends StatelessWidget {

  final AssistiveBallController controller = Get.put(AssistiveBallController());

  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          controller.collapseBall(); 
        },
        onPanUpdate: (details) {
          controller.updateBallPosition(details.delta.dx, details.delta.dy); 
        },
        child: Stack(
          children: [
            Obx(() {
              return Positioned(
                left: MediaQuery.of(context).size.width / 2 + controller.ballX.value - 40,
                top: MediaQuery.of(context).size.height / 2 + controller.ballY.value - 40,
                child: GestureDetector(
                  onTap: controller.toggleExpansion, 
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 80,
                    height: controller.isExpanded.value ? 300 : 80, 
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(40),
                      
                    ),
                    child: controller.isExpanded.value
                        ? BuildIconsColumn() 
                        : const Icon(Icons.touch_app,
                            color: Colors.white, size: 20), 
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
  Widget IconItem(IconData icon, String tooltip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Tooltip(
        message: tooltip,
        child: Icon(icon, color: Colors.white, size: 35),
      ),
    );
  }
  
    Widget BuildIconsColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconItem(Icons.home, "Home"),
        IconItem(Icons.chat, "AI Chatbot"),
        IconItem(Icons.person, "Profile"),
        IconItem(Icons.email_outlined, "Contact Us"),
      ],
    );
  }

}
