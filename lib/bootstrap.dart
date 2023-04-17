import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:fudeo_api/fudeo_api.dart';
import 'package:job_offer_repository/job_offer_repository.dart';
import 'package:social_share_repository/social_share_repository.dart';

typedef AppBuilder = FutureOr<Widget> Function(
  JobOfferRepository jobOfferRepository,
  SocialShareRepository socialShareRepository,
);

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap({required AppBuilder builder}) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  final fudeoAPI = FudeoAPI();
  final jobOfferRepository = JobOfferRepository(fudeoAPI: fudeoAPI);
  final socialShareRepository = SocialShareRepository();

  await runZonedGuarded(
    () async => runApp(
      await builder(
        jobOfferRepository,
        socialShareRepository,
      ),
    ),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
