import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/styles.dart';
class SummaryWidget extends StatelessWidget {
  const SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.greyColor, // Color of the border
          width: 1, // Width of the border
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Summary',
            style: TextStyles.font18BlackBold,
          ),
          const SizedBox(height: 16.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Price'),
              Text('\$87.10'),
            ],
          ),
          const SizedBox(height: 8.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Shipping'),
              Text('\$2'),
            ],
          ),
          const Divider(),
          const SizedBox(height: 8.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Total Payment',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '\$89.10',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary, // Text color
              ),
              onPressed: () {
                // TODO: Implement see details action
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('See details'),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


