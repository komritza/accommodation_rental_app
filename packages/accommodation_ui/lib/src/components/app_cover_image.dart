import 'package:flutter/material.dart';

import '../design_system/design_system.dart';

class AppCoverImage extends StatelessWidget {
  const AppCoverImage({
    super.key,
    required this.url,
    required this.semanticLabel,
    this.aspectRatio = AppImageTokens.coverAspectRatio,
  });

  final String? url;
  final String semanticLabel;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    final colors = context.accommodationColors;
    final imageUrl = url;

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: ClipRRect(
        borderRadius: AppRadii.mdBorder,
        child: ColoredBox(
          color: colors.surfaceSecondary,
          child: imageUrl == null
              ? _Placeholder(semanticLabel: semanticLabel)
              : LayoutBuilder(
                  builder: (context, constraints) {
                    final pixelRatio = MediaQuery.devicePixelRatioOf(context);

                    return Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      cacheWidth: (constraints.maxWidth * pixelRatio).round(),
                      semanticLabel: semanticLabel,
                      errorBuilder: (context, error, stackTrace) =>
                          _Placeholder(semanticLabel: semanticLabel),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.semanticLabel});

  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.image_outlined,
        size: AppIconSizes.lg,
        color: context.accommodationColors.textMuted,
        semanticLabel: semanticLabel,
      ),
    );
  }
}
