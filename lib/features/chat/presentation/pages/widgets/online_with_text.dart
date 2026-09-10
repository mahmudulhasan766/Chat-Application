import 'package:flutter/material.dart';

import '../../../../../core/constents/app_colors.dart';

class OnlineWithText extends StatelessWidget {
  const OnlineWithText({super.key});

  @override
  Widget build(BuildContext context) {
    return     Row(
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
          '8 online',
          style: TextStyle(fontSize: 12, color: Color(0xff56816e)),
        ),
      ],
    );
  }
}
