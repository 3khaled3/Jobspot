import 'package:flutter/material.dart';

import 'chip_widget.dart';

/// =====================================================
/// QUICK FILTER CHIPS
/// =====================================================
class QuickFilterChips extends StatelessWidget {
  final String selectedTimeFrame;
  final String? selectedArrangement;
  final ValueChanged<String> onTimeFrameChanged;
  final ValueChanged<String?> onArrangementChanged;

  const QuickFilterChips({
    super.key,
    required this.selectedTimeFrame,
    required this.selectedArrangement,
    required this.onTimeFrameChanged,
    required this.onArrangementChanged,
  });

  static const _timeFrames = {
    '24h': 'Today',
    '7d': 'This week',
    '30d': 'This month',
  };
  static const _arrangements = ['Remote', 'Hybrid', 'Onsite'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          ..._timeFrames.entries.map(
            (e) => ChipWidget(
              label: e.value,
              selected: selectedTimeFrame == e.key,
              onTap: () => onTimeFrameChanged(e.key),
            ),
          ),
          Container(
            width: 1,
            height: 20,
            color: Colors.grey.shade200,
            margin: const EdgeInsets.symmetric(horizontal: 8),
          ),
          ..._arrangements.map(
            (a) => ChipWidget(
              label: a,
              selected: selectedArrangement == a,
              onTap: () =>
                  onArrangementChanged(selectedArrangement == a ? null : a),
            ),
          ),
        ],
      ),
    );
  }
}
