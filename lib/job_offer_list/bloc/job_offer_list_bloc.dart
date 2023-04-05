import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'job_offer_list_event.dart';
part 'job_offer_list_state.dart';

class JobOfferListBloc extends Bloc<JobOfferListEvent, JobOfferListState> {
  JobOfferListBloc() : super(JobOfferListInitial()) {
    on<JobOfferListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
