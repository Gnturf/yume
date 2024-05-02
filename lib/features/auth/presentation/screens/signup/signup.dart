import 'package:flutter/material.dart';
import 'package:yume/features/auth/presentation/screens/signup/signup_password_create.dart';
import 'package:yume/features/auth/presentation/widgets/display_subtitle_text.dart';
import 'package:yume/features/auth/presentation/widgets/signup/country_select.dart';
import 'package:yume/features/welcome/presentation/widgets/icon_text_button.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.chevron_left,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
            size: 36,
          ),
          iconSize: 36,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 40,
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DisplaySubtitleText(
              displayText: "Sorryy, but we need you to verify your identity :)",
              subtitleText:
                  "By continuing with verification, you agree with YUME Terms and Condition of Use and Privacy Policys",
            ),
            const SizedBox(
              height: 40,
            ),
            const CountrySelect(),
            const Spacer(),
            IconTextButton.inverted(
              label: "Verify with Google",
              icon: Icons.abc,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const PasswordCreateScreen();
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
