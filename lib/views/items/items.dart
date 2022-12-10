import 'package:badges/badges.dart';
import 'package:dsd/state/cart/provider/cart_provider.dart';
import 'package:dsd/state/customers/model/customer.dart';
import 'package:dsd/state/items/models/item.dart';
import 'package:dsd/state/items/provider/item_provider.dart';
import 'package:dsd/theme/colors.dart';
import 'package:dsd/theme/padding.dart';
import 'package:dsd/views/cart/cart.dart';
import 'package:dsd/views/components/clipper.dart';
import 'package:dsd/views/components/item_search.dart';
import 'package:dsd/views/items/item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';

class Items extends ConsumerStatefulWidget {
  final Customer customer;
  const Items({Key? key, required this.customer}) : super(key: key);

  @override
  ConsumerState<Items> createState() => ItemsState();
}

class ItemsState extends ConsumerState<Items> {
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
      body: getBody(context),
      extendBody: true,
    );
  }

  Widget getBody(BuildContext c) {
    final noOfItems = ref.watch(totalCartItemsProvider);
    var size = MediaQuery.of(c).size;
    return Stack(alignment: Alignment.topCenter, children: [
      Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
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
                                Navigator.pop(c);
                              }),
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                color: textWhite,
                              ),
                            ),
                            Badge(
                              badgeContent: Text(noOfItems.toString()),
                              position:
                                  const BadgePosition(start: 30, bottom: 30),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: spacer - 30,
                        ),
                        Flexible(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
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
      ),
      checkOutContainer(c),
    ]);
  }

  Widget checkOutContainer(BuildContext c) {
    var size = MediaQuery.of(c).size;
    var sidepadding = size.width * 0.19;

    final totalCartValue = ref.watch(totalCartValueProvider);
    return Positioned(
      bottom: 30,
      left: 0,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: sidepadding),
        height: 120,
        width: size.width,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          decoration: BoxDecoration(
              color: primary, borderRadius: BorderRadius.circular(25)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      //'\$ 100000.00',
                      '\$ ${totalCartValue.toStringAsFixed(2)}',
                      style: const TextStyle(color: textWhite, fontSize: 22),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
                TextButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: secondary,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onPressed: () {
                      Navigator.push(
                          c,
                          MaterialPageRoute(
                              builder: (context) => const CartData()));
                    },
                    child: const Text(
                      'Check out',
                      style: TextStyle(color: textWhite, fontSize: 20),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getItems() {
    var items = ref.watch(filterdItems);
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
