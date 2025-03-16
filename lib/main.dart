import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:scale_up/app.dart';
import 'dart:io' show Platform;

void main() async {
  // Set up window manager to resize screen to mobile
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  if (Platform.isMacOS || Platform.isWindows) {
    WindowOptions windowOptions = WindowOptions(
      size: Size(372, 817),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(App());
}
