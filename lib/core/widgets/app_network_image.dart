import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.placeholderAssetImage,
    this.errorAssetImage,
    this.height,
    this.width,
    this.fit,
    this.borderRadius,
  });

  final String imageUrl;
  final String? placeholderAssetImage;
  final String? errorAssetImage;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final imageWidget = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      alignment: Alignment.center,
      fit: fit ?? BoxFit.cover,
      placeholder: (context, url) {
        if (placeholderAssetImage != null &&
            placeholderAssetImage!.isNotEmpty) {
          return Image.asset(
            placeholderAssetImage!,
            width: width,
            height: height,
            alignment: Alignment.center,
            fit: fit ?? BoxFit.cover,
          );
        }
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade200,
          highlightColor: Colors.grey.shade50,
          child: Container(
            width: width,
            height: height,
            color: Colors.white,
          ),
        );
      },
      errorWidget: (context, url, error) {
        if (errorAssetImage != null && errorAssetImage!.isNotEmpty) {
          return Image.asset(
            errorAssetImage!,
            width: width,
            height: height,
            alignment: Alignment.center,
            fit: fit ?? BoxFit.cover,
          );
        }
        return Container(
          width: width,
          height: height,
          color: Colors.grey.shade100,
          child: Icon(
            Icons.broken_image_outlined,
            color: Colors.grey.shade400,
            size: 28,
          ),
        );
      },
    );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }
    return imageWidget;
  }
}
