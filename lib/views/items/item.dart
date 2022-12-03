import 'package:dsd/state/items/models/item.dart';
import 'package:dsd/theme/colors.dart';
import 'package:dsd/theme/padding.dart';
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      width: size.width,
      height: size.width * 0.35,
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
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: size.width * 0.7,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.description,
                      style: const TextStyle(
                        fontSize: 15,
                        color: textWhite,
                      ),
                    ),
                    const SizedBox(height: miniSpacer),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '\$ ${getPrice()}',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            'CS\\${widget.item.reOrderQuantity}',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            '\$ ${widget.item.salePrice}',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                height: size.width * 0.2,
                width: size.width * 0.2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
