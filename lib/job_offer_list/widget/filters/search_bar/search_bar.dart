import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudeo_hackaton/job_offer_list/bloc/job_offer_list_bloc.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(Icons.lens),
          Expanded(
            child: TextField(
              onChanged: (value) =>
                  BlocProvider.of<JobOfferListBloc>(context).add(
                SearchTextChanged(value),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Cerca',
              ),
            ),
          )
        ],
      ),
    );
  }
}
