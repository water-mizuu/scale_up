import "package:flutter/material.dart" hide SearchBar;
import "package:provider/provider.dart";
import "package:scale_up/presentation/bloc/Authentication/authentication_bloc.dart";
import "package:scale_up/presentation/views/home/widgets/styles.dart";
import "package:scale_up/utils/animated_scroll_controller.dart";

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfilePageView();
  }
}

class ProfilePageView extends StatelessWidget {
  const ProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(scrolledUnderElevation: 0.0, backgroundColor: Colors.transparent),
      body: Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Column(
          spacing: 16.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Styles.title("Account", textAlign: TextAlign.left),
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
                    Column(
                      spacing: 4.0,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Styles.body("Help and Support"),
                        ),
                        ListTile(
                          leading: Styles.tile("About ScaleUp"),
                          trailing: Icon(Icons.navigate_next),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Styles.tile("Help"),
                          trailing: Icon(Icons.navigate_next),
                          onTap: () {},
                        ),
                      ],
                    ),
                    Center(
                      child: TextButton(
                        child: Text("Log out"),
                        onPressed: () {
                          context.read<AuthenticationBloc>().add(LogoutAuthenticationEvent());
                        },
                      ),
                    ),
                    Center(child: Styles.body("ScaleUp v0.0.1")),
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
