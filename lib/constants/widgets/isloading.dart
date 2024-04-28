import 'package:flutter/material.dart';

class IsLoadingWidget extends StatelessWidget {
  const IsLoadingWidget({
    super.key,
    required this.isLoading,
    required this.child,
  });
  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading) ...[
          Container(
            color: Colors.black.withOpacity(.7),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        ]
      ],
    );
  }
}
