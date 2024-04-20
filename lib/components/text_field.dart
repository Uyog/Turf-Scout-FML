import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final String labeltext;
  final bool obscureText;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  

  const MyTextField({super.key,

  required this.hintText,
  required this.labeltext,
  required this.obscureText,
  required this.controller,
  required this.prefixIcon,
  required this.suffixIcon
  
  });

  @override
  Widget build(BuildContext context) {
    return TextField( 
      cursorErrorColor: const Color(0xff97FB57),
      style: const TextStyle(color: Color(0xff97FB57)),
      obscureText: obscureText,
      controller: controller,
      cursorColor:  const Color(0xff97FB57),
      decoration: InputDecoration(
        icon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText,
        labelText: labeltext,
        iconColor: const Color(0xff97FB57),
        
        
        

        
      ),
      
    );
  }
}