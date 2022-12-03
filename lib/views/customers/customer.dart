import 'package:dsd/state/customers/model/customer.dart';
import 'package:dsd/theme/colors.dart';
import 'package:dsd/theme/padding.dart';
import 'package:flutter/material.dart';

class CustomerItem extends StatelessWidget {
  final Customer customer;

  const CustomerItem({Key? key, required this.customer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.width * 0.35,
      padding: const EdgeInsets.only(left: 15, right: 15, top: 4),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
      decoration: BoxDecoration(
        color: textWhite,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: size.width * 0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.23,
                  height: size.width * 0.23,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: customer.isPromoAvailable
                            ? Colors.green[400]
                            : secondary,
                        alignment: Alignment.center,
                        child: Text(
                          customer.customerName[0],
                          style: const TextStyle(
                              color: textWhite,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
                const SizedBox(width: miniSpacer + 5),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${customer.customerName}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: secondary,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Divider(
                        height: 4,
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customer.shipToAddressLineTwo.isNotEmpty
                              ? Text(
                                  '${customer.shipToAddressLineOne}\n${customer.shipToAddressLineTwo}\n${customer.shipToCity} \n${customer.shipToSate} - ${customer.shipToZip}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: grey,
                                  ),
                                )
                              : Text(
                                  '${customer.shipToAddressLineOne}\n${customer.shipToCity} \n${customer.shipToSate} - ${customer.shipToZip}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: grey,
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
