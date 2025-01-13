import 'package:flutter/material.dart';
import 'package:front_end/widgets/button_secondary.dart';
import 'package:front_end/widgets/text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ImageButton extends StatelessWidget {
  final String imagePath;
  final String text;
  final String discription;
  final String route;

  const ImageButton(
      {super.key,
      required this.imagePath,
      required this.text,
      required this.discription,
      required this.route});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.toNamed(route);
        },
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 128, 168, 183),
              borderRadius: BorderRadius.circular(10)),
          width: 330,
          height: 150,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'Title',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    discription,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(route);
                      },
                      child: Container(
                        child: Text(
                          text,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                        ),
                      ))
                ],
              ),
              Container(
                  child: Image.asset(
                imagePath,
                width: 50,
                height: 50,
              )),
            ],
          ),
        ));
  }
}
