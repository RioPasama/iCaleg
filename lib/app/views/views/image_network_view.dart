import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';

/// ImageNetworkView
///
/// This class is a Widget that displays an image from a network URL.

/// Properties
///
/// * `url`: The URL of the image to be displayed.
/// * `height`: The height of the image.
/// * `width`: The width of the image.
/// * `margin`: The margin around the image.
/// * `padding`: The padding around the image.
/// * `alignment`: The alignment of the image.
/// * `child`: A widget to be placed on top of the image.
/// * `decoration`: The decoration of the image.
/// * `fit`: The fit of the image.

/// Usage
///
/// To use this class, first you need to import it. Then, you can use it to display an image from a network URL like this:
///
///
/// ImageNetworkView(
///   url: 'https://picsum.photos/200/300',
///   height: 100,
///   width: 150,
///   margin: EdgeInsets.all(8),
///   padding: EdgeInsets.all(4),
///   alignment: Alignment.center,
///   child: Text('This is an image'),
///   decoration: BoxDecoration(border: Border.all(color: Colors.black)),
///   fit: BoxFit.cover,
/// );
///
/// This code will display an image with the URL "https://picsum.photos/200/300" with the height of 100 and the width of 150. The image will be centered and have a margin of 8 pixels around it. The image will also have a border of 1 pixel in black.

class ImageNetworkView extends GetView {
  final String url;
  final double? height;
  final double? width;
  final Widget? child;
  final BoxDecoration? decoration;
  final BoxFit? fit;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  const ImageNetworkView({
    required this.url,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.alignment,
    this.child,
    this.decoration,
    this.fit = BoxFit.cover,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) {
        return Container(
          height: height,
          width: width,
          margin: margin,
          padding: padding,
          alignment: alignment,
          decoration: decoration?.copyWith(
                image: DecorationImage(image: imageProvider, fit: fit),
              ) ??
              BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: fit),
              ),
          child: child,
        );
      },
      placeholder: (context, url) {
        return Container(
          height: height,
          width: width,
          margin: margin,
          padding: padding,
          alignment: alignment,
          decoration: decoration?.copyWith(color: colorGray),
          child: child,
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          height: height,
          width: width,
          margin: margin,
          padding: padding,
          alignment: alignment,
          decoration: decoration?.copyWith(color: colorGray),
          child: child,
        );
      },
    );
  }
}
