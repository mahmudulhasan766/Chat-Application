import 'package:flutter/material.dart';

import '../../../../../core/constents/app_colors.dart';

class TextWithIndicator extends StatelessWidget {
  const TextWithIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45),
            color: AppColors.kGreen,
          ),
        ),
        SizedBox(width: 4),
        Text(
          'No password, no signup',
          style: TextStyle(fontSize: 12, color: Color(0xff56816e)),
        ),
      ],
    );
  }
}
