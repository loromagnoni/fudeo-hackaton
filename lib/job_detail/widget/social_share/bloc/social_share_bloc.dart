import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_share_repository/social_share_repository.dart';

part 'social_share_event.dart';
part 'social_share_state.dart';

class SocialShareBloc extends Bloc<PressedSocialShareButton, SocialShareState> {
  SocialShareBloc({
    required SocialShareRepository socialShareRepository,
  })  : _socialShareRepository = socialShareRepository,
        super(const SocialShareState(shared: false)) {
    on<PressedSocialShareButton>(_handlePressedSocialShareButton);
  }

  final SocialShareRepository _socialShareRepository;

  void _handlePressedSocialShareButton(
    PressedSocialShareButton event,
    Emitter<SocialShareState> emit,
  ) {
    _socialShareRepository.socialShare();
    emit(const SocialShareState(shared: true));
  }
}
