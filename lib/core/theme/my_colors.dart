import 'package:ngo/export_tools.dart';

class MyColors {
  static const primaryColor = Color(0xff007a3d);
  static const secondaryColor = Color(0xFF03DAC6);
  static const backgroundColor = Color(0xFFFFFFFF);
  static const errorColor = Color(0xFFB00020);
  static const textColor = Color(0xFF000000);
  static const accentColor = Color(0xFFFFC107);
  static const borderColor = Color(0xFFBDBDBD);
  static const grayColor = Color(0xFF9E9E9E);
  static const lightGrayColor = Color(0xFFF5F5F5);
  static const darkGrayColor = Color(0xFF424242);

  // Add more colors as needed
}




class AppTheme {
  static ThemeData lightTheme = ThemeData(
    // Base Colors
    primaryColor: MyColors.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: MyColors.primaryColor,
      secondary: MyColors.secondaryColor,
      error: MyColors.errorColor,
      background: MyColors.backgroundColor,
    ),

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: MyColors.primaryColor),
      titleTextStyle: TextStyle(
        color: MyColors.textColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    // Text Themes
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: MyColors.textColor,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: MyColors.textColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: MyColors.textColor,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: MyColors.textColor,
        fontSize: 14,
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      fillColor: MyColors.lightGrayColor,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: MyColors.borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: MyColors.borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: MyColors.primaryColor),
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
