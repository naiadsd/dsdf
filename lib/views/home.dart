import 'package:dsd/state/data/data_service.dart';
import 'package:dsd/state/routeday/provider/routeday.dart';
import 'package:dsd/state/userinfo/model/user.dart';
import 'package:dsd/state/userinfo/provider/userdetails.dart';
import 'package:dsd/theme/colors.dart';
import 'package:dsd/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = ref.watch(userDetailsProvider);
    final routeDay = ref.watch(routeDayProvider);
    // ignore: unused_local_variable
    final size = MediaQuery.of(context).size;

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
                      const Center(
                        child: CircleAvatar(
                          backgroundColor: secondary,
                          radius: 60.0,
                          child: Text(
                            'RR',
                            style: TextStyle(
                                fontSize: 34, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${userDetails.firstName} ${userDetails.lastName}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 34,
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
                                    horizontal: 10, vertical: 12),
                                child: Column(
                                  children: [
                                    Text(
                                      '${userDetails.route}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'Route',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
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
                                      "\$ ${userDetails.valueAdded}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'Value Added',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
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
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'Orders ',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
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
                            height: 5,
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
                                  margin: const EdgeInsets.all(4),
                                  child: Center(
                                    child: InkWell(
                                      onTap: (() async {
                                        int route = await ref
                                            .read(userDetailsProvider.notifier)
                                            .getRoute();
                                        await fetchStoreDailyData(
                                            route, index + 1);

                                        ref
                                            .watch(routeDayProvider.notifier)
                                            .setRouteDay(index + 1);
                                      }),
                                      child: CircleAvatar(
                                        backgroundColor:
                                            routeDay == days[index]["id"]
                                                ? Colors.green
                                                : secondary,
                                        radius: 40.0,
                                        child: Text(
                                          days[index]["day"].toString(),
                                          style: const TextStyle(
                                              fontSize: 20,
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
                            height: 5,
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
                                        int route =
                                            await ref.read(routeDayProvider);

                                        await fetchStoreDailyData(
                                            index + 1, route);
                                        ref
                                            .watch(userDetailsProvider.notifier)
                                            .setRoute(index + 1);
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

  void switchRoute(BuildContext context, int currentRoute) {
    showModalBottomSheet<int?>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return MyBottomSheet();
        });
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
/*
                 Padding(
                    padding: const EdgeInsets.all(appPadding),
                    child: GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Customers',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        context.go('/customers');
                      },
                    ),
                  ),



                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: secondary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Sign out',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        final authProvider =
                            ref.read(authStateProvider.notifier);
                        authProvider.logout();
                      },
                    ),
                  ),



                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                'Switch Route',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          onTap: () async {
                            switchRoute(context, userDetails.route ?? 0);
                          },
                        ),
                      ),
                  
                      GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          height: 42,
                          decoration: BoxDecoration(
                            color: secondary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              'Refresh Data',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        onTap: () async {
                          return context.go('/orders');
                        },
                      ),
                    ],
                  ),
*/