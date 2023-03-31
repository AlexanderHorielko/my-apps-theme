import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_apps_theme/buttons/button_colors.dart';
import 'package:my_apps_theme/buttons/enums/button_auth_type.dart';
import 'package:my_apps_theme/core/svgs.dart';

class CustomAuthButton extends StatefulWidget {
  final ButtonAuthType type;
  const CustomAuthButton({Key? key, required this.type}) : super(key: key);

  @override
  State<CustomAuthButton> createState() => _CustomAuthButtonState();
}

class _CustomAuthButtonState extends State<CustomAuthButton> {
  Color _getButtonColor() {
    switch (widget.type) {
      case ButtonAuthType.apple:
        return ButtonColors.inkBase;
      case ButtonAuthType.google:
        return ButtonColors.skyWhite;
      case ButtonAuthType.facebook:
        return ButtonColors.facebook50;
      case ButtonAuthType.twitter:
        return ButtonColors.twitter50;
      default:
        return ButtonColors.inkBase;
    }
  }

  String _getButtonText() {
    switch (widget.type) {
      case ButtonAuthType.apple:
        return 'Apple';
      case ButtonAuthType.google:
        return 'Google';
      case ButtonAuthType.facebook:
        return 'Facebook';
      case ButtonAuthType.twitter:
        return 'Twitter';
      default:
        return 'Apple';
    }
  }

  String _getButtonIcon() {
    switch (widget.type) {
      case ButtonAuthType.apple:
        return Svgs.appleLogo;
      case ButtonAuthType.google:
        return Svgs.googleLogo;
      case ButtonAuthType.facebook:
        return Svgs.facebookLogo;
      case ButtonAuthType.twitter:
        return Svgs.twitterLogo;
      default:
        return Svgs.appleLogo;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: min(MediaQuery.maybeOf(context)!.size.width, 366),
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: _getButtonColor(),
        borderRadius: BorderRadius.circular(48),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            _getButtonIcon(),
            width: 24,
            height: 24,
          ),
          Text('Continue with ${_getButtonText()}'),
          Opacity(
            opacity: 0,
            child: SvgPicture.asset(
              _getButtonIcon(),
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }
}
