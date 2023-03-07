import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_apps_theme/buttons/button_colors.dart';
import 'package:my_apps_theme/buttons/my_ink_well.dart';
import 'package:my_apps_theme/my_apps_theme.dart';

class CustomIconButton extends StatefulWidget {
  final Function onTap;
  final ButtonMode mode;
  final ButtonSize size;
  final ButtonState state;
  final ButtonType type;
  final String icon;

  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.mode = ButtonMode.light,
    this.size = ButtonSize.block,
    this.state = ButtonState.common,
    this.type = ButtonType.primary,
  }) : super(key: key);

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
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
            if (widget.mode == ButtonMode.dark) {
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
            if (widget.mode == ButtonMode.dark) {
              color = Colors.white;
            } else {
              color = ButtonColors.primaryLightest;
            }
            break;
          case ButtonState.pressed:
            color = ButtonColors.primaryLighter;
            break;
          case ButtonState.disabled:
            if (widget.mode == ButtonMode.dark) {
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
            if (widget.mode == ButtonMode.dark) {
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

  Color _getButtonBorderColor() {
    switch (_buttonState) {
      case ButtonState.common:
        if (widget.mode == ButtonMode.dark) {
          return ButtonColors.primaryLight;
        } else {
          return ButtonColors.primaryBase;
        }
      case ButtonState.pressed:
        if (widget.mode == ButtonMode.dark) {
          return ButtonColors.primaryBase;
        } else {
          return ButtonColors.primaryDark;
        }
      case ButtonState.disabled:
        if (widget.mode == ButtonMode.dark) {
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
            padding: EdgeInsets.all(widget.size == ButtonSize.small ? 8 : 12),
            child: SvgPicture.asset(
              widget.icon,
              width: _iconSize,
              height: _iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
