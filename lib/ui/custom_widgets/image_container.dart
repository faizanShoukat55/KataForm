
import 'package:flutter/material.dart';

import '../../core/constants/images_path.dart';

class ImageContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double radius;
  final String assets; /// This is for  local Asset
  final String? url;/// This one is for Network Image,
  final BoxFit fit;
//  final

  // ignore: use_key_in_widget_constructors
  const ImageContainer({this.height, this.width, this.assets = ImagePath.loaderImage,
    this.radius = 0,
    this.url,
    this.fit = BoxFit.contain,
  });
  @override
  Widget build(BuildContext context) {
    return
      url == null || url!.isEmpty?
      Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(radius),
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            image: DecorationImage(
              image: AssetImage(assets),
              fit: fit,
            )
        ),
      ) : ClipRRect(
        // borderRadius: BorderRadius.circular(radius),
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        child: FadeInImage(
          width: width,
          height: height,
          image: NetworkImage(url!),
          placeholder: AssetImage(assets),
          fit: BoxFit.cover,
        ),
      );
  }
}
