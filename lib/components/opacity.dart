import 'package:flutter/material.dart';

import '../constants.dart';

class OpacityWidget extends StatelessWidget {
  final bool isLoading;
  const OpacityWidget({
    Key? key,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isLoading ? 0.8 : 0.0,
      child: const Center(
          child: CircularProgressIndicator(
        color: kPrimaryColor,
      )),
    );
  }
}
