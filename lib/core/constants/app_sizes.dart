import 'package:flutter/material.dart';

class AppSizes {
  AppSizes._();

  // Spacing
  static const double xxs = 2.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double base = 16.0;
  static const double lg = 20.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
  static const double xxxl = 48.0;

  // Padding
  static const EdgeInsets paddingAllXxs = EdgeInsets.all(xxs);
  static const EdgeInsets paddingAllXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingAllSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingAllMd = EdgeInsets.all(md);
  static const EdgeInsets paddingAllBase = EdgeInsets.all(base);
  static const EdgeInsets paddingAllLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingAllXl = EdgeInsets.all(xl);

  static const EdgeInsets paddingHorizontalXxs = EdgeInsets.symmetric(
    horizontal: xxs,
  );
  static const EdgeInsets paddingHorizontalBase = EdgeInsets.symmetric(
    horizontal: base,
  );
  static const EdgeInsets paddingHorizontalLg = EdgeInsets.symmetric(
    horizontal: lg,
  );
  static const EdgeInsets paddingHorizontalXl = EdgeInsets.symmetric(
    horizontal: xl,
  );

  static const EdgeInsets paddingVerticalXxs = EdgeInsets.symmetric(
    vertical: xxs,
  );
  static const EdgeInsets paddingVerticalSm = EdgeInsets.symmetric(
    vertical: sm,
  );
  static const EdgeInsets paddingVerticalBase = EdgeInsets.symmetric(
    vertical: base,
  );

  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: base,
    vertical: md,
  );

  // Border Radius
  static const double radiusXxs = 2.0;
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusBase = 16.0;
  static const double radiusLg = 20.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 100.0;

  static const BorderRadius borderRadiusXxs = BorderRadius.all(
    Radius.circular(radiusXxs),
  );
  static const BorderRadius borderRadiusXs = BorderRadius.all(
    Radius.circular(radiusXs),
  );
  static const BorderRadius borderRadiusSm = BorderRadius.all(
    Radius.circular(radiusSm),
  );
  static const BorderRadius borderRadiusMd = BorderRadius.all(
    Radius.circular(radiusMd),
  );
  static const BorderRadius borderRadiusBase = BorderRadius.all(
    Radius.circular(radiusBase),
  );
  static const BorderRadius borderRadiusLg = BorderRadius.all(
    Radius.circular(radiusLg),
  );
  static const BorderRadius borderRadiusXl = BorderRadius.all(
    Radius.circular(radiusXl),
  );
  static const BorderRadius borderRadiusFull = BorderRadius.all(
    Radius.circular(radiusFull),
  );

  // Icon Sizes
  static const double iconXs = 12.0;
  static const double iconSm = 16.0;
  static const double iconMd = 20.0;
  static const double iconBase = 24.0;
  static const double iconLg = 28.0;
  static const double iconXl = 32.0;
  static const double iconXxl = 48.0;

  // Button Heights
  static const double buttonHeightSm = 36.0;
  static const double buttonHeightMd = 44.0;
  static const double buttonHeightLg = 42.0;
  static const double buttonHeightXl = 56.0;

  // Input Heights
  static const double inputHeight = 42.0;
  static const double searchBarHeight = 48.0;

  // Input-specific radius (8px per Figma)
  static const double inputRadius = 8.0;
  static const BorderRadius inputBorderRadius = BorderRadius.all(
    Radius.circular(inputRadius),
  );

  // App Bar
  static const double appBarHeight = 56.0;

  // Bottom Nav
  static const double bottomNavHeight = 64.0;

  // Card
  static const double cardElevation = 2.0;
  static const double productCardHeight = 260.0;
  static const double productCardWidth = 200.0;

  // Image
  static const double avatarSm = 32.0;
  static const double avatarMd = 48.0;
  static const double avatarLg = 64.0;
  static const double avatarXl = 96.0;

  // Carousel
  static const double carouselHeight = 200.0;
  static const double bannerHeight = 160.0;

  // Bottom Sheet
  static const double bottomSheetRadius = 20.0;

  // Divider
  static const double dividerThickness = 1.0;

  // Gap helpers
  static const SizedBox gapH2 = SizedBox(height: xxs);
  static const SizedBox gapH4 = SizedBox(height: xs);
  static const SizedBox gapH6 = SizedBox(height: 6);
  static const SizedBox gapH8 = SizedBox(height: sm);
  static const SizedBox gapH12 = SizedBox(height: md);
  static const SizedBox gapH16 = SizedBox(height: base);
  static const SizedBox gapH20 = SizedBox(height: lg);
  static const SizedBox gapH24 = SizedBox(height: xl);
  static const SizedBox gapH32 = SizedBox(height: xxl);
  static const SizedBox gapH48 = SizedBox(height: xxxl);

  static const SizedBox gapW2 = SizedBox(width: xxs);
  static const SizedBox gapW4 = SizedBox(width: xs);
  static const SizedBox gapW6 = SizedBox(width: 6);
  static const SizedBox gapW8 = SizedBox(width: sm);
  static const SizedBox gapW12 = SizedBox(width: md);
  static const SizedBox gapW16 = SizedBox(width: base);
  static const SizedBox gapW20 = SizedBox(width: lg);
  static const SizedBox gapW24 = SizedBox(width: xl);
}
