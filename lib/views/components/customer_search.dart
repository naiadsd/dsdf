import 'package:dsd/state/search/customer_search.dart';
import 'package:dsd/theme/colors.dart';
import 'package:dsd/theme/padding.dart';
import 'package:dsd/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomSearchField extends ConsumerStatefulWidget {
  const CustomSearchField({
    Key? key,
    required this.hintField,
    this.backgroundColor,
  }) : super(key: key);

  final String hintField;
  final Color? backgroundColor;

  @override
  ConsumerState createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends ConsumerState<CustomSearchField> {
  @override
  Widget build(BuildContext context) {
    final customerSearchProvi = ref.watch(customerSerachProvider.notifier);

    final customerSearchConroller = TextEditingController();

    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: spacer,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(7.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40.0,
            width: 40.0,
            alignment: Alignment.center,
            child: Container(
              child: SvgPicture.asset(
                assetImg + '/search_icon.svg',
                color: secondary.withOpacity(0.5),
                height: 15.0,
              ),
            ),
          ),
          Flexible(
            child: Container(
              width: size.width,
              height: 38,
              alignment: Alignment.topCenter,
              child: TextField(
                onChanged: (value) {
                  customerSearchProvi
                      .setSearchText(customerSearchConroller.text);
                },
                controller: customerSearchConroller,
                style: TextStyle(fontSize: 15),
                cursorColor: textBlack,
                decoration: InputDecoration(
                  hintText: widget.hintField,
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: secondary.withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Container(
            height: 40.0,
            width: 40.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: primary.withOpacity(0.7),
              borderRadius: BorderRadius.circular(7.0),
              boxShadow: [
                BoxShadow(
                  color: primary.withOpacity(0.5),
                  spreadRadius: 0.0,
                  blurRadius: 6.0,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: InkWell(
              child: SvgPicture.asset(
                '$assetImg/filter_icon.svg',
                color: textWhite,
                height: 13.0,
              ),
              onTap: () {
                customerSearchProvi.setSearchText(customerSearchConroller.text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
