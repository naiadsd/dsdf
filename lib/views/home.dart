import 'package:dsd/state/data/data_service.dart';
import 'package:dsd/state/routeday/provider/routeday.dart';
import 'package:dsd/state/search/loading.dart';
import 'package:dsd/state/userinfo/model/user.dart';
import 'package:dsd/state/userinfo/provider/userdetails.dart';
import 'package:dsd/theme/colors.dart';
import 'package:dsd/utils/constants.dart';
import 'package:dsd/views/components/constants/strings.dart';
import 'package:dsd/views/components/loading/loading_screen.dart';
import 'package:dsd/views/styles.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  switchDay(BuildContext c, WidgetRef ref, int value) async {
    ref.watch(isloadingProvider.notifier).turnOnLoading();
    LoadingScreen.instance().show(context: c, text: Strings.refreshCustomers);
    int route = await ref.read(userDetailsProvider.notifier).getRoute();
    await fetchStoreDailyData(route, value);
    ref.watch(routeDayProvider.notifier).setRouteDay(value);
    ref.watch(isloadingProvider.notifier).turnOffLoading();
  }

  switchRoute(BuildContext c, WidgetRef ref, int value) async {
    ref.watch(isloadingProvider.notifier).turnOnLoading();
    LoadingScreen.instance().show(context: c, text: Strings.refreshCustomers);

    int routeDay = await ref.read(routeDayProvider);
    await fetchStoreDailyData(value, routeDay);
    ref.watch(userDetailsProvider.notifier).setRoute(value);
    ref.watch(isloadingProvider.notifier).turnOffLoading();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = ref.watch(userDetailsProvider);
    final routeDay = ref.watch(routeDayProvider);

    return Scaffold(
      backgroundColor: background,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: secondary,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey.shade100,
                        Colors.grey.shade200,
                        Colors.grey.shade100
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundColor: secondary,
                          radius: 40.0,
                          child: Text(
                            (userDetails.firstName != null &&
                                    userDetails.lastName != null)
                                ? '${userDetails.firstName!.substring(0, 1)}${userDetails.lastName!.substring(0, 1)}'
                                : '',
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${userDetails.firstName} ${userDetails.lastName}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: secondary,
                      //   border: Border.all(color: Colors.white, width: 5),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      //    mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 12,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      '${userDetails.route}',
                                      style: valueStyle,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'Route',
                                      style: valueText,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    Text("\$ ${userDetails.valueAdded}",
                                        style: valueStyle),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'Value Added',
                                      style: valueText,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      '${userDetails.totalOrders}',
                                      style: valueStyle,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'Orders ',
                                      style: valueText,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Dailynote(userDetails),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Switch Day',
                              style: TextStyle(
                                color: secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 120,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(30)),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: ((_, index) {
                                return Container(
                                  margin: const EdgeInsets.all(4),
                                  child: Center(
                                    child: InkWell(
                                      onTap: () async {
                                        await switchDay(
                                            context, ref, index + 2);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor:
                                            routeDay == days[index]["id"]
                                                ? Colors.green
                                                : secondary,
                                        radius: 28.0,
                                        child: Text(
                                          days[index]["day"].toString(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              itemCount: days.length,
                            ),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Switch Route',
                              style: TextStyle(
                                color: secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 120,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(30)),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: ((context, index) {
                                return Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Center(
                                    child: InkWell(
                                      onTap: (() async {
                                        await switchRoute(
                                            context, ref, index + 1);
                                      }),
                                      child: CircleAvatar(
                                        backgroundColor: userDetails.route ==
                                                int.parse(routes[index]["route"]
                                                    .toString())
                                            ? Colors.green
                                            : secondary,
                                        radius: 40.0,
                                        child: Text(
                                          routes[index]["route"].toString(),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              itemCount: routes.length,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stack Dailynote(User userDetails) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 150,
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400, width: 0.5),
            borderRadius: BorderRadius.circular(15),
            shape: BoxShape.rectangle,
          ),
          child: Center(
            child: Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 8),
                child: Text(
                  '${userDetails.note}',
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                )),
          ),
        ),
        Positioned(
            left: 35,
            top: 8,
            child: Container(
              color: Colors.transparent,
              child: const Text(
                ' note of the day',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
      ],
    );
  }
}

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 300,
        color: Colors.white60,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 300,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.25),
                child: const TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10),
                    hintText: 'New Route',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Switch',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
