import 'package:Monexo/utils/colours_util.dart';
import 'package:Monexo/utils/images.dart';
import 'package:flutter/material.dart';

class MarketNoDataWidget extends StatelessWidget {
  final bool isFilter;

  const MarketNoDataWidget({
    this.isFilter = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40),
        Image(
          image: AssetImage(LocalImages.noData),
          width: 150,
          height: 150,
        ),
        SizedBox(height: 10),
        Text(
          "No Results found",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: ColorsUtil.blackish.withOpacity(0.6)),
        ),
        SizedBox(height: 10),
        if (isFilter)
          Text(
            "Please try again using a different filter values",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ColorsUtil.dividerColor.withOpacity(0.6),
            ),
          ),
      ],
    );
  }
}
