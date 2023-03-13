import 'package:flutter/material.dart';

searchTextField({required String? text}) {
  return TextField(
    
    // controller: fieldController,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      prefixIcon: Icon(Icons.search),
      hintText: text,
   
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
    ),
  );
}