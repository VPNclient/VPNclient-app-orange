import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vpn_client/theme/app_colors.dart';

class ServerListItem extends StatelessWidget {
  final String? icon;
  final String text;
  final String ping;
  final bool isActive;
  final VoidCallback onTap;

  const ServerListItem({
    super.key,
    this.icon,
    required this.text,
    required this.ping,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    String pingImage = 'assets/images/ping_status_1.png';
    Color pingColor = AppColors.speedExcellent;
    
    if (ping.isNotEmpty) {
      final int? pingValue = int.tryParse(ping);
      if (pingValue != null) {
        if (pingValue > 200) {
          pingImage = 'assets/images/ping_status_3.png';
          pingColor = AppColors.speedPoor;
        } else if (pingValue > 100) {
          pingImage = 'assets/images/ping_status_2.png';
          pingColor = AppColors.speedFair;
        } else if (pingValue > 50) {
          pingColor = AppColors.speedGood;
        }
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isActive 
              ? (isDark ? AppColors.darkCardBackground : AppColors.lightCardBackground)
              : (isDark ? AppColors.darkSurfaceLight : AppColors.lightSurfaceLight),
          borderRadius: BorderRadius.circular(10),
          border: isActive 
              ? Border.all(color: AppColors.primary, width: 2)
              : null,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (icon != null)
                    SvgPicture.asset(icon!, width: 52, height: 52),
                  if (icon == null) const SizedBox(width: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: 52,
                      child: Text(
                        text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                          color: isActive 
                              ? AppColors.primary
                              : (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    int.tryParse(ping) != null ? '$ping ms' : ping,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14, 
                      color: isActive 
                          ? AppColors.primary
                          : pingColor,
                    ),
                  ),
                  if (ping.isNotEmpty)
                    Image.asset(pingImage, width: 52, height: 52),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
