import 'package:flutter/material.dart';
import 'package:fudeo_hackaton/theme/colors.dart';

class AppFonts {
  static const TextStyle titleNav = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.navy,
  );
  static const TextStyle onboardingTitle = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
    fontFamily: 'RedHat',
    height: 1.1,
  );
  static const TextStyle onboardingSubTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
    fontFamily: 'RedHat',
    height: 1.4,
  );
  static const TextStyle label = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.navy,
  );

  static const homeHeader = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );
  static const TextStyle onboardingLink = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: AppColors.black,
      fontFamily: 'RedHat',
      height: 1.4,
      decoration: TextDecoration.underline);
  static const TextStyle onboardingButton = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: 'RedHat',
    height: 1.4,
  );
}
