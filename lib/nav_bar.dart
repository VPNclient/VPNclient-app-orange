import 'package:flutter/material.dart';
import 'design/images.dart';

class NavBar extends StatefulWidget {
  final int initialIndex;
  final Function(int) onItemTapped;

  const NavBar({super.key, this.initialIndex = 0, required this.onItemTapped});

  @override
  State<NavBar> createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  late int _selectedIndex;

  final List<Widget> _inactiveIcons = [serverIcon, homeIcon, settingsIcon];

  final List<Widget> _activeIcons = [
    activeServerIcon,
    activeHomeIcon,
    activeSettingsIcon,
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  void didUpdateWidget(covariant NavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialIndex != oldWidget.initialIndex) {
      setState(() {
        _selectedIndex = widget.initialIndex;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onItemTapped(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: 60,
      margin: const EdgeInsets.only(bottom: 35),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_inactiveIcons.length, (index) {
          bool isActive = _selectedIndex == index;
          return GestureDetector(
            onTap: () => _onItemTapped(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(3),
              child: isActive ? _activeIcons[index] : _inactiveIcons[index],
            ),
          );
        }),
      ),
    );
  }
}
