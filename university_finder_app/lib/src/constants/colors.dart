// Importing the material library to use Color class
import 'package:flutter/material.dart';

// Class to hold all the color constants used in the application
class AppColors {
    // Primary color (Dark Blue/Navy)
    static const Color primary = Color(0xFF0D1B2A); // Adjust based on exact hex from image if possible

    // Secondary color (Lighter Blue/Grayish Blue)
    static const Color secondary = Color(0xFF1B263B);

    // Accent color (Blue/Teal) - for buttons/highlights
    static const Color accent = Color(0xFF415A77);
    
    // Highlight color (Bright Blue) - for active states
    static const Color highlight = Color(0xFF0077B6);

    // Background color
    static const Color background = Color(0xFF0D1B2A); // Dark background

    // Card background color
    static const Color cardBackground = Color(0xFF1B263B);

    // Text colors
    static const Color textPrimary = Colors.white;
    static const Color textSecondary = Colors.white70;
    
    // Error color
    static const Color error = Colors.redAccent;
}
