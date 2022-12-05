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
                  child: itemsAdded > 0
                      ? Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              itemsAdded == 1
                                  ? SizedBox(
                                      width: size.width * 0.1,
                                      child: InkWell(
                                        child: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.black,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            itemsAdded = 0;
                                            cartPrice = itemsAdded *
                                                double.parse(getPrice());
                                          });
                                        },
                                      ),
                                    )
                                  : SizedBox(
                                      width: size.width * 0.1,
                                      child: InkWell(
                                        onTap: (() {
                                          setState(() {
                                            itemsAdded = itemsAdded - 1;
                                            priceController.text =
                                                itemsAdded.toString();
                                            cartPrice = itemsAdded *
                                                double.parse(getPrice());
                                          });
                                        }),
                                        child: const Icon(
                                          Icons.remove,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                              SizedBox(
                                width: size.width * 0.1,
                                child: Center(
                                  child: TextField(
                                    controller: priceController,

                                    keyboardType: TextInputType.number,
                                    // ignore: prefer_const_constructors

                                    style: const TextStyle(
                                      color: textBlack,

                                      // background: Colors.transparent,
                                    ),
                                    onChanged: (val) {
                                      setState(() {
                                        itemsAdded =
                                            int.parse(priceController.text);
                                        priceController.text =
                                            itemsAdded.toString();

                                        cartPrice = itemsAdded *
                                            double.parse(getPrice());
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.1,
                                child: InkWell(
                                  onTap: (() {
                                    setState(() {
                                      itemsAdded++;
                                      priceController.text =
                                          itemsAdded.toString();
                                      cartPrice =
                                          itemsAdded * double.parse(getPrice());
                                    });
                                  }),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : OutlinedButton(
                          style: const ButtonStyle(
                            alignment: Alignment.center,
                          ),
                          child: const Text(
                            "Add to Cart",
                            style: TextStyle(
                              color: primary,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              itemsAdded++;
                              priceController.text = itemsAdded.toString();
                            });
                          },
                        )),
            ],
          ),
        ],
      ),
    );
  }
}
/**
 * Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width * 0.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * 0.15,
                        child: Text(
                          '\$ ${getPrice()}',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.15,
                        child: Text(
                          'CS\\${widget.item.reOrderQuantity}',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.3,
                        child: Text(
                          '\$ ${cartPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  child: itemsAdded > 0
                      ? 
                      
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            itemsAdded == 1
                                ? SizedBox(
                                    width: size.width * 0.1,
                                    child: InkWell(
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          itemsAdded = 0;
                                          cartPrice = itemsAdded *
                                              double.parse(getPrice());
                                        });
                                      },
                                    ),
                                  )
                                : SizedBox(
                                    width: size.width * 0.1,
                                    child: InkWell(
                                      onTap: (() {
                                        setState(() {
                                          itemsAdded = itemsAdded - 1;
                                          priceController.text =
                                              itemsAdded.toString();
                                          cartPrice = itemsAdded *
                                              double.parse(getPrice());
                                        });
                                      }),
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              width: size.width * 0.1,
                              child: TextFormField(
                                controller: priceController,
                                keyboardType: TextInputType.number,
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                  color: textWhite,
                                  // background: Colors.transparent,
                                ),
                                onEditingComplete: () {
                                  setState(() {
                                    itemsAdded =
                                        int.parse(priceController.text);
                                    priceController.text =
                                        itemsAdded.toString();

                                    cartPrice =
                                        itemsAdded * double.parse(getPrice());
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.1,
                              child: InkWell(
                                onTap: (() {
                                  setState(() {
                                    itemsAdded++;
                                    priceController.text =
                                        itemsAdded.toString();
                                    cartPrice =
                                        itemsAdded * double.parse(getPrice());
                                  });
                                }),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(
                          width: size.width * 0.2,
                          child: ElevatedButton(
                              onPressed: (() {
                                setState(() {
                                  itemsAdded++;
                                  priceController.text = itemsAdded.toString();
                                });
                              }),
                              child: const Text('Add to Cart')),
                        ),
                ),
              ],
            ),
          ),
 * 
 */