import 'package:dsd/views/invoice/invoice.dart';
import 'package:dsd/theme/colors.dart';
import 'package:dsd/views/customers/customers.dart';
import 'package:dsd/views/home.dart';
import 'package:dsd/views/settings/settings.dart';
import 'package:dsd/views/splash/splashImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RootApp extends StatefulWidget {
  RootApp({Key? key, required this.startIndex}) : super(key: key);
  int startIndex;

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageIndex = widget.startIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: getBottomNavBar(),
      body: getBody(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: const [
        ListCustomer(),
        Home(),
        Settings(),
        //SplashScreen(),
      ],
    );
  }

  Widget getBottomNavBar() {
    var size = MediaQuery.of(context).size;
    List bottomItems = [
      "assets/images/home_icon.svg",
      //"assets/images/settings_icon.png",
      "assets/images/settings.svg",
      // "assets/images/user_icon.svg",
    ];
    return Container(
      width: size.width,
      height: size.height * 0.12,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        color: textWhite,
        boxShadow: [
          BoxShadow(
            color: textBlack.withOpacity(0.4),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 40, right: 40, bottom: 10, top: 30),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(bottomItems.length, (index) {
                return InkWell(
                  onTap: (() {
                    SelectedTab(index);
                  }),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        bottomItems[index],
                        height: 17.5,
                        color: pageIndex == index ? primary : secondary,
                      ),
                      const SizedBox(
                        height: 15.0,
                        width: 20,
                      ),
                      (pageIndex == index
                          ? (AnimatedContainer(
                              duration: const Duration(
                                microseconds: 500,
                              ),
                              curve: Curves.easeIn,
                              height: 5.0,
                              width: 20.0,
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(100),
                              )))
                          : const SizedBox(
                              height: 5.0,
                              width: 20.0,
                            )),
                    ],
                  ),
                );
              })),
        ),
      ),
    );
  }

  SelectedTab(index) {
    setState(() {
      pageIndex = index;
    });
    widget.startIndex = index;
  }
}
