import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NoResultsMessage extends StatelessWidget {
  const NoResultsMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('No results');
  }
}
