import 'package:flutter/material.dart';
import 'package:my_apps_theme/buttons/basic/custom_icon_button.dart';
import 'package:my_apps_theme/buttons/button_colors.dart';
import 'package:my_apps_theme/my_apps_theme.dart';

class CustomLargeNavBar extends StatefulWidget {
  final String title;
  final String? caption;
  final NavBarRightActionType rightAction;
  final String? rightActionText;
  final String? rightActionIcon;
  final VoidCallback onRightActionTap;
  final AppMode mode;

  const CustomLargeNavBar({
    Key? key,
    required this.title,
    required this.rightAction,
    required this.onRightActionTap,
    this.caption,
    this.rightActionText,
    this.rightActionIcon,
    this.mode = AppMode.light,
  }) : super(key: key);

  @override
  State<CustomLargeNavBar> createState() => _CustomLargeNavBarState();
}

class _CustomLargeNavBarState extends State<CustomLargeNavBar> {
  Widget _getRightAction() {
    switch (widget.rightAction) {
      case NavBarRightActionType.icon:
        return CustomIconButton(
          icon: widget.rightActionIcon!,
          onTap: widget.onRightActionTap,
          type: ButtonType.transparent,
          size: ButtonSize.large,
          mode: widget.mode,
        );
      case NavBarRightActionType.buttton:
        return CustomButton(
          text: widget.rightActionText!,
          onTap: widget.onRightActionTap,
          size: ButtonSize.small,
          mode: widget.mode,
        );
      case NavBarRightActionType.text:
        return Container();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.mode == AppMode.light
          ? ButtonColors.skyWhite
          : ButtonColors.inkBase,
      width: MediaQuery.maybeOf(context)!.size.width,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                widget.title,
                style: MyFonts.xl3.copyWith(
                  fontWeight: FontWeight.w700,
                  color: widget.mode == AppMode.light
                      ? ButtonColors.inkBase
                      : ButtonColors.skyWhite,
                ),
              ),
              if (widget.caption != null) ...[
                const SizedBox(height: 8),
                Text(
                  widget.caption!,
                  style: MyFonts.m.copyWith(
                    color: widget.mode == AppMode.light
                        ? ButtonColors.inkBase
                        : ButtonColors.skyWhite,
                  ),
                ),
              ]
            ],
          ),
          const Spacer(),
          _getRightAction(),
        ],
      ),
    );
  }
}
