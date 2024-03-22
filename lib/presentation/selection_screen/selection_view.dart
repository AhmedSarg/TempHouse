import 'package:flutter/material.dart';

import 'view/widgets/selection_body.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SelectionBody());
  }
}
