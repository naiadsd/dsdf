import 'package:dsd/state/customers/model/customer.dart';
import 'package:dsd/state/customers/providers/customer_data_provider.dart';

import 'package:dsd/views/customers/customer.dart';
import 'package:dsd/views/customers/customercontainer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Customers extends ConsumerStatefulWidget {
  const Customers({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<Customers> createState() => _CustomersState();
}

class _CustomersState extends ConsumerState<Customers> {
  final TextEditingController _searchfiler = TextEditingController();
  late List<Customer> customers = [];

  @override
  Widget build(BuildContext context) {
    var customers = ref.watch(customerDataProvider);

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      // appBar: AppBar(
      //   backgroundColor: Colors.deepPurpleAccent,
      //   title: Text('Customers'),
      // ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
//search bar,
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15)),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.search,
                  size: 35,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: _searchfiler,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                InkWell(
                  child: const Icon(
                    Icons.tune,
                    size: 45,
                  ),
                  onTap: () {},
                )
              ],
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          //items//
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60))),
            width: double.infinity,
            child: customers.when(
                data: (data) {
                  List<Customer> mainList = data.map((e) => e).toList();

                  List<Customer> cusotmerList = mainList
                      .where(
                        (element) =>
                            element.customerName.contains(_searchfiler.text),
                      )
                      .toList();
                  //.((cu) => cu.customerName.contains(_searchfiler.text)));

                  return Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: ((context, index) {
                            return CustomerItem(
                              customer: cusotmerList[index],
                            );
                          }),
                          itemCount: cusotmerList.length,
                        ),
                      )
                    ],
                  );
                },
                error: ((error, stackTrace) => Text(error.toString())),
                loading: (() => const Center(
                      child: CircularProgressIndicator(),
                    ))),
          )),
        ],
      ),
    ));
  }
}
