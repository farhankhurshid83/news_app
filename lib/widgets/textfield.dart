import 'package:flutter/material.dart';
import '../configs/colors.dart';

class Textfield extends StatelessWidget {
  const Textfield({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50, // Set a fixed height instead of Expanded
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search news...",
          hintStyle: const TextStyle(color: lightBgColor),
          suffixIcon: Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.search_rounded, color: lightBgColor),
          ),
          fillColor: lightLabelColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
