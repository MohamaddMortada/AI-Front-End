import 'package:flutter/material.dart';
class RegisterGoogle extends StatelessWidget {
  const RegisterGoogle({super.key});

  

  @override
  Widget build(BuildContext context) {
   
   return GestureDetector(
            onTap:(){},
            child:Container(
      decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8)
    ),
    width:270,
    height: 45,
      child:  Row(
        mainAxisAlignment : MainAxisAlignment.spaceBetween,
        crossAxisAlignment : CrossAxisAlignment.center,
        children: [
            Image.network(
              'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
              width: 40,
              height: 40,
            ),
            const Text(
              "Register with Google", 
            style: TextStyle(
              color: Color.fromARGB(255, 203, 0, 0),
              fontWeight: FontWeight.w500,
              fontSize: 16,
              ),),
              const SizedBox(width: 30,),
          ],
      ),));
  
  }
} 