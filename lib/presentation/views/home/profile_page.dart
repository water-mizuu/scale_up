import "package:flutter/material.dart" hide SearchBar;
import "package:flutter/services.dart";
import "package:flutter_markdown_plus/flutter_markdown_plus.dart";
import "package:provider/provider.dart";
import "package:scale_up/presentation/bloc/Authentication/authentication_bloc.dart";
import "package:scale_up/presentation/views/home/widgets/context_dialog_widget.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/animated_scroll_controller.dart";

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfilePageView();
  }
}

const frequentlyAskedQuestions = """
- **Can the application be used offline?**
  - No, the application requires an internet connection. Local offline may come in the future.
- **How do I contact support?**
  - You can contact support by going to the "Support" section in the app settings.
- **What units are used in the app?**
  - The app uses various units for the measurements.
  - Some of the units include:
    - Temperature (Fahrenheit, Kelvin, Celsius)
    - Length (Meters, Feet, Kilometers, Miles)
    - Volume (Quarts, Gallons, Liters)
""";

const developerInformation = """
- **Developer Name:** John Doe
- **Mobile Number:** (+63) 998 012 3456
""";

const appAbout = """
- **Flutter version:** 3.29.2
- **Dart version:** 3.7.2
""";

class ProfilePageView extends StatelessWidget {
  const ProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(forceMaterialTransparency: true, elevation: 0, scrolledUnderElevation: 0),
      body: Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Column(
          spacing: 16.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Styles.title("Help Center", textAlign: TextAlign.left),
            ),
            Expanded(
              child: InheritedProvider(
                create: (_) => AnimatedScrollController(),
                dispose: (_, v) => v.dispose(),
                builder: (context, child) {
                  return SingleChildScrollView(
                    controller: context.read<AnimatedScrollController>(),
                    child: child,
                  );
                },
                child: Column(
                  spacing: 8.0,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ExpansionTile(
                      title: Text("Common Questions (FAQ)"),
                      children: [Markdown(data: frequentlyAskedQuestions, shrinkWrap: true)],
                    ),
                    ExpansionTile(
                      title: Text("Support Details"),
                      children: [Markdown(data: developerInformation, shrinkWrap: true)],
                    ),
                    ExpansionTile(
                      title: Text("About"),
                      children: [Markdown(data: appAbout, shrinkWrap: true)],
                    ),
                    ListTile(
                      title: Text("Log out"),
                      trailing: Icon(Icons.logout),
                      textColor: Colors.redAccent,
                      iconColor: Colors.redAccent,
                      onTap: () async {
                        HapticFeedback.selectionClick();

                        var confirmation = await context.showConfirmationDialog(
                          title: "Log out?",
                          message: "Are you sure you want to log out?",
                          cancelButtonText: "No",
                          confirmButtonText: "Log out",
                        );

                        if (context.mounted && confirmation) {
                          // Perform logout action
                          context.read<AuthenticationBloc>().add(LogoutAuthenticationEvent());
                        }
                      },
                    ),
                    Center(child: Styles.hint("ScaleUp v0.0.1")),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
