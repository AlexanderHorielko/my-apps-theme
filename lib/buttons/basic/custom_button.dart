import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_apps_theme/buttons/button_colors.dart';
import 'package:my_apps_theme/buttons/enums/button_size.dart';
import 'package:my_apps_theme/buttons/enums/button_state.dart';
import 'package:my_apps_theme/buttons/enums/button_type.dart';
import 'package:my_apps_theme/buttons/enums/button_icon_position.dart';
import 'package:my_apps_theme/buttons/my_ink_well.dart';
import 'package:my_apps_theme/core/enums/app_mode.dart';
import 'package:my_apps_theme/my_fonts.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Function onTap;
  final ButtonIconPosition iconPosition;
  final AppMode mode;
  final ButtonSize size;
  final ButtonState state;
  final ButtonType type;
  final String? icon;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.iconPosition = ButtonIconPosition.none,
    this.mode = AppMode.light,
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
            if (widget.mode == AppMode.dark) {
              color = ButtonColors.inkLighter;
            } else {
              color = ButtonColors.skyLight;
            }
            break;
        }
        break;
      case ButtonType.secondary:
        switch (_buttonState) {
          case ButtonState.common:
            if (widget.mode == AppMode.dark) {
              color = Colors.white;
            } else {
              color = ButtonColors.primaryLightest;
            }
            break;
          case ButtonState.pressed:
            color = ButtonColors.primaryLighter;
            break;
          case ButtonState.disabled:
            if (widget.mode == AppMode.dark) {
              color = ButtonColors.inkLighter;
            } else {
              color = ButtonColors.skyLight;
            }
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
            if (widget.mode == AppMode.dark) {
              color = ButtonColors.primaryLighter;
            } else {
              color = ButtonColors.primaryLightest;
            }
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
            if (widget.mode == AppMode.dark) {
              color = ButtonColors.inkLightest;
            } else {
              color = ButtonColors.skyDark;
            }
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
            if (widget.mode == AppMode.dark) {
              color = ButtonColors.inkLighter;
            } else {
              color = ButtonColors.skyDark;
            }
            break;
        }
        break;
      case ButtonType.outline:
        switch (_buttonState) {
          case ButtonState.common:
            if (widget.mode == AppMode.dark) {
              color = ButtonColors.primaryLight;
            } else {
              color = ButtonColors.primaryBase;
            }
            break;
          case ButtonState.pressed:
            if (widget.mode == AppMode.dark) {
              color = ButtonColors.primaryBase;
            } else {
              color = ButtonColors.primaryDark;
            }
            break;
          case ButtonState.disabled:
            if (widget.mode == AppMode.dark) {
              color = ButtonColors.inkLighter;
            } else {
              color = ButtonColors.skyBase;
            }
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
            if (widget.mode == AppMode.dark) {
              color = ButtonColors.inkLightest;
            } else {
              color = ButtonColors.skyBase;
            }
            break;
        }
        break;
      default:
        break;
    }
    return color;
  }

  Color _getButtonBorderColor() {
    switch (_buttonState) {
      case ButtonState.common:
        if (widget.mode == AppMode.dark) {
          return ButtonColors.primaryLight;
        } else {
          return ButtonColors.primaryBase;
        }
      case ButtonState.pressed:
        if (widget.mode == AppMode.dark) {
          return ButtonColors.primaryBase;
        } else {
          return ButtonColors.primaryDark;
        }
      case ButtonState.disabled:
        if (widget.mode == AppMode.dark) {
          return ButtonColors.inkLighter;
        } else {
          return ButtonColors.skyBase;
        }
      default:
        return ButtonColors.primaryBase;
    }
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
          widget.onTap();
        },
        borderRadius: 48,
        child: IntrinsicWidth(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(48),
              border: widget.type == ButtonType.outline
                  ? Border.all(color: _getButtonBorderColor())
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
                if (widget.icon != null)
                  Opacity(
                    opacity:
                        widget.iconPosition == ButtonIconPosition.left ? 1 : 0,
                    child: SvgPicture.asset(
                      widget.icon!,
                      width: _iconSize,
                      height: _iconSize,
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null &&
                        widget.iconPosition == ButtonIconPosition.side) ...[
                      SvgPicture.asset(
                        widget.icon!,
                        width: _iconSize,
                        height: _iconSize,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.text,
                      style: MyFonts.m.copyWith(
                        color: _getButtonTextColor(),
                      ),
                    )
                  ],
                ),
                if (widget.icon != null)
                  Opacity(
                    opacity:
                        widget.iconPosition == ButtonIconPosition.right ? 1 : 0,
                    child: SvgPicture.asset(
                      widget.icon!,
                      width: _iconSize,
                      height: _iconSize,
                      color: widget.mode == AppMode.light
                          ? ButtonColors.inkBase
                          : ButtonColors.skyWhite,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
