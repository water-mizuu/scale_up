import "dart:async";

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isImageLoaded = false;
  bool _isReadyToNavigate = false;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    // Delay image loading slightly to ensure context is ready
    Future.delayed(Duration.zero, () {
      if (mounted) {
        _preloadImage();
      }
    });

    // Force a longer minimum display time to ensure image is visible
    _startMinimumDisplayTimer();
  }

  // Preload the image to ensure it's in memory
  void _preloadImage() {
    try {
      // Try using a direct Image widget approach
      final imageProvider = const AssetImage("assets/logos/scaleup_logo.png");

      // Add an image stream listener to track loading
      final ImageStream stream = imageProvider.resolve(const ImageConfiguration());
      final ImageStreamListener listener = ImageStreamListener(
        (ImageInfo info, bool synchronousCall) {
          if (mounted) {
            setState(() {
              _isImageLoaded = true;

              if (kDebugMode) {
                print("Image loaded successfully");
              }
            });
          }
        },
        onError: (dynamic exception, StackTrace? stackTrace) {
          if (kDebugMode) {
            print("Error loading image: $exception");
          }
          // Try alternate approach on error
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              setState(() {
                _isImageLoaded = true;
              });
            }
          });
        },
      );

      stream.addListener(listener);
    } catch (e) {
      if (kDebugMode) {
        print("Error preloading image: $e");
      }
      // Failsafe: mark as loaded even if there was an error
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _isImageLoaded = true;
          });
        }
      });
    }
  }

  // Start a timer to ensure the splash screen shows for at least this duration
  void _startMinimumDisplayTimer() {
    // Ensure minimum display duration of 5 seconds to give the image time to load and be seen
    _navigationTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _isReadyToNavigate = true;
        });
        _checkAndNavigate();
      }
    });
  }

  void _checkAndNavigate() {
    try {
      // Only navigate if both conditions are met: image loaded and minimum time passed
      if (_isImageLoaded && _isReadyToNavigate) {
        // Add a forced delay to ensure the image is displayed
        Future.delayed(const Duration(seconds: 1), () {
          if (!mounted) return;

          // Check if user is already signed in
          final user = FirebaseAuth.instance.currentUser;

          if (user != null) {
            // User is logged in, go to home
            context.goNamed("home");
          } else {
            // User is not logged in, go to login
            context.goNamed("login");
          }
        });
      } else if (!_isImageLoaded) {
        // If image is still not loaded, check again after a delay
        Future.delayed(const Duration(milliseconds: 500), _checkAndNavigate);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Navigation error: $e");
      }
      // Failsafe: try to navigate to login on error
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          context.goNamed("login");
        }
      });
    }
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a white background
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: _isImageLoaded ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 700),
          child: Image.asset(
            "assets/logos/scaleup_logo.png",
            width: 500, // Increase from 400 to 500
            height: 500, // Increase from 400 to 500
            gaplessPlayback: true, // Prevents image flicker
            // Add error handling at the widget level too
            errorBuilder: (context, _, _) {
              return const SizedBox(
                width: 500, // Match the new width
                height: 500, // Match the new height
                child: Center(
                  child: Text(
                    "Scale Up",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
