import 'package:dsd/state/customers/providers/customer_data_provider.dart';
import 'package:dsd/state/userinfo/provider/userdetails.dart';
import 'package:dsd/theme/colors.dart';
import 'package:dsd/theme/padding.dart';
import 'package:dsd/views/components/clipper.dart';
import 'package:dsd/views/components/custom_heading.dart';
import 'package:dsd/views/components/customer_search.dart';
import 'package:dsd/views/components/no_resultsfound.dart';
import 'package:dsd/views/components/noresults_found.dart';
import 'package:dsd/views/customers/customer.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListCustomer extends ConsumerStatefulWidget {
  const ListCustomer({super.key});

  @override
  ConsumerState<ListCustomer> createState() => _ListCustomerState();
}

class _ListCustomerState extends ConsumerState<ListCustomer> {
  @override
  Widget build(BuildContext context) {
    GlobalKey scaffoldc = GlobalKey();
    return Scaffold(
      key: scaffoldc,
      backgroundColor: background,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
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
    final userDetails = ref.watch(userDetailsProvider);
    final totalCustoemrs = ref.watch(customerStateProvider).totalRecords;
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            ClipPath(
              clipper: BottomClipper(),
              child: Container(
                width: size.width,
                height: size.height * 0.3,
                decoration: const BoxDecoration(
                  color: secondary,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: appPadding, right: appPadding),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: spacer,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomHeading(
                            title:
                                '${userDetails.firstName} ${userDetails.lastName}',
                            subTitle:
                                "Let's start orders for route ${userDetails.route}, total customers $totalCustoemrs",
                            color: textWhite,
                          ),
                          SizedBox(
                            height: spacer,
                            width: spacer,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                'assets/images/user_profile.jpg',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const CustomSearchField(
                        hintField: "Try 'Customer info",
                        backgroundColor: background,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        getCustomers(userDetails.uuid ?? ''),
      ],
    );
  }

  Widget getCustomers(String driverId) {
    var customers = ref.watch(customersProvider);
    var totoalNoOfCustomers = ref.watch(customerStateProvider).totalRecords;
    if (totoalNoOfCustomers == 0) {
      return Text('no data found'); //noResultsFound(context);
    }
    return Expanded(
        child: ListView.builder(
      itemBuilder: ((context, index) {
        return CustomerItem(
          customer: customers![index],
          driverId: driverId,
        );
      }),
      itemCount: customers?.length,
    ));
  }
/*
  Widget getCustomersDep(String driverId) {
    var customers = ref.watch(customerStateProvider).customers;

    return Expanded(
        child: customers.when(
      data: (data) {
        List<Customer> customers = data.map((e) => e).toList();
        setState(() {
          totoalNoOfCustomers = ref.watch(customerStateProvider).totalRecords;
        });
        if (customers.isEmpty) {
          return const Center(
            child: Text('no customers found in this route'),
          );
        }
        return ListView.builder(
          itemBuilder: ((context, index) {
            return CustomerItem(
              customer: customers[index],
              driverId: driverId,
            );
          }),
          itemCount: customers.length,
        );
      },
      error: (error, stackTrace) {
        return Center(
            child: Padding(
          padding: const EdgeInsets.all(appPadding),
          child: Text('Please check internet connection\n$error'),
        ));
      },
      loading: (() => const Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )),
    ));
  }*/
}
