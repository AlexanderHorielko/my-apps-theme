import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_apps_theme/buttons/button_colors.dart';
import 'package:my_apps_theme/buttons/enums/button_icon_poistion.dart';
import 'package:my_apps_theme/buttons/enums/button_mode.dart';
import 'package:my_apps_theme/buttons/enums/button_size.dart';
import 'package:my_apps_theme/buttons/enums/button_state.dart';
import 'package:my_apps_theme/buttons/enums/button_type.dart';
import 'package:my_apps_theme/buttons/my_ink_well.dart';
import 'package:my_apps_theme/my_fonts.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Function onTap;
  final ButtonIconPosition iconPosition;
  final ButtonMode mode;
  final ButtonSize size;
  final ButtonState state;
  final ButtonType type;
  final String? icon;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.iconPosition = ButtonIconPosition.none,
    this.mode = ButtonMode.light,
    this.size = ButtonSize.block,
    this.state = ButtonState.common,
    this.type = ButtonType.primary,
    this.icon,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  late ButtonState _buttonState = widget.state;
  late final _iconSize = widget.size == ButtonSize.small ? 16.0 : 24.0;

  Color _getButtonColor() {
    Color color = ButtonColors.primaryBase;
    switch (widget.type) {
      case ButtonType.primary:
        switch (_buttonState) {
          case ButtonState.common:
            color = ButtonColors.primaryBase;
            break;
          case ButtonState.pressed:
            color = ButtonColors.primaryDark;
            break;
          case ButtonState.disabled:
            color = ButtonColors.skyLight;
            break;
        }
        break;
      case ButtonType.secondary:
        switch (_buttonState) {
          case ButtonState.common:
            color = ButtonColors.primaryLightest;
            break;
          case ButtonState.pressed:
            color = ButtonColors.primaryLighter;
            break;
          case ButtonState.disabled:
            color = ButtonColors.skyLight;
            break;
        }
        break;
      case ButtonType.outline:
        switch (_buttonState) {
          case ButtonState.common:
          case ButtonState.pressed:
            color = Colors.white;
            break;
          case ButtonState.disabled:
            color = ButtonColors.skyBase;
            break;
        }
        break;
      case ButtonType.transparent:
        switch (_buttonState) {
          case ButtonState.common:
            color = Colors.transparent;
            break;
          case ButtonState.pressed:
            color = ButtonColors.primaryLightest;
            break;
          case ButtonState.disabled:
            color = Colors.transparent;
            break;
        }
        break;
      default:
        break;
    }
    return color;
  }

  Color _getButtonTextColor() {
    Color color = Colors.white;
    switch (widget.type) {
      case ButtonType.primary:
        switch (_buttonState) {
          case ButtonState.common:
          case ButtonState.pressed:
            color = Colors.white;
            break;
          case ButtonState.disabled:
            color = ButtonColors.skyDark;
            break;
        }
        break;
      case ButtonType.secondary:
        switch (_buttonState) {
          case ButtonState.common:
            color = ButtonColors.primaryBase;
            break;
          case ButtonState.pressed:
            color = ButtonColors.primaryDark;
            break;
          case ButtonState.disabled:
            color = ButtonColors.skyDark;
            break;
        }
        break;
      case ButtonType.outline:
        switch (_buttonState) {
          case ButtonState.common:
            color = ButtonColors.primaryBase;
            break;
          case ButtonState.pressed:
            color = ButtonColors.primaryDark;
            break;
          case ButtonState.disabled:
            color = ButtonColors.skyBase;
            break;
        }
        break;
      case ButtonType.transparent:
        switch (_buttonState) {
          case ButtonState.common:
            color = ButtonColors.primaryBase;
            break;
          case ButtonState.pressed:
            color = ButtonColors.primaryBase;
            break;
          case ButtonState.disabled:
            color = ButtonColors.skyBase;
            break;
        }
        break;
      default:
        break;
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        if (widget.state == ButtonState.disabled) return;
        setState(() {
          _buttonState = ButtonState.pressed;
        });
      },
      onPointerUp: (event) {
        if (widget.state == ButtonState.disabled) return;
        setState(() {
          _buttonState = ButtonState.common;
        });
      },
      child: MyInkWell(
        onTap: () {
          if (widget.state == ButtonState.disabled) return;
        },
        borderRadius: 48,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48),
            border: widget.type == ButtonType.outline
                ? Border.all(color: ButtonColors.primaryBase)
                : null,
            color: _getButtonColor(),
          ),
          width: widget.size == ButtonSize.block
              ? min(327, MediaQuery.maybeOf(context)!.size.width)
              : null,
          padding: EdgeInsets.symmetric(
            vertical: widget.size == ButtonSize.small
                ? 8
                : widget.icon != null
                    ? 12
                    : 16,
            horizontal: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.icon != null &&
                  widget.iconPosition == ButtonIconPosition.left)
                SvgPicture.asset(
                  widget.icon!,
                  width: _iconSize,
                  height: _iconSize,
                ),
              Row(
                children: [
                  if (widget.icon != null &&
                      widget.iconPosition == ButtonIconPosition.side)
                    SvgPicture.asset(
                      widget.icon!,
                      width: _iconSize,
                      height: _iconSize,
                    ),
                  Text(
                    widget.text,
                    style: MyFonts.m.copyWith(
                      color: _getButtonTextColor(),
                    ),
                  )
                ],
              ),
              if (widget.icon != null &&
                  widget.iconPosition == ButtonIconPosition.right)
                SvgPicture.asset(
                  widget.icon!,
                  width: _iconSize,
                  height: _iconSize,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
