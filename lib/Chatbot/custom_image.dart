import 'package:flutter/material.dart';

/// An image widget that can display both Online image and local image
class CustomImage extends StatefulWidget {
  final String imageUrlOrPath; // URL or file path
  final VoidCallback? onComplete;

  const CustomImage({
    Key? key,
    /** URL or absolute path */
    required this.imageUrlOrPath,
    this.onComplete,
  }) : super(key: key);

  @override
  _CustomImageState createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  bool _imageLoaded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showFullImage(context, widget.imageUrlOrPath),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width *
              0.8, // 80% of the screen width
          maxHeight: MediaQuery.of(context).size.height *
              0.6, // 60% of the screen height
        ),
        child: _buildImage(widget.imageUrlOrPath),
      ),
    );
  }

  Widget _buildImage(imageUrlOrPath) {
    if (imageUrlOrPath.startsWith('http')) {
      // It's a network image
      return Image.network(
        imageUrlOrPath,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            if (!_imageLoaded) {
              if (widget.onComplete != null) widget.onComplete!();
              _imageLoaded = true;
            }
            return child;
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) {
          return Center(
            child: Icon(Icons.error),
          );
        },
      );
    } else if (imageUrlOrPath.startsWith('assets/images/')) {
      // It's a local file image
      // TODO: find a way to call onComplete when finish
      return _buildAssetImage(imageUrlOrPath);
    } else {
      // Fallback or error handling
      return Center(
        child: Icon(Icons.error),
      );
    }
  }

  void _showFullImage(BuildContext context, String imageUrlOrPath) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors
          .black54, // Optional: You can set a semi-transparent barrier color here
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: InteractiveViewer(
            panEnabled: false,
            boundaryMargin: EdgeInsets.all(double.infinity),
            minScale: 0.1,
            maxScale: 4.0,
            clipBehavior: Clip.none,
            child: _buildImage(imageUrlOrPath),
          ),
        );
      },
    );
  }

  Widget _buildAssetImage(String assetPath) {
    print('Loading asset image: $assetPath');
    Image image = Image.asset(
      assetPath,
      fit: BoxFit.cover,
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        return Center(
          child: Icon(Icons.error),
        );
      },
    );

    // Adding a listener to the ImageStream
    final ImageStream stream = image.image.resolve(ImageConfiguration.empty);
    stream.addListener(
        ImageStreamListener((ImageInfo info, bool synchronousCall) {
      if (!_imageLoaded) {
        if (widget.onComplete != null) widget.onComplete!();
        _imageLoaded = true;
      }
    }));

    return image;
  }
}
