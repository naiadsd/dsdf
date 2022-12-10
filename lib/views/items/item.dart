import 'package:dsd/state/cart/models/cart_item.dart';
import 'package:dsd/state/cart/provider/cart_provider.dart';
import 'package:dsd/state/items/models/item.dart';
import 'package:dsd/theme/colors.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ItemContainer extends ConsumerStatefulWidget {
  final Item item;
  final String pricingLevel;
  const ItemContainer(
      {Key? key, required this.item, required this.pricingLevel})
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
              style: const TextStyle(
                color: textWhite,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
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
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'CS\\${widget.item.reOrderQuantity}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '\$ ${cartPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width * 0.3,
                height: 42,
                alignment: Alignment.center,
                child: itemsAdded > 0 ? addCartItem() : addItemFirstTime(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget addItemFirstTime() {
    final cart = ref.watch(cartProvider.notifier);

    addtoCartFirstTime() {
      setState(() {
        itemsAdded++;
        priceController.text = itemsAdded.toString();
        cartPrice = itemsAdded * double.parse(getPrice());
      });

      cart.addItem(
        CartItem(
            itemId: widget.item.id,
            promoId: '1223',
            promoPrice: double.parse(getPrice()),
            saleprice: double.parse(getPrice()),
            quantity: itemsAdded,
            isPromoApplied: false,
            reOrderQuantity: double.parse(widget.item.reOrderQuantity),
            totalPrice: double.parse(getPrice()) * itemsAdded),
      );
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
          cartPrice = itemsAdded * double.parse(getPrice());
        },
      );

      cart.changeitemQuantity(widget.item.id, itemsAdded);
    }

    void decreaseCart() {
      setState(
        () {
          itemsAdded = itemsAdded - 1;
          priceController.text = itemsAdded.toString();
          cartPrice = itemsAdded * double.parse(getPrice());
        },
      );

      cart.changeitemQuantity(widget.item.id, itemsAdded);
    }

    onEditCart(String val) {
      setState(() {
        itemsAdded = int.parse(priceController.text);
        priceController.text = itemsAdded.toString();

        cartPrice = itemsAdded * double.parse(getPrice());
      });
    }

    onRemoveFromCart() {
      setState(
        () {
          itemsAdded = itemsAdded - 1;
          priceController.text = itemsAdded.toString();
          cartPrice = itemsAdded * double.parse(getPrice());
        },
      );
      cart.removeItem(widget.item.id);
    }

    var size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
      decoration: BoxDecoration(
        color: textWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          itemsAdded == 1
              ? Container(
                  padding: const EdgeInsets.only(left: 6, right: 5),
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
                  padding: const EdgeInsets.only(left: 6, right: 5),
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
              padding: const EdgeInsets.only(
                left: 5.0,
              ),
              child: TextField(
                textAlign: TextAlign.center,
                controller: priceController,
                decoration: InputDecoration(
                  filled: true,
                  border: const OutlineInputBorder(
                      gapPadding: 2.0,
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  contentPadding: EdgeInsets.zero,
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
                style: const TextStyle(
                  color: textBlack,
                ),
                onChanged: (val) {
                  onEditCart(val);
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 6, left: 5),
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
