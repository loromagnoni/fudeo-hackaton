import 'package:flutter/material.dart';
import 'package:fudeo_hackaton/job_detail/widget/widget.dart';

class JobOfferDetailPage extends StatelessWidget {
  const JobOfferDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [SocialShare()],
      ),
    );
  }
}
