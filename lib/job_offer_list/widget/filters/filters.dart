import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fudeo_hackaton/job_offer_list/widget/filters/search_bar/search_bar.dart';

class Filters extends StatelessWidget {
  const Filters({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: SearchBar()),
        IconButton(onPressed: null, icon: Icon(Icons.filter_list_off))
      ],
    );
  }
}
