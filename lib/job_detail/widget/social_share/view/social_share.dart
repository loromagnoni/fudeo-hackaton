import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudeo_hackaton/job_detail/widget/widget.dart';
import 'package:social_share_repository/social_share_repository.dart';

class SocialShare extends StatelessWidget {
  const SocialShare({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialShareBloc(
        socialShareRepository: context.read<SocialShareRepository>(),
      ),
      child: const ShareButton(),
    );
  }
}

class ShareButton extends StatelessWidget {
  const ShareButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialShareBloc, SocialShareState>(
      bloc: context.read<SocialShareBloc>(),
      builder: (context, state) => IconButton(
        icon: const Icon(Icons.share),
        onPressed: () => context
            .read<SocialShareBloc>()
            .add(const PressedSocialShareButton()),
      ),
    );
  }
}
