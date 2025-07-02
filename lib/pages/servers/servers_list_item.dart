import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    String pingImage = 'assets/images/ping_status_1.png';
    if (ping.isNotEmpty) {
      final int? pingValue = int.tryParse(ping);
      if (pingValue != null) {
        if (pingValue > 200) {
          pingImage = 'assets/images/ping_status_3.png';
        } else if (pingValue > 100) {
          pingImage = 'assets/images/ping_status_2.png';
        }
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(51),
              blurRadius: 10,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ), // add some padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (icon != null)
                    SvgPicture.asset(icon!, width: 52, height: 52),
                  if (icon == null) const SizedBox(width: 16),
                  const SizedBox(width: 8), // spacing between icon and text
                  Container(
                    alignment: Alignment.center,
                    height: 52,
                    child: Flexible(
                      // Let text flexibly use remaining space
                      child: Text(
                        text,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
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
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
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
