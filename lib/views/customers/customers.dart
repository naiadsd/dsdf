import 'dart:io';

import 'package:dsd/state/customers/model/customer.dart';
import 'package:dsd/state/customers/providers/customer_data_provider.dart';
import 'package:dsd/state/userinfo/provider/userdetails.dart';
import 'package:dsd/theme/colors.dart';
import 'package:dsd/theme/padding.dart';
import 'package:dsd/views/components/clipper.dart';
import 'package:dsd/views/components/custom_heading.dart';
import 'package:dsd/views/components/customer_search.dart';
import 'package:dsd/views/customers/customer.dart';
import 'package:dsd/views/items/items.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListCustomer extends ConsumerStatefulWidget {
  const ListCustomer({super.key});

  @override
  ConsumerState<ListCustomer> createState() => _ListCustomerState();
}

class _ListCustomerState extends ConsumerState<ListCustomer> {
  int totoalNoOfCustomers = 0;

  @override
  Widget build(BuildContext context) {
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
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    final userDetails = ref.watch(userDetailsProvider);

    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            ClipPath(
              clipper: BottomClipper(),
              child: Container(
                width: size.width,
                height: 300,
                decoration: const BoxDecoration(
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
                          CustomHeading(
                            title:
                                '${userDetails.firstName} ${userDetails.lastName}',
                            subTitle:
                                "Let's start orders for route ${userDetails.route}",
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
                        height: spacer,
                      ),
                      const CustomSearchField(
                        hintField: "Try 'Customer info",
                        backgroundColor: background,
                      ),
                      const SizedBox(
                        height: spacer - 30,
                      ),
                      const Text(
                        'customers found.',
                        style: const TextStyle(color: textWhite),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        getCustomers(),
      ],
    );
  }

  Widget getCustomers() {
    var customers = ref.watch(customerDataProvider);
    return Expanded(
        child: customers.when(
      data: (data) {
        List<Customer> customers = data.map((e) => e).toList();
        setState(() {
          totoalNoOfCustomers = customers.length;
        });
        return ListView.builder(
          itemBuilder: ((context, index) {
            return InkWell(
              child: CustomerItem(
                customer: customers[index],
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: ((context) {
                  return Items(customer: customers[index]);
                })));
              },
            );
          }),
          itemCount: customers.length,
        );
      },
      error: (error, stackTrace) {
        return Center(
            child: Padding(
          padding: const EdgeInsets.all(appPadding),
          child: Text('Please check internet connection\n' + error.toString()),
        ));
      },
      loading: (() => const Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )),
    ));
  }
}
