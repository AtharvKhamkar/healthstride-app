import 'package:flutter/material.dart';


class AppColors {
  AppColors._();


  // Brand Colors
  static const Color primary = Color(0xFF2BAA81);
  static const Color primaryLight = Color(0xFF5CC4A4);
  static const Color primaryDark = Color(0xFF1F8A66);
  static const Color secondary = Color(0xFF2D3436);
  static const Color secondaryLight = Color(0xFF4A4E50);


  // Background
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundSecondary = Color(0xFFF3F5FB);
  static const Color scaffoldBackground = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF0F0F0);


  // Text
  static const Color textPrimary = Color(0xFF1A1E25);
  static const Color textSecondary = Color(0xFF7D7F88);
  static const Color textTertiary = Color(0xFFA8ABB2);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnSecondary = Color(0xFFFFFFFF);


  // Border
  static const Color border = Color(0xFFE8E8E8);
  static const Color chipBorder = Color(0xFFCACFD3);
  static const Color borderLight = Color(0xFFF0F0F0);
  static const Color borderDark = Color(0xFFD0D0D0);
  static const Color divider = Color(0xFFE8E8E8);


  // Input Field
  static const Color inputFill = Color(0xFFF4F8FB);
  static const Color inputBorder = Color(0xFFE0E8EF);
  static const Color inputPlaceholder = Color(0xFF909BA1);


  // OR Divider
  static const Color orDividerLine = Color(0xFFE8F6EE);
  static const Color orChipBackground = Color(0xFFF0FFF7);
  static const Color orChipText = Color(0xFF91DAAE);


  // Social Buttons
  static const Color appleButton = Color(0xFF222831);
  static const Color googleButtonBorder = Color(0xFFE2E8F0);
  static const Color googleButtonText = Color(0xFF475569);


  // Status Colors
  static const Color error = Color(0xFFE74C3C);
  static const Color errorLight = Color(0xFFFDEDED);
  static const Color success = Color(0xFF2ECC71);
  static const Color successLight = Color(0xFFE8F8F0);
  static const Color warning = Color(0xFFF39C12);
  static const Color warningLight = Color(0xFFFEF5E7);
  static const Color info = Color(0xFF3498DB);
  static const Color infoLight = Color(0xFFEBF5FB);


  // Order Status (Figma badge colors — solid fill + white text)
  static const Color statusPending = Color(0xFFFFC107);
  static const Color statusOnging = Color(0xFFFD7E14);
  static const Color statusConfirmed = Color(0xFF00C8E2);
  static const Color statusOrdered = Color(0xFF822BAA);
  static const Color statusActive = Color(0xFF2BAA81);
  static const Color statusCompleted = Color(0xFF2BAA81);
  static const Color statusCancelled = Color(0xFFE74C3C);
  static const Color statusPickup = Color(0xFF9B59B6);


  // Rating
  static const Color ratingStar = Color(0xFFFCD53F);
  static const Color ratingStarEmpty = Color(0xFFE0E0E0);


  // Shimmer
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);


  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryDark],
  );


  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Color(0xCC000000)],
  );


  // Security Deposit Gradient
  static const LinearGradient securityDepositGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF003824), Color(0xFF2BAA81)],
  );


  // Shadow
  static const Color shadow = Color(0x1A000000);
  static const Color shadowLight = Color(0x0D000000);


  // Overlay
  static const Color overlay = Color(0x80000000);
  static const Color overlayLight = Color(0x40000000);


  // Wishlist
  static const Color wishlistRed = Color(0xFFFF4757);


  // WhatsApp
  static const Color whatsapp = Color(0xFF25D366);


  // Card & Container
  static const Color cardBorder = Color(0xFFE3E3E7);
  static const Color surfaceLight = Color(0xFFFCFCFC);
  static const Color scaffoldLight = Color(0xFFFDFDFD);


  // Search
  static const Color searchBorder = Color(0xFFD9D9D9);
  static const Color searchBarFill = Color(0xFFF1F5F8);


  // Text Variants
  static const Color textDark = Color(0xFF393E48);
  static const Color iconDark = Color(0xFF292D32);


  // Toggle / Nav
  static const Color toggleInactive = Color(0xFFD5D5D5);
  static const Color navBorder = Color(0xFFECEEF0);


  // Category
  static const Color categoryYacht = Color(0xFF0984E3);
  static const Color categoryWaterSports = Color(0xFF00B894);


  // Misc UI
  static const Color destructive = Color(0xFFDF4442);
  static const Color expandedPanelBg = Color(0xFFF1F0F5);
  static const Color ratingBadgeBg = Color(0xFFF2F2F2);
  static const Color priceCardDaily = Color(0xFF4A90D9);
  static const Color priceCardMonthly = Color(0xFF9B59B6);
  static const Color ratingStarInactive = Color(0xFFBABABA);
}



