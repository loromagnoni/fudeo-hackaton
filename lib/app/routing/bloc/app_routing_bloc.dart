import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import '../../../job_offer_list/view/job_offer_list_page.dart';

part 'app_routing_event.dart';
part 'app_routing_state.dart';

class AppRoutingBloc extends Bloc<AppRoutingEvent, AppRoutingState> {
  AppRoutingBloc() : super(AppRoutingInitial([])) {
    on<AppRoutingEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AppRoutingPop>(_handleAppRoutingPop);
  }

  void pop() {
    add(AppRoutingPop());
  }

  void _handleAppRoutingPop(AppRoutingPop event, Emitter<AppRoutingState> emit) {
    if (state.pages.length == 1) {
      return;
    }
    final newPages = state.pages.take(state.pages.length - 1).toList();
    emit(AppRoutingInitial(newPages));
  }
}
