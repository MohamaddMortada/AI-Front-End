import 'package:flutter/material.dart';
import 'package:front_end/controllers/assistive_ball_controller.dart';
import 'package:front_end/widgets/icon_Item.dart';
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


  Widget _buildIconsColumn() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         IconItem(route: '/main', icon: Icons.home,),
         IconItem(route: '/main', icon: Icons.chat,),
         IconItem(route: '/main', icon: Icons.person,),
         IconItem(route: '/main', icon: Icons.email,),
      ],
    );
  }
}
