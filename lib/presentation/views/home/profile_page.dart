import "package:flutter/material.dart" hide SearchBar;
import "package:flutter/services.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:markdown_widget/markdown_widget.dart";
import "package:provider/provider.dart";
import "package:scale_up/hooks/use_animated_scroll_controller.dart";
import "package:scale_up/presentation/bloc/authentication/authentication_bloc.dart";
import "package:scale_up/presentation/views/home/widgets/context_dialog_widget.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfilePageView();
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

class ProfilePageView extends HookWidget {
  const ProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final hslColor = HSLColor.fromColor(primaryColor);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0) - const EdgeInsets.only(bottom: 16.0),
          child: Column(
            spacing: 16.0,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Styles.title("Help Center"),
              Expanded(child: _buildContent(context, hslColor)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, HSLColor hslColor) {
    var scrollController = useAnimatedScrollController();

    return SingleChildScrollView(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      child: Column(
        spacing: 8.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildInfoSection(
            context,
            "Common Questions (FAQ)",
            frequentlyAskedQuestions,
            Icons.question_answer_rounded,
            hslColor,
          ),
          _buildInfoSection(
            context,
            "Support Details",
            developerInformation,
            Icons.support_agent_rounded,
            hslColor.withHue((hslColor.hue + 40) % 360),
          ),
          _buildInfoSection(
            context,
            "About",
            appAbout,
            Icons.info_outline_rounded,
            hslColor.withHue((hslColor.hue + 80) % 360),
          ),
          _buildLogoutButton(context, hslColor),
          Center(
            child: Text(
              "ScaleUp v0.0.1",
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Widget _buildInfoSection(
    BuildContext context,
    String title,
    String content,
    IconData icon,
    HSLColor color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            colorScheme: ColorScheme.light(primary: color.toColor(), secondary: color.toColor()),
          ),
          child: ExpansionTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            leading: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.withLightness(0.95).withSaturation(0.2).toColor(),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(icon, color: color.toColor()),
            ),
            title: Text(title, style: TextStyle(fontSize: 16.0, color: Colors.grey.shade800)),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            children: [
              MarkdownWidget(
                data: content,
                shrinkWrap: true,
                config: MarkdownConfig(
                  configs: [
                    PConfig(
                      textStyle: TextStyle(
                        fontSize: 14.0,
                        height: 1.5,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, HSLColor hslColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
        icon: const Icon(Icons.logout_rounded),
        label: const Text("Log out", style: TextStyle(fontSize: 16.0)),
        onPressed: () async {
          HapticFeedback.selectionClick();

          var confirmation = await context.showConfirmationDialog(
            title: "Log out?",
            message: "Are you sure you want to log out?",
            cancelButtonText: "No",
            confirmButtonText: "Log out",
          );

          if (context.mounted && confirmation) {
            // Perform logout action
            context.read<AuthenticationBloc>().add(const LogoutAuthenticationEvent());
          }
        },
      ),
    );
  }
}
