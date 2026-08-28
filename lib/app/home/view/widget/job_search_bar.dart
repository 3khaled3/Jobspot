import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jobs_fantastic/core/const/app_colors.dart';
import 'package:jobs_fantastic/core/const/app_text_styles.dart';
import 'package:jobs_fantastic/core/extension/sized_box_extension.dart';

import 'filter_button.dart';

/// =====================================================
/// SEARCH BAR (debounced)
/// =====================================================
class JobSearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback onFilterTap;
  final int activeFilterCount;

  const JobSearchBar({
    super.key,
    required this.onChanged,
    required this.onFilterTap,
    this.activeFilterCount = 0,
  });

  @override
  State<JobSearchBar> createState() => JobSearchBarState();
}

class JobSearchBarState extends State<JobSearchBar> {
  final _controller = TextEditingController();
  Timer? _debounce;

  void _onTextChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 450), () {
      widget.onChanged(value);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.search, size: 20, color: Colors.grey.shade500),
                8.wSpace,
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onChanged: _onTextChanged,
                    style: AppTextStyles.regular14,
                    decoration: InputDecoration(
                      hintText: 'Job title, company, skill...',
                      hintStyle: AppTextStyles.regular14.copyWith(
                        color: Colors.grey.shade400,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
                if (_controller.text.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      _controller.clear();
                      widget.onChanged('');
                    },
                    child: Icon(
                      Icons.close,
                      size: 18,
                      color: Colors.grey.shade400,
                    ),
                  ),
              ],
            ),
          ),
        ),
        10.wSpace,
        FilterButton(
          count: widget.activeFilterCount,
          onTap: widget.onFilterTap,
        ),
      ],
    );
  }
}
