import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CreatedDate extends StatelessWidget {
  const CreatedDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(DateTime(2021).toString());
  }
}
