import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_apps_theme/buttons/basic/custom_icon_button.dart';
import 'package:my_apps_theme/buttons/button_colors.dart';
import 'package:my_apps_theme/buttons/my_ink_well.dart';
import 'package:my_apps_theme/my_apps_theme.dart';

class CustomStandardNavBar extends StatefulWidget {
  final String title;

  final NavBarLeftActionType leftAction;
  final NavBarRightActionType rightAction;

  final String? leftActionText;
  final String? rightActionText;

  final String? leftActionIcon;
  final String? rightActionIcon;

  final VoidCallback onRightActionTap;
  final VoidCallback onLeftActionTap;

  final AppMode mode;

  const CustomStandardNavBar({
    Key? key,
    required this.title,
    required this.leftAction,
    required this.rightAction,
    required this.onLeftActionTap,
    required this.onRightActionTap,
    this.mode = AppMode.light,
    this.rightActionIcon,
    this.leftActionIcon,
    this.leftActionText,
    this.rightActionText,
  }) : super(key: key);

  @override
  State<CustomStandardNavBar> createState() => _CustomStandardNavBarState();
}

class _CustomStandardNavBarState extends State<CustomStandardNavBar> {
  Widget _getLeftAction() {
    switch (widget.leftAction) {
      case NavBarLeftActionType.icon:
        return MyInkWell(
          onTap: widget.onLeftActionTap,
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: SvgPicture.asset(
              widget.leftActionIcon!,
              width: 10,
              height: 10,
              color: widget.mode == AppMode.light
                  ? ButtonColors.inkBase
                  : ButtonColors.skyWhite,
            ),
          ),
        );
      case NavBarLeftActionType.iconText:
        return MyInkWell(
          onTap: widget.onLeftActionTap,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: SvgPicture.asset(
                  widget.leftActionIcon!,
                  width: 10,
                  height: 10,
                  color: widget.mode == AppMode.light
                      ? ButtonColors.inkBase
                      : ButtonColors.skyWhite,
                ),
              ),
              Text(
                widget.leftActionText!,
                style: MyFonts.l.copyWith(
                  fontWeight: FontWeight.w400,
                  color: widget.mode == AppMode.light
                      ? ButtonColors.inkBase
                      : ButtonColors.skyWhite,
                ),
              )
            ],
          ),
        );
      case NavBarLeftActionType.buttton:
        return CustomButton(
          text: widget.leftActionText!,
          onTap: widget.onLeftActionTap,
          size: ButtonSize.small,
          type: ButtonType.transparent,
          mode: widget.mode,
        );
      default:
        return Container();
    }
  }

  Widget _getRightAction() {
    switch (widget.rightAction) {
      case NavBarRightActionType.icon:
        return CustomIconButton(
          icon: widget.rightActionIcon!,
          onTap: widget.onRightActionTap,
          type: ButtonType.transparent,
          size: ButtonSize.small,
          mode: widget.mode,
        );
      case NavBarRightActionType.text:
        return CustomButton(
          text: widget.leftActionText!,
          onTap: widget.onLeftActionTap,
          type: ButtonType.transparent,
          size: ButtonSize.small,
          mode: widget.mode,
        );
      case NavBarRightActionType.buttton:
        return CustomButton(
          text: widget.leftActionText!,
          onTap: widget.onLeftActionTap,
          size: ButtonSize.small,
          mode: widget.mode,
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: MediaQuery.maybeOf(context)!.size.width,
      color: widget.mode == AppMode.light
          ? ButtonColors.skyWhite
          : ButtonColors.inkBase,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _getLeftAction(),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                widget.title,
                style: MyFonts.l.copyWith(
                  fontWeight: FontWeight.w400,
                  color: widget.mode == AppMode.light
                      ? ButtonColors.inkBase
                      : ButtonColors.skyWhite,
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _getRightAction(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
