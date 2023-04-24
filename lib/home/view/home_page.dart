import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              )
            ],
            bottom: PreferredSize(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cosa cerchi?",
                    style: AppFonts.titleNav,
                    textAlign: TextAlign.left,
                  ),
                  SvgPicture.asset(
                    "assets/hero.svg",
                  ),
                ],
              ),
              preferredSize: const Size.fromHeight(200),
            ),
            centerTitle: false,
            expandedHeight: 300,
            backgroundColor: AppColors.blueShadesLight.withAlpha(8),
          )
        ],
      ),
    );
  }
}
