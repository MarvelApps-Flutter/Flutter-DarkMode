import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

// class MyThemes {
//   static final darkTheme = ThemeData(
//     scaffoldBackgroundColor:  const Color(0xFF1B1F20),
//     primaryColor: Colors.black,
//     textTheme: const TextTheme(
//       bodyText1: TextStyle(color: Colors.white),
//       bodyText2: TextStyle(color: Color(0xFF646F75)),
//       overline: TextStyle(color:  Color(0xAA474B4B)),
//     ),
//     shadowColor:const Color(0xAA070909),
//     cardColor: const Color(0xFF202125),
//     colorScheme: const ColorScheme.dark(),
//     bottomAppBarColor:const  Color(0xFF505455),
//     canvasColor: const Color(0xFF646E79),
//     iconTheme: const IconThemeData(color: Color(0xFF637079), opacity: 0.8),
//   );
//  static final lightTheme = ThemeData(
//     scaffoldBackgroundColor:const Color(0xFFEBECED),
//     textTheme:const TextTheme(
//       bodyText1: TextStyle(color: Colors.black),
//       bodyText2: TextStyle(color: Color(0xFF9A99AD)),
//       overline: TextStyle(color: Colors.white,),
//     ),
//     shadowColor:const Color(0xFFD0D3DB),
//     bottomAppBarColor:  Colors.blueGrey.shade200,
//     primaryColor: Colors.white,
//     cardColor: const Color(0xFFEDEEF0),
//     canvasColor: Colors.blueGrey.shade200,
//     colorScheme: const ColorScheme.light(),
//     iconTheme:const IconThemeData(color: Color(0xFFA0A0AA), opacity: 0.8),
//   );
// }

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF121422),
    primaryColor: Colors.black,
    textTheme: TextTheme(
      bodyText1: const TextStyle(color: Colors.white),
      bodyText2: TextStyle(color: Colors.grey.shade500),
      overline: const TextStyle(color: Color(0xAA474B4B)),
    ),
    shadowColor: const Color(0xAA070909),
    cardColor: const Color(0xFF1C1E2F),
    colorScheme: const ColorScheme.dark(),
    bottomAppBarColor: const Color(0xFF1C1E2F),
    iconTheme: IconThemeData(color: Colors.grey.shade500, opacity: 0.8),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade300,
    textTheme: TextTheme(
      bodyText1: const TextStyle(color: Colors.black),
      bodyText2: TextStyle(color: Colors.grey.shade700),
      overline: const TextStyle(
        color: Colors.white,
      ),
    ),
    shadowColor: const Color(0xFFD0D3DB),
    bottomAppBarColor: Colors.grey.shade400,
    primaryColor: Colors.white,
    cardColor: Colors.grey.shade400,
    canvasColor: Colors.blueGrey.shade200,
    colorScheme: const ColorScheme.light(),
    iconTheme: const IconThemeData(color: Colors.black, opacity: 0.8),
  );
}
