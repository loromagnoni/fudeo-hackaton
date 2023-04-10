import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudeo_hackaton/app/routing/delegate/app_routes.dart';
import 'package:fudeo_hackaton/app/routing/bloc/app_routing_bloc.dart';

class AppRoutingDelegate extends RouterDelegate<Object> {
  AppRoutingDelegate(this.bloc) : super();

  final AppRoutingBloc bloc;

  @override
  void addListener(VoidCallback listener) {
    bloc.on(
      (event, emit) => listener(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppRoutingBloc, AppRoutingState>(
      bloc: bloc,
      listener: (context, state) {},
      builder: (context, state) {
        final routes = state.pages
            .map((e) => appRoutes.firstWhere((element) => element.config == e));

        return Navigator(
          pages: routes
              .map(
                (e) => MaterialPage(
                  key: ValueKey(e.config.name),
                  child: e.builder(e.config.from(e.config.path)),
                ),
              )
              .toList(),
        );
      },
    );
  }

  @override
  Future<bool> popRoute() async {
    bloc.pop();
    return true;
  }

  @override
  void removeListener(VoidCallback listener) {}

  @override
  Future<void> setNewRoutePath(configuration) {
    throw UnimplementedError();
  }
}
/*
TODO: route information parser
class AppRouteInformation {

}

class AppRouteInformationParser extends RouteInformationParser<dynamic> {
  @override
  Future<dynamic> parseRouteInformation(
      RouteInformation routeInformation) async {
    return routeInformation;
  }

  @override
  RouteInformation restoreRouteInformation(configuration) {
    return RouteInformation(location: configuration.location);
  }
}

 */