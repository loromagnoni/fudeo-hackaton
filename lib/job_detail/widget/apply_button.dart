import 'package:flutter/material.dart';
import 'package:fudeo_hackaton/theme/buttons.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplyButton extends StatelessWidget {
  const ApplyButton({super.key, this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    if (url == null) return Container();
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppButton(
                action: () => launchUrl(Uri.parse(url!)),
                text: 'Candidati!',
                iconData: PhosphorIcons.bold.confetti,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
