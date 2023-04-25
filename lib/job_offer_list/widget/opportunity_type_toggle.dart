import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/bloc/job_offer_list_bloc.dart';
import 'package:fudeo_hackaton/theme/colors.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';

class OpportunityTypeToggle extends StatelessWidget {
  const OpportunityTypeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey, width: 2),
          borderRadius: BorderRadius.circular(99)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<JobOfferListBloc, JobOfferListState>(
          bloc: context.read<JobOfferListBloc>(),
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ToggleItem(
                  label: 'Assunzioni',
                  selectedType: state.selectedType,
                  activeWhen: OpportunityType.jobOffer,
                ),
                ToggleItem(
                  label: 'Freelance',
                  selectedType: state.selectedType,
                  activeWhen: OpportunityType.freelanceProject,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class ToggleItem extends StatelessWidget {
  const ToggleItem({
    super.key,
    required OpportunityType selectedType,
    required OpportunityType activeWhen,
    required String label,
  })  : _activeWhen = activeWhen,
        _label = label,
        _selectedType = selectedType;

  final OpportunityType _selectedType;
  final OpportunityType _activeWhen;
  final String _label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => BlocProvider.of<JobOfferListBloc>(context)
          .add(OpportunityToggleTap()),
      child: Text(
        _label,
        style: _selectedType == _activeWhen
            ? AppFonts.jobListToggleActive
            : AppFonts.jobListToggle,
      ),
    );
  }
}