import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fikrat_online/assets/constants/icons.dart';

class StarRatingWidget extends StatelessWidget {
  final double rating;
  const StarRatingWidget({required this.rating, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (rating > 4.5) ...{
          SvgPicture.asset(AppIcons.fiveStar),
        } else if (rating > 4) ...{
          SvgPicture.asset(AppIcons.fourHalfStar),
        } else if (rating > 3.5) ...{
          SvgPicture.asset(AppIcons.fourStar),
        } else if (rating > 3) ...{
          SvgPicture.asset(AppIcons.threeHalfStar),
        } else if (rating > 2.5) ...{
          SvgPicture.asset(AppIcons.threeStar),
        } else if (rating > 2) ...{
          SvgPicture.asset(AppIcons.twoHalfStar),
        } else if (rating > 1.5) ...{
          SvgPicture.asset(AppIcons.twoStar),
        } else if (rating > 1) ...{
          SvgPicture.asset(AppIcons.oneHalfStar),
        } else if (rating > 0.5) ...{
          SvgPicture.asset(AppIcons.oneStar),
        } else if (rating > 0) ...{
          SvgPicture.asset(AppIcons.zeroHalfStar),
        } else ...{
          SvgPicture.asset(AppIcons.zeroStar),
        },
        const SizedBox(width: 10),
        Text(
          "$rating",
          style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 12),
        ),
      ],
    );
  }
}
