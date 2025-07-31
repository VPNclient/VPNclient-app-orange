import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn_client/l10n/app_localizations.dart';


class LocationWidget extends StatelessWidget {
  final String title;
  final Map<String, dynamic>? selectedServer;
  final VoidCallback? onTap;

  const LocationWidget({
    super.key,
    required this.title,
    this.selectedServer,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String locationName = selectedServer?['text'] ?? '...'; final String iconPath = selectedServer?['icon'] ?? 'assets/images/flags/auto.svg';

    return GestureDetector( onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 14),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Text(
                  locationName,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                const SizedBox(height: 20),
                SvgPicture.asset(iconPath, width: 48, height: 48),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).your_location,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Text(
                locationName,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.primary,
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
