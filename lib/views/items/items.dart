import 'package:dsd/state/customers/model/customer.dart';
import 'package:dsd/state/items/models/item.dart';
import 'package:dsd/state/items/provider/item_provider.dart';
import 'package:dsd/theme/colors.dart';
import 'package:dsd/theme/padding.dart';
import 'package:dsd/views/components/clipper.dart';
import 'package:dsd/views/components/item_search.dart';
import 'package:dsd/views/items/item.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class Items extends ConsumerStatefulWidget {
  final Customer customer;
  const Items({Key? key, required this.customer}) : super(key: key);

  @override
  ConsumerState<Items> createState() => ItemsState();
}

class ItemsState extends ConsumerState<Items> {
  final TextEditingController _searchfiler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
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
                        height: spacer + 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (() {
                              Navigator.pop(context);
                            }),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: textWhite,
                            ),
                          ),
                          const Text(
                            "Items",
                            style: TextStyle(
                                color: textWhite,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: spacer - 30,
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Text(
                                widget.customer.customerName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: textWhite,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: spacer - 20,
                            ),
                            const ItemSearchField(
                              hintField: 'Try ice cream',
                              backgroundColor: background,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        getItems(),
      ],
    );
  }

  Widget getItems() {
    var items = ref.watch(itemDataProvider);
    return Expanded(
        child: items.when(
      data: (data) {
        List<Item> items = data.map((e) => e).toList();
        return ListView.builder(
          itemBuilder: ((context, index) {
            return ItemContainer(
              item: items[index],
              pricingLevel: widget.customer.pricingLevel,
            );
          }),
          itemCount: items.length,
        );
      },
      error: (error, stackTrace) {
        return Text(error.toString());
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
//       body: Column(
//         children: [
//           const SizedBox(
//             height: 40,
//           ),
// //search bar,
//           Container(
//             decoration: BoxDecoration(
//                 color: Colors.grey.shade300,
//                 borderRadius: BorderRadius.circular(15)),
//             margin: const EdgeInsets.symmetric(horizontal: 10),
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(
//                   Icons.search,
//                   size: 35,
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: TextField(
//                       controller: _searchfiler,
//                       decoration: const InputDecoration(
//                         border: InputBorder.none,
//                       ),
//                       style: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 20,
//                           fontWeight: FontWeight.w300),
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   child: const Icon(
//                     Icons.tune,
//                     size: 45,
//                   ),
//                   onTap: () {},
//                 )
//               ],
//             ),
//           ),

//           const SizedBox(
//             height: 20,
//           ),
//           //items//
//           Expanded(
//               child: Container(
//             decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(60),
//                     topRight: Radius.circular(60))),
//             width: double.infinity,
//             child: items.when(
//                 data: (data) {
//                   List<Item> itemlist = data.map((e) => e).toList();
//                   return Column(
//                     children: [
//                       Expanded(
//                         child: ListView.builder(
//                           itemBuilder: ((context, index) {
//                             return ItemContainer(
//                               item: itemlist[index],
//                             );
//                           }),
//                           itemCount: itemlist.length,
//                         ),
//                       )
//                     ],
//                   );
//                 },
//                 error: ((error, stackTrace) => Text(error.toString())),
//                 loading: (() => const Center(
//                       child: CircularProgressIndicator(),
//                     ))),
//           )),
//         ],
//       ),
//     );
//   }
// }
