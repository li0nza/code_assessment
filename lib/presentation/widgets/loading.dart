import 'package:flutter/material.dart';

/// Basic loading widget that shows a [CircularProgressIndicator] in the center of the page,
/// with a `message`
class GenericLoader extends StatelessWidget {
  const GenericLoader({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(message),
          ),
        ],
      ),
    );
  }
}