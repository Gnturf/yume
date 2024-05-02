import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yume/features/auth/presentation/widgets/display_subtitle_text.dart';
import 'package:yume/features/welcome/presentation/widgets/icon_text_button.dart';

class ProfileMakingScreen extends StatelessWidget {
  const ProfileMakingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              displayText: "Decide how you want people to see you!",
              subtitleText: "Create your profile",
            ),
            const SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 116,
                height: 116,
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
              maxLength: 20,
              decoration: InputDecoration(
                counterText: "",
                hintText: "What's your name?",
                hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.6),
                    ),
              ),
            ),
            const Spacer(),
            IconTextButton(label: "Create your account", onPressed: () {})
          ],
        ),
      ),
    );
  }
}
