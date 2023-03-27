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

messageTextField({required String? text}) {
  return Padding(
    padding: const EdgeInsets.all(18),
    child: TextField(
        decoration: InputDecoration(
      filled: true,
      fillColor: Colors.grey[200],
      suffixIcon: IconButton(
        onPressed: () {}, 
        icon: Icon(Icons.send,
        color: Colors.amber,
        ),
        ),
      hintText: text,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
    )),
  );

}


