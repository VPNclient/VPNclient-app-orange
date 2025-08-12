import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn_client/localization_service.dart';
import 'package:vpn_client/theme/app_colors.dart';

class LocationWidget extends StatelessWidget {
  final Map<String, dynamic>? selectedServer;

  const LocationWidget({super.key, this.selectedServer});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final String locationName = selectedServer?['text'] ?? '...';
    final String iconPath =
        selectedServer?['icon'] ?? 'assets/images/flags/auto.svg';

    return Container(
      margin: const EdgeInsets.all(30),
      padding: const EdgeInsets.only(left: 14),
      decoration: BoxDecoration(
        color: isDark 
            ? AppColors.darkCardBackground 
            : AppColors.lightCardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? AppColors.darkCardShadow.withOpacity(0.2)
                : AppColors.lightCardShadow.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocalizationService.to('your_location'),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: isDark 
                      ? AppColors.darkTextSecondary 
                      : AppColors.lightTextSecondary,
                ),
              ),
              Text(
                locationName,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: isDark 
                      ? AppColors.darkTextPrimary 
                      : AppColors.lightTextPrimary,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              SizedBox(height: 20),
              SvgPicture.asset(iconPath, width: 48, height: 48),
            ],
          ),
        ],
      ),
    );
  }
}
