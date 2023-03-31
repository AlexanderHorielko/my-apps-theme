import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_apps_theme/buttons/basic/custom_button.dart';
import 'package:my_apps_theme/buttons/enums/button_size.dart';
import 'package:my_apps_theme/buttons/enums/button_type.dart';

class CustomButtonsGroup extends StatefulWidget {
  final ButtonSize size;
  final String primaryButtonText;
  final String secondaryButtonText;
  final VoidCallback onPrimaryButtonTap;
  final VoidCallback onSecondaryButtonTap;

  const CustomButtonsGroup({
    Key? key,
    required this.primaryButtonText,
    required this.secondaryButtonText,
    required this.onPrimaryButtonTap,
    required this.onSecondaryButtonTap,
    this.size = ButtonSize.block,
  }) : super(key: key);

  @override
  State<CustomButtonsGroup> createState() => _CustomButtonsGroupState();
}

class _CustomButtonsGroupState extends State<CustomButtonsGroup> {
  @override
  Widget build(BuildContext context) {
    return widget.size == ButtonSize.block
        ? SizedBox(
            width: min(327, MediaQuery.maybeOf(context)!.size.width),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: widget.secondaryButtonText,
                    onTap: widget.onSecondaryButtonTap,
                    type: ButtonType.primary,
                    size: ButtonSize.large,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    text: widget.secondaryButtonText,
                    onTap: widget.onSecondaryButtonTap,
                    type: ButtonType.secondary,
                    size: ButtonSize.large,
                  ),
                ),
              ],
            ),
          )
        : Row(
            children: [
              CustomButton(
                text: widget.secondaryButtonText,
                onTap: widget.onSecondaryButtonTap,
                type: ButtonType.primary,
                size: widget.size,
              ),
              const SizedBox(width: 16),
              CustomButton(
                text: widget.secondaryButtonText,
                onTap: widget.onSecondaryButtonTap,
                type: ButtonType.secondary,
                size: widget.size,
              ),
            ],
          );
  }
}
