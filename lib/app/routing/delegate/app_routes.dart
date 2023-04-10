import 'package:flutter/widgets.dart';
import 'package:fudeo_hackaton/app/routing/bloc/app_routing_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/job_offer_list.dart';

class AppRoute<Y, T extends AppRouteConfig<Y>> {
  const AppRoute({
    required this.config,
    required this.builder,
  });

  final T config;
  final Widget Function(Y args) builder;
}

List<AppRoute> appRoutes = <AppRoute>[
  AppRoute(
    config: const AppRouteJobOfferListConfig(),
    builder: (_) => const JobOfferListPage(),
  ),

];