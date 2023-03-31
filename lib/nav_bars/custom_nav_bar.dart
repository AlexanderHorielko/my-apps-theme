import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_apps_theme/buttons/basic/custom_icon_button.dart';
import 'package:my_apps_theme/buttons/my_ink_well.dart';
import 'package:my_apps_theme/my_apps_theme.dart';

class CustomNavBar extends StatefulWidget {
  final String title;

  final NavBarLeftActionType leftAction;
  final NavBarRightActionType rightAction;

  final String? leftActionText;
  final String? rightActionText;

  final String? leftActionIcon;
  final String? rightActionIcon;

  final VoidCallback onRightActionTap;
  final VoidCallback onLeftActionTap;

  const CustomNavBar({
    Key? key,
    required this.title,
    required this.leftAction,
    required this.rightAction,
    required this.onLeftActionTap,
    required this.onRightActionTap,
    this.rightActionIcon,
    this.leftActionIcon,
    this.leftActionText,
    this.rightActionText,
  }) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
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
                ),
              ),
              Text(
                widget.leftActionText!,
                style: MyFonts.l.copyWith(fontWeight: FontWeight.w400),
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
        );
      case NavBarRightActionType.text:
        return CustomButton(
          text: widget.leftActionText!,
          onTap: widget.onLeftActionTap,
          type: ButtonType.transparent,
          size: ButtonSize.small,
        );
      case NavBarRightActionType.buttton:
        return CustomButton(
          text: widget.leftActionText!,
          onTap: widget.onLeftActionTap,
          size: ButtonSize.small,
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
      color: Colors.white,
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
                style: MyFonts.l.copyWith(fontWeight: FontWeight.w400),
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
