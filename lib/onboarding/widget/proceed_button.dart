import 'package:flutter/material.dart';
import 'package:fudeo_hackaton/home/view/home_page.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProceedButton extends StatelessWidget {
  const ProceedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.sky,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => const HomePage(),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 48,
            vertical: 16,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Prosegui',
                style: AppFonts.onboardingButton,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Icon(
                  PhosphorIcons.bold.caretRight,
                  color: AppColors.white,
                  size: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
