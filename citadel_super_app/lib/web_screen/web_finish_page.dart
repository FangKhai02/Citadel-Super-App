import 'package:flutter/material.dart';

class WebFinishPage extends StatelessWidget {
  final String message;
  const WebFinishPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Text(message
          // 'The trust deed has been signed. You can now close this tab. Thank you!'
          ),
    );
  }
}
