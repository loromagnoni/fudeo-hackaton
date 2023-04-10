part of 'app_routing_bloc.dart';

@immutable
abstract class AppRoutingState extends Equatable {
  const AppRoutingState(this.pages);

  final List<AppRouteConfig> pages;

  @override
  List<Object> get props => [];
}

class AppRoutingInitial extends AppRoutingState {
  const AppRoutingInitial(super.pages);
}

class AppRoutingJobOfferList extends AppRoutingState {
  const AppRoutingJobOfferList(super.pages);

  @override
  List<AppRouteConfig> get pages => <AppRouteConfig>[
        ...super.pages,
        const AppRouteJobOfferListConfig(),
      ];
}

abstract class AppRouteConfig<T> {
  const AppRouteConfig({
    required this.name,
    required this.path,
  });

  final String name;
  final String path;

  String pathFor(T args) {
    return path;
  }

  T from(String path) {
    throw UnimplementedError();
  }
}

abstract class AppRouteNoArgsConfig extends AppRouteConfig<void> {
  const AppRouteNoArgsConfig({
    required super.name,
    required super.path,
  });

  @override
  String pathFor(void args) => path;

  @override
  void from(String path) {

  }
}

class AppRouteJobOfferListConfig extends AppRouteNoArgsConfig {
  const AppRouteJobOfferListConfig() : super(name: 'job-offers', path: '/');
}

class AppRouteJobOfferDetailsConfig extends AppRouteConfig<int> {
  const AppRouteJobOfferDetailsConfig()
      : super(name: 'job-offers-details', path: '/job-offers/:id');

  @override
  String pathFor(int args) => path.replaceAll(':id', args.toString());

  @override
  int from(String path) => int.parse(path.split('/').last);
}
