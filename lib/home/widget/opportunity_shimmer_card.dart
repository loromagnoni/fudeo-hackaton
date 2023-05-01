import 'package:flutter/material.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:fudeo_hackaton/theme/shadows.dart';

class OpportunityShimmerCard extends StatelessWidget {
  const OpportunityShimmerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: AppShadows.homeOpportunityCardShadows,
        color: AppColors.homeOpportunityCardBackground,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16,
                      width: 100,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 16,
                            width: 100,
                            color: Colors.grey[300],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                height: 32,
                width: 32,
                color: Colors.grey[300],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
