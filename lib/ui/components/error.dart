import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const Error({
    Key? key,
  }) : super(key: key);

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.warning_rounded,
          color: Colors.red,
          size: 36.0,
        ),
        const SizedBox(height: 8.0),
        Text(
          'An error has occurred.',
          style: Theme.of(context).textTheme.caption,
        )
      ],
    );
  }
}
