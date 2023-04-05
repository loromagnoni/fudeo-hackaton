import 'package:flutter/material.dart';
import 'package:fudeo_hackaton/job_list/job_list.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: JobListPage(),
    );
  }
}
