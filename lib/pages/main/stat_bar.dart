import 'package:flutter/material.dart';
import 'package:vpn_client/design/dimensions.dart';
import 'package:vpn_client/theme/app_colors.dart';

import '../../design/custom_icons.dart';

class StatBar extends StatefulWidget {
  const StatBar({super.key});

  @override
  State<StatBar> createState() => StatBarState();
}

class StatBarState extends State<StatBar> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: EdgeInsets.only(top: 37),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem(CustomIcons.download, '0 Mb/s', context, isDark),
          _buildStatItem(CustomIcons.upload, '0 Mb/s', context, isDark),
          _buildStatItem(CustomIcons.ping, '0 ms', context, isDark),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String text, BuildContext context, bool isDark) {
    // Определяем цвет в зависимости от типа статистики
    Color getIconColor() {
      if (icon == CustomIcons.download) {
        return AppColors.downloadActive;
      } else if (icon == CustomIcons.upload) {
        return AppColors.uploadActive;
      } else if (icon == CustomIcons.ping) {
        return AppColors.pingActive;
      }
      return AppColors.primary;
    }

    return Container(
      width: 100,
      height: 75,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: isDark 
                ? AppColors.darkCardShadow.withOpacity(0.3)
                : AppColors.lightCardShadow.withOpacity(0.3),
            offset: Offset(0.0, 1.0),
            blurRadius: 32.0,
          ),
        ],
      ),
      child: FloatingActionButton(
        elevation: elevation0,
        onPressed: () {},
        backgroundColor: isDark 
            ? AppColors.darkCardBackground 
            : AppColors.lightCardBackground,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: getIconColor(),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Icon(
                icon,
                size: 20,
                color: isDark 
                    ? AppColors.darkTextPrimary 
                    : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark 
                    ? AppColors.darkTextPrimary 
                    : AppColors.lightTextPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
