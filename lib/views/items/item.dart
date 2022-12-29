// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:dsd/state/cart/models/cart_item.dart';
import 'package:dsd/state/cart/provider/cart_provider.dart';
import 'package:dsd/state/items/models/item.dart';
import 'package:dsd/state/items/provider/item_provider.dart';
import 'package:dsd/state/promo/model/promo.dart';
import 'package:dsd/theme/colors.dart';
import 'package:dsd/views/items/cart_value_text_field.dart';
import 'package:dsd/views/items/styles.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ItemContainer extends ConsumerStatefulWidget {
  final Item item;
  final String pricingLevel;
  Promo? promo;
  ItemContainer(
      {Key? key, required this.item, required this.pricingLevel, this.promo})
      : super(key: key);

  @override
  ConsumerState<ItemContainer> createState() => ItemContainerState();
}

class ItemContainerState extends ConsumerState<ItemContainer> {
  int itemsAdded = 0;
  double cartPrice = 0.0;
  String getPrice() {
    switch (widget.pricingLevel) {
      case "1":
        return widget.item.salePrice;
      case "2":
        return widget.item.salePriceTwo;
      case "3":
        return widget.item.salePriceThree;
      case "4":
        return widget.item.salePriceFour;
      case "5":
        return widget.item.salePriceFive;
      case "6":
        return widget.item.salePriceSix;
      case "7":
        return widget.item.salePriceSeven;
      case "8":
        return widget.item.salePriceEight;
      case "9":
        return widget.item.salePriceNine;
      case "10":
        return widget.item.salePriceTen;

      default:
        return widget.item.salePrice;
    }
  }

  final priceController = TextEditingController();
  String? pid = '';
  double pPrice = 0.0;

  @override
  void initState() {
    super.initState();
    final cartItemprovider = ref.read(cartProvider.notifier);

    try {
      itemsAdded = cartItemprovider.getItemQuantity(widget.item.itemId);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    if (widget.promo != null) {
      pid = widget.promo?.promoId;
      pPrice = double.parse(widget.promo!.price);
    } else {
      //  pPrice = double.parse(getPrice());
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      width: size.width,
      height: size.width * 0.30,
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
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
            child: Text(
              widget.item.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: itemHeaderStyle,
            ),
          ),
          const Divider(
            height: 4,
            color: Colors.grey,
          ),
          Container(
            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.item.description,
                  style: const TextStyle(
                    fontSize: 15,
                    color: textWhite,
                  ),
                ),
                Text(
                  widget.item.itemId,
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
            height: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                width: size.width * 0.6,
                // color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$ ${getPrice()}',
                      style: itemPriceStyle,
                    ),
                    Text('CS\\${widget.item.reOrderQuantity}',
                        style: itemPriceStyle),
                    Text(
                      '\$ ${cartPrice.toStringAsFixed(2)}',
                      style: itemPriceStyle,
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width * 0.3,
                height: 35,
                alignment: Alignment.center,
                child: AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  reverseDuration: const Duration(seconds: 1),
                  child: itemsAdded > 0 ? addCartItem() : addItemFirstTime(),
                ),
              ),
            ],
          ),
          // Text(
          //   pPrice.toString(),
          //   style: const TextStyle(color: textWhite),
          // )
        ],
      ),
    );
  }

  void _showCartQuantityEditior() async {
    final res = await showDialog(
        context: context,
        builder: ((context) {
          return CartEditior(
            existingQuantity: itemsAdded,
            reOrderQuantity: double.parse(widget.item.reOrderQuantity),
          );
        }));

    if (res != null) {
      setState(() {
        itemsAdded = res;
        priceController.text = res.toString();
      });
    }
  }

  Widget addItemFirstTime() {
    final cart = ref.watch(cartProvider.notifier);

    addtoCartFirstTime() {
      setState(() {
        try {
          itemsAdded++;
          priceController.text = itemsAdded.toString();
          cartPrice = cartPrice +
              itemsAdded *
                  (widget.promo != null ? pPrice : double.parse(getPrice())) *
                  double.parse(widget.item.reOrderQuantity);
        } catch (e) {
          print(e.toString());
        }
      });

      CartItem i = CartItem(
        itemId: widget.item.itemId,
        promoId: pid ?? '',
        promoPrice: pPrice,
        saleprice: double.parse(getPrice()),
        quantity: itemsAdded,
        isPromoApplied: widget.promo != null,
        reOrderQuantity: double.parse(widget.item.reOrderQuantity),
        totalPrice: cartPrice,
        itemDescription: widget.item.description,
      );

      // print(i.toString());
      cart.addItem(i);
    }

    return OutlinedButton(
      style: const ButtonStyle(
        alignment: Alignment.center,
      ),
      onPressed: addtoCartFirstTime,
      child: const Text(
        "Add to Cart",
        style: TextStyle(
          color: primary,
        ),
      ),
    );
  }

  Widget addCartItem() {
    final cart = ref.watch(cartProvider.notifier);

    void increaseCart() {
      setState(
        () {
          itemsAdded++;
          priceController.text = itemsAdded.toString();

          cartPrice = itemsAdded *
              (widget.promo != null ? pPrice : double.parse(getPrice())) *
              double.parse(widget.item.reOrderQuantity);
        },
      );

      cart.changeitemQuantity(widget.item.itemId, itemsAdded);
    }

    void decreaseCart() {
      setState(
        () {
          itemsAdded = itemsAdded - 1;
          priceController.text = itemsAdded.toString();
          cartPrice = itemsAdded *
              (widget.promo != null ? pPrice : double.parse(getPrice())) *
              double.parse(widget.item.reOrderQuantity);
        },
      );

      cart.changeitemQuantity(widget.item.itemId, itemsAdded);
    }

    onRemoveFromCart() {
      setState(
        () {
          itemsAdded = itemsAdded - 1;
          priceController.text = itemsAdded.toString();
          cartPrice = cartPrice +
              itemsAdded *
                  (widget.promo != null ? pPrice : double.parse(getPrice())) *
                  double.parse(widget.item.reOrderQuantity);
        },
      );
      cart.removeItem(widget.item.itemId);
    }

    const itemPadding = 5.0;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          itemsAdded == 1
              ? Container(
                  //padding: const EdgeInsets.all(itemPadding),
                  decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(
                      width: 1,
                      color: Colors.black,
                    )),
                  ),
                  child: InkWell(
                    onTap: onRemoveFromCart,
                    child: const Icon(
                      Icons.delete_outline,
                      color: Colors.black,
                    ),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(itemPadding),
                  decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(
                      width: 1,
                      color: Colors.black,
                    )),
                  ),
                  child: InkWell(
                    onTap: decreaseCart,
                    child: const Icon(
                      Icons.remove,
                      color: Colors.black,
                    ),
                  ),
                ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.all(itemPadding),
              child: InkWell(
                onTap: _showCartQuantityEditior,
                child: Text(itemsAdded.toString()),
              ),
            ),
          ),
          Container(
            //padding: const EdgeInsets.all(itemPadding),
            decoration: const BoxDecoration(
              border: Border(
                  left: BorderSide(
                width: 1,
                color: Colors.black,
              )),
            ),
            child: InkWell(
              onTap: increaseCart,
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
