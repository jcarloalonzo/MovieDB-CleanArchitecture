import 'package:flutter/material.dart';

import '../../../generated/assets.gen.dart';

class RequestFailed extends StatelessWidget {
  const RequestFailed({super.key, required this.onRetry, this.text});
  final VoidCallback onRetry;
  final String? text;
  //
  //
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(
          //   Assets.png.error404.path,
          //   fit: BoxFit.cover,
          //   width: 100,
          //   height: 100,
          // ),
          Expanded(child: Assets.png.error404.image()),
          Text(text ?? 'Request Failed'),
          MaterialButton(
            onPressed: onRetry,
            color: Colors.blue,
            child: const Text('Retry'),
          ),
          const SizedBox(height: 20),
          //
        ],
      ),
    );
  }
}
