import 'dart:io';
import 'package:lottie/lottie.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechrock/main_controller.dart';

import 'auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Mineral Identifier',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
        seedColor: Color(0xFF2F4F4F), // Slate Gray as the primary color
    primary: Color(0xFF2F4F4F),) ,// Slate Gray
    useMaterial3: true,
    ),
    home: AuthScreen(),
    );
  }
}

class PickScreen extends StatelessWidget {
  const PickScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller c = Get.put(controller());

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2F4F4F), Color(0xFF50C878)], // Slate Gray to Emerald Green
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Larger Lottie animation
              Lottie.asset(
                "assets/animations/pic.json",
                width: 200, // Increased width
                height: 200, // Increased height
              ),
              const SizedBox(height: 40),
              // Horizontal layout for buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Capture Button
                  _buildActionButton(
                    icon: Icons.camera_alt,
                    label: "Capture",
                    onPressed: () async {
                      await c.getImageFromCamere();
                      c.get_label(c.selectedImagePath.value);
                    },
                  ),
                  const SizedBox(width: 20), // Spacing between buttons
                  // Select Button
                  _buildActionButton(
                    icon: Icons.photo_library,
                    label: "Select",
                    onPressed: () async {
                      await c.getImageFromGallery();
                      c.get_label(c.selectedImagePath.value);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable method to build action buttons
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        Container(
          width: 80, // Increased button width
          height: 80, // Increased button height
          decoration: BoxDecoration(
            color: Colors.white, // White background
            shape: BoxShape.circle, // Circular shape
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow for depth
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(icon, size: 40, color: Color(0xFF2F4F4F)), // Larger icon
          ),
        ),
        const SizedBox(height: 8), // Spacing between icon and text
        Text(
          label,
          style: TextStyle(
            fontSize: 16, // Text size
            color: Colors.white, // White text for contrast
          ),
        ),
      ],
    );
  }
}