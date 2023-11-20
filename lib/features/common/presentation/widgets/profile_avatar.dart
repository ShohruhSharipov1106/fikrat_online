import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fikrat_online/assets/colors/colors.dart';
import 'package:fikrat_online/assets/constants/icons.dart';

class ProfileAvatar extends StatelessWidget {
  final String imagePicture;
  final double height;
  final double width;
  final EdgeInsets? margin;
  final double borderRadius;
  final Color borderColor;
  final EdgeInsets? padding;
  final Color? color;
  final Color? backgroudColor;
  final String? defaultIcon;
  final Color? errorFillColor;
  final Color? iconColor;

  const ProfileAvatar(
      {required this.imagePicture,
      this.height = 40,
      this.margin,
      this.width = 40,
      this.borderRadius = 150,
      this.borderColor = whiteSmoke,
      this.padding,
      this.color,
      this.defaultIcon,
      this.errorFillColor,
      this.iconColor,
      this.backgroudColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imagePicture.contains("http") || imagePicture.isEmpty) {
      return CachedNetworkImage(
        imageUrl: imagePicture,
        fit: BoxFit.cover,
        memCacheHeight: height.toInt(),
        memCacheWidth: width.toInt(),
        cacheKey: imagePicture,
        maxHeightDiskCache: height.toInt(),
        maxWidthDiskCache: width.toInt(),
        errorWidget: (context, url, error) {
          return Container(
            height: height,
            width: width,
            margin: margin,
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: borderColor, width: 1),
              color: errorFillColor ?? seaMist,
            ),
            child: SvgPicture.asset(defaultIcon ?? AppIcons.user),
          );
        },
        imageBuilder: (context, imageProvider) {
          return Container(
            height: height,
            width: width,
            margin: margin,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: borderColor, width: 1),
              color: backgroudColor ?? dark.withOpacity(.5),
            ),
            child: imagePicture.contains(".svg")
                ? SvgPicture.network(imagePicture)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: Image.network(
                      imagePicture,
                      fit: BoxFit.cover,
                    ),
                  ),
          );
        },
        placeholder: (context, url) {
          return Container(
            height: height,
            width: width,
            margin: margin,
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: borderColor, width: 1),
              color: errorFillColor ?? seaMist,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: SvgPicture.asset(defaultIcon ?? AppIcons.user),
            ),
          );
        },
      );
    } else {
      return Container(
        height: height,
        width: width,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor, width: 1),
          color: color ?? grey,
        ),
        child: SvgPicture.asset(
          defaultIcon ?? imagePicture,
          color: iconColor,
        ),
      );
    }
  }
}
