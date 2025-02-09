import 'package:flutter/material.dart';

class ImageViewerWidget extends StatelessWidget {
  final String url;
  const ImageViewerWidget({super.key,required this.url});

  @override
  Widget build(Object context) {
    return Image.network(
      url,
      fit: BoxFit.contain,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        print('Error loading imageeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee: $error');
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 50,
              ),
              SizedBox(height: 10),
              Text(
                'Failed to load image',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }
}
