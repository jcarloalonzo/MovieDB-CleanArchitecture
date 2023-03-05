import 'package:flutter/material.dart';

import '../../../../../domain/enums.dart';

class TrendingTimeWindow extends StatelessWidget {
  const TrendingTimeWindow(
      {super.key, required this.timeWindow, required this.onChanged});

  final TimeWindow timeWindow;
  final void Function(TimeWindow) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          const Text(
            'TRENDING',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Material(
              color: const Color(0xfff0f0f0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownButton<TimeWindow>(
                  value: timeWindow,
                  underline: const SizedBox.shrink(),
                  // *ISDENSE QUITA EL PADDING
                  isDense: true,

                  items: const [
                    DropdownMenuItem(
                      value: TimeWindow.day,
                      child: Text('Last 24h'),
                    ),
                    DropdownMenuItem(
                      value: TimeWindow.week,
                      child: Text('Last week'),
                    ),
                  ],
                  onChanged: (mTimeWindow) {
                    if (mTimeWindow != null && timeWindow != mTimeWindow) {
                      onChanged(timeWindow);
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
