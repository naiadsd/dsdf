import 'package:dsd/db/db_provider.dart';
import 'package:dsd/state/cart/models/cart_item.dart';

import 'package:dsd/state/items/models/item.dart';
import 'package:dsd/theme/colors.dart';
import 'package:dsd/views/items/styles.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartItemContainer extends ConsumerStatefulWidget {
  final CartItem cartItem;
  const CartItemContainer({
    Key? key,
    required this.cartItem,
  }) : super(key: key);
  @override
  ConsumerState<CartItemContainer> createState() => CartItemContainerState();
}

class CartItemContainerState extends ConsumerState<CartItemContainer> {
  int itemsAdded = 0;
  double cartPrice = 0.0;
  Item? item;
  final priceController = TextEditingController();

  getItem() async {
    var i = await DBProvier.db.getItemById(widget.cartItem.itemId);

    setState(() {
      item = i;
    });
  }

  @override
  void initState() {
    super.initState();
    getItem();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return item == null
        ? const Text('loading...')
        : Container(
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
            width: size.width,
            height: size.width * 0.28,
            decoration: BoxDecoration(
              color: secondary,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: textBlack.withOpacity(0.3),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                  child: Text(item!.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: itemHeaderStyle),
                ),
                const Divider(
                  height: 2,
                  color: Colors.white,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item!.description,
                        style: const TextStyle(
                          fontSize: 15,
                          color: textWhite,
                        ),
                      ),
                      Text(
                        item!.itemId,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: textWhite,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 0),
                      width: size.width * 0.8,
                      // color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '\$ ${widget.cartItem.saleprice.toStringAsFixed(2)}',
                              style: itemPriceStyle),
                          Text('CS/${item!.reOrderQuantity}',
                              style: itemPriceStyle),
                          Text(
                            '${widget.cartItem.quantity}',
                            style: itemPriceStyle,
                          ),
                          Text(
                              '\$ ${widget.cartItem.totalPrice.toStringAsFixed(2)}',
                              style: itemPriceStyle),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
