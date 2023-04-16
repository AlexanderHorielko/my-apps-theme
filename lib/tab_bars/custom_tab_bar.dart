import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_apps_theme/buttons/button_colors.dart';
import 'package:my_apps_theme/buttons/my_ink_well.dart';
import 'package:my_apps_theme/my_apps_theme.dart';

class CustomTabBar extends StatefulWidget {
  final List<CustomTabBarItem> items;
  final int currentIndex;
  final AppMode appMode;
  final VoidCallback onTap;

  const CustomTabBar({
    Key? key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.appMode = AppMode.light,
  }) : super(key: key);

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.maybeOf(context)!.size.width,
      color: widget.appMode == AppMode.light
          ? ButtonColors.skyWhite
          : ButtonColors.inkLight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < widget.items.length; i++)
            _buildTabBatItem(
              widget.items[i],
              isActive: widget.currentIndex == i,
            ),
        ],
      ),
    );
  }

  Widget _buildTabBatItem(CustomTabBarItem item, {bool isActive = false}) {
    return Expanded(
      child: MyInkWell(
        onTap: widget.onTap,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                SvgPicture.asset(
                  item.icon,
                  width: 24,
                  height: 24,
                  color: widget.appMode == AppMode.light
                      ? isActive
                          ? ButtonColors.primaryBase
                          : ButtonColors.skyDark
                      : isActive
                          ? ButtonColors.skyWhite
                          : ButtonColors.inkLightest,
                ),
                const SizedBox(height: 4),
                Text(
                  item.title,
                  style: MyFonts.xs.copyWith(
                    color: widget.appMode == AppMode.light
                        ? isActive
                            ? ButtonColors.primaryBase
                            : ButtonColors.skyDark
                        : isActive
                            ? ButtonColors.skyWhite
                            : ButtonColors.inkLightest,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTabBarItem {
  final String title;
  final String icon;

  CustomTabBarItem({
    required this.title,
    required this.icon,
  });
}
