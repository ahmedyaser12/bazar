import 'package:flutter/material.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/common_functions.dart';

class SearchAndButtonSearch extends StatelessWidget {
  final TextEditingController controller;
  final BorderRadius borderRadius;
  final bool isButtonSearch;
  final Color color;
  final Color iconColor;
  final Color textTypingColor;
  final void Function() onPressed;

  const SearchAndButtonSearch({
    super.key,
    required this.isButtonSearch,
    required this.color,
    required this.textTypingColor,
    required this.iconColor,
    required this.borderRadius,
    required this.controller,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: Container(
              decoration: BoxDecoration(
                  border: isButtonSearch
                      ? Border.all(
                          color: AppColors.secondary,
                          width: .5,
                        )
                      : null,
                  color: color,
                  borderRadius: borderRadius),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Icon(
                      Icons.search,
                      color: iconColor,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      style: TextStyle(
                        color: textTypingColor,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        widthSpace(isButtonSearch ? 10 : 0),
        isButtonSearch
            ? TextButton(
                onPressed: () {
                  onPressed();
                },
                style: ButtonStyle(
                    minimumSize: const MaterialStatePropertyAll(Size(40, 40)),
                    backgroundColor:
                        MaterialStatePropertyAll(AppColors.lightGery)),
                child: const Text(
                  'search',
                  style: TextStyle( fontSize: 15),
                ),
              )
            : Container(),
      ],
    );
  }
}
