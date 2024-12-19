import 'package:flutter/material.dart';
import 'package:front_end/controllers/assistive_ball_controller.dart';
import 'package:get/get.dart';

class AssistiveBall extends StatelessWidget {
  final AssistiveBallController controller = Get.put(AssistiveBallController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              left: MediaQuery.of(context).size.width / 2 +
                  controller.ballX.value -
                  40,
              top: MediaQuery.of(context).size.height / 2 +
                  controller.ballY.value -
                  40,
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
                      ? _buildIconsColumn()
                      : const Icon(Icons.touch_app,
                          color: Colors.white, size: 20),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _iconItem(IconData icon, String tooltip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Tooltip(
        message: tooltip,
        child: Icon(icon, color: Colors.white, size: 35),
      ),
    );
  }

  Widget _buildIconsColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _iconItem(Icons.home, "Home"),
        _iconItem(Icons.chat, "AI Chatbot"),
        _iconItem(Icons.person, "Profile"),
        _iconItem(Icons.email_outlined, "Contact Us"),
      ],
    );
  }
}
