import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_apps_theme/buttons/button_colors.dart';
import 'package:my_apps_theme/buttons/my_ink_well.dart';
import 'package:my_apps_theme/core/assets/images.dart';
import 'package:my_apps_theme/core/assets/svgs.dart';
import 'package:my_apps_theme/my_apps_theme.dart';

class CustomSearchBar extends StatefulWidget {
  final AppMode mode;

  const CustomSearchBar({
    Key? key,
    this.mode = AppMode.light,
  }) : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: Form(
        key: _key,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                controller: _controller,
                onChanged: (value) {
                  setState(() {});
                },
                focusNode: _focusNode,
                cursorColor: widget.mode == AppMode.light
                    ? ButtonColors.primaryBase
                    : ButtonColors.skyWhite,
                decoration: InputDecoration(
                  fillColor: widget.mode == AppMode.light
                      ? ButtonColors.skyLighter
                      : ButtonColors.inkLight,
                  filled: true,
                  hintText: 'Search',
                  hintStyle: MyFonts.m.copyWith(
                    color: widget.mode == AppMode.light
                        ? ButtonColors.skyDark
                        : ButtonColors.inkLightest,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 8,
                  ),
                  suffixIcon: _controller.text.isEmpty
                      ? null
                      : IntrinsicWidth(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MyInkWell(
                                onTap: () {
                                  setState(() {
                                    _controller.text = '';
                                  });
                                },
                                child: SvgPicture.asset(
                                  Svgs.close,
                                  width: 16,
                                  height: 16,
                                  color: widget.mode == AppMode.light
                                      ? ButtonColors.inkBase
                                      : ButtonColors.skyWhite,
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                  prefixIcon: IntrinsicWidth(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Svgs.search,
                          width: 16,
                          height: 16,
                          color: widget.mode == AppMode.light
                              ? ButtonColors.inkBase
                              : ButtonColors.skyWhite,
                        ),
                      ],
                    ),
                  ),
                ),
                style: MyFonts.m.copyWith(
                  color: widget.mode == AppMode.light
                      ? ButtonColors.inkBase
                      : ButtonColors.skyWhite,
                ),
              ),
            ),
            if (_focusNode.hasFocus)
              MyInkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    _controller.text = '';
                  });
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Text(
                    'Cancel',
                    style: MyFonts.m.copyWith(
                      color: widget.mode == AppMode.light
                          ? ButtonColors.inkBase
                          : ButtonColors.inkLightest,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
