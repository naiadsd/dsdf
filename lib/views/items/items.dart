import 'package:dsd/state/items/models/item.dart';
import 'package:dsd/state/items/provider/item_provider.dart';
import 'package:dsd/views/items/item.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class Items extends ConsumerStatefulWidget {
  const Items({super.key});

  @override
  ConsumerState<Items> createState() => ItemsState();
}

class ItemsState extends ConsumerState<Items> {
  final TextEditingController _searchfiler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var items = ref.watch(itemDataProvider);

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
            child: items.when(
                data: (data) {
                  List<Item> itemlist = data.map((e) => e).toList();
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: ((context, index) {
                            return ItemContainer(
                              item: itemlist[index],
                            );
                          }),
                          itemCount: itemlist.length,
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
