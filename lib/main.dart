import "dart:io" show Platform;

import "package:firebase_core/firebase_core.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:scale_up/app.dart";
import "package:scale_up/data/sources/lessons/boolean_parser.dart";
import "package:scale_up/data/sources/lessons/lessons_helper/boolean_expression.dart";
import "package:scale_up/data/sources/lessons/numerical_expression_parser.dart";
import "package:window_manager/window_manager.dart";

import "firebase_options.dart";

void main() async {
  // Set up window manager to resize screen to mobile
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows)) {
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

  {
    var parser = NumericalExpressionParser();
    var expression = parser.parse("2 * a");
    if (expression case var expression?) {
      if (kDebugMode) {
        print(expression.evaluate({"a": 8}));
      }
    }
  }

  {
    var parser = BooleanParser();
    var expression = parser.parse("(2 * -a) >= 1");
    if (expression case BooleanExpression expr) {
      if (kDebugMode) {
        print(expr.evaluate({"a": 1}));
      }
    } else {
      print("Failed to parse: \n${parser.reportFailures()}");
    }
  }
  runApp(App());
}
