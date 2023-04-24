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
  static const TextStyle homeOpportunityCardTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );
  static const TextStyle homeOpportunityCardSubtitle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.extraDarkGrey,
  );
  static const TextStyle homeOpportunityCardTag = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.extraDarkGrey,
  );
  static const TextStyle jobListAppBar = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
    fontFamily: 'RedHat',
  );
  static const TextStyle jobListToggle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.greyDark,
    fontFamily: 'RedHat',
  );
  static const TextStyle jobListToggleActive = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
    fontFamily: 'RedHat',
  );
}
