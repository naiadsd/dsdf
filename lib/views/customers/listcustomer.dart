import 'package:dsd/theme/colors.dart';
import 'package:dsd/theme/padding.dart';
import 'package:dsd/views/components/clipper.dart';
import 'package:dsd/views/components/custom_heading.dart';
import 'package:dsd/views/components/custom_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ListCustomer extends StatefulWidget {
  const ListCustomer({super.key});

  @override
  State<ListCustomer> createState() => _ListCustomerState();
}

class _ListCustomerState extends State<ListCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              ClipPath(
                clipper: BottomClipper(),
                child: Container(
                  width: size.width,
                  height: 300,
                  decoration: BoxDecoration(
                    color: secondary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: appPadding, right: appPadding),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: spacer + 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomHeading(
                              title: 'Hi, Rama',
                              subTitle: "Let's start orders for route 1",
                              color: textWhite,
                            ),
                            SizedBox(
                              height: spacer,
                              width: spacer,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                    'assets/images/user_profile.jpg',
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: spacer,
                        ),
                        const CustomSearchField(
                          hintField: "Try 'Customer info",
                          backgroundColor: background,
                        ),
                        const SizedBox(
                          height: spacer - 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
