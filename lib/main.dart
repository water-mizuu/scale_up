import "dart:io" show Platform;

import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:scale_up/app.dart";
import "package:window_manager/window_manager.dart";

import "firebase_options.dart";

void main() async {
  // Set up window manager to resize screen to mobile
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (Platform.isMacOS || Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = WindowOptions(
      size: Size(372, 817),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
    );

    await windowManager.waitUntilReadyToShow(windowOptions);
    await windowManager.show();
    await windowManager.focus();
  }

  runApp(App());
}
