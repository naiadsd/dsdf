import 'package:badges/badges.dart';
import 'package:dsd/state/cart/models/cart_item.dart';
import 'package:dsd/state/cart/provider/cart_provider.dart';
import 'package:dsd/theme/colors.dart';
import 'package:dsd/theme/padding.dart';
import 'package:dsd/views/components/clipper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartData extends ConsumerStatefulWidget {
  const CartData({super.key});

  @override
  ConsumerState<CartData> createState() => _CartDataState();
}

class _CartDataState extends ConsumerState<CartData> {
  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      extendBodyBehindAppBar: true,
      extendBody: true,
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

    final noOfItems = ref.watch(totalCartItemsProvider);
    return Column(
      children: [
        ClipPath(
          clipper: BottomClipper(),
          child: Container(
            width: size.width,
            height: 300,
            decoration: const BoxDecoration(
              color: Colors.grey,
            ),
            child: Padding(
              padding: EdgeInsets.only(left: appPadding, right: appPadding),
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
                      Badge(
                        badgeContent: Text(noOfItems.toString()),
                        position: const BadgePosition(start: 30, bottom: 30),
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
                ],
              ),
            ),
          ),
        ),
        Expanded(child: getCartItems()),
      ],
    );
  }

  Widget getCartItems() {
    var items = ref.watch(cartProvider).items ?? [];
    final cartPro = ref.watch(cartProvider.notifier);
    return items.isEmpty
        ? Container(
            child: Text('no items in cart'),
          )
        : ListView.builder(
            itemCount: items.length,
            itemBuilder: ((context, index) {
              return Dismissible(
                background: Container(color: Colors.red),
                key: Key(items[index].itemId.toString()),
                onDismissed: ((direction) {
                  cartPro.removeItem(items[index].itemId);
                  setState(() {
                    items.removeAt(index);
                  });
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('dismissed')));
                }),
                child: ListTile(
                  title: Text('cart item...'),
                ),
              );
            }));
    ;
  }
}
