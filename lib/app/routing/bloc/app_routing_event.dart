part of 'app_routing_bloc.dart';

@immutable
abstract class AppRoutingEvent {}

class AppRoutingChange extends AppRoutingEvent {

}

class AppRoutingPop extends AppRoutingEvent {

}