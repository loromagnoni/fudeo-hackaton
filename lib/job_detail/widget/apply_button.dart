import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplyButton extends StatelessWidget {
  ApplyButton({super.key, this.url});

  String? url;

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
              FilledButton(
                onPressed: () {
                  launchUrl(Uri.parse(url!));
                },
                child: Text('Apply'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
