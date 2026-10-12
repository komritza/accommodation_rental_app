import 'package:accommodation_core/accommodation_core.dart';
import 'package:accommodation_ui/accommodation_ui.dart';
import 'package:flutter/material.dart';

class ListingDetailImageCarousel extends StatefulWidget {
  const ListingDetailImageCarousel({super.key, required this.listing});

  final Listing listing;

  @override
  State<ListingDetailImageCarousel> createState() =>
      _ListingDetailImageCarouselState();
}

class _ListingDetailImageCarouselState
    extends State<ListingDetailImageCarousel> {
  var _page = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final listing = widget.listing;
    final images = listing.images;

    if (images.isEmpty) {
      return AppCoverImage(
        url: null,
        semanticLabel: listing.title,
        propertyTypeLabel: '',
      );
    }

    return Column(
      children: [
        ClipRRect(
          borderRadius: AppRadii.mdBorder,
          child: AspectRatio(
            aspectRatio: AppImageTokens.coverAspectRatio,
            child: PageView.builder(
              itemCount: images.length,
              onPageChanged: (index) => setState(() => _page = index),
              itemBuilder: (context, index) => AppCoverImage(
                url: images[index],
                semanticLabel: l10n.listingDetailPhotoLabel(
                  listing.title,
                  index + 1,
                  images.length,
                ),
                propertyTypeLabel: '',
              ),
            ),
          ),
        ),
        if (images.length > 1) ...[
          const SizedBox(height: AppSpacing.xs),
          ExcludeSemantics(
            child: _PageIndicator(count: images.length, current: _page),
          ),
        ],
      ],
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({required this.count, required this.current});

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    final colors = context.accommodationColors;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var index = 0; index < count; index++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs / 2),
            width: AppSpacing.xs,
            height: AppSpacing.xs,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == current
                  ? colors.textDefault
                  : colors.textMuted.withValues(alpha: 0.4),
            ),
          ),
      ],
    );
  }
}
