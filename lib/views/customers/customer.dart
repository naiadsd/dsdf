import 'package:dsd/state/cart/provider/cart_provider.dart';
import 'package:dsd/state/customers/model/customer.dart';
import 'package:dsd/theme/colors.dart';
import 'package:dsd/theme/padding.dart';
import 'package:dsd/views/items/items.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomerItem extends ConsumerWidget {
  final Customer customer;
  final String driverId;
  const CustomerItem({Key? key, required this.customer, required this.driverId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: (() {
        showCustomerDetails(context);
      }),
      child: Container(
        width: size.width,
        height: size.width * 0.4 - 15,
        padding: const EdgeInsets.only(left: 15, right: 15, top: 3),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5.0),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
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
                        customer.customerName,
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
                        color: Colors.black26,
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
                      // SizedBox
                      //(height: 5),
                      const Divider(
                        height: 4,
                        color: Colors.black26,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width * 0.5,
                            child: const Text(
                              'sold here will come from an api every tume asdasd asdadasdasdasdasd ',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showConfirmationDailog(context, ref);
                            },
                            child: const CircleAvatar(
                              backgroundColor: secondary,
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          )

                          ///   Icon(Icons.)
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  showCustomerDetails(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: ((context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            // color: Colors.red,
            margin: const EdgeInsets.all(appPadding),
            child: Column(
              children: [
                Text(
                  customer.customerName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: secondary,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  height: 4,
                  color: Colors.black26,
                ),
              ],
            ),
          );
        }));
  }

  showConfirmationDailog(BuildContext context, WidgetRef ref) {
    Widget cencelButton = TextButton(
      onPressed: (() {
        Navigator.of(context).pop();
      }),
      child: const Text('Cancel'),
    );

    Widget continueButton = TextButton(
      onPressed: (() {
        Navigator.of(context).pop();
        ref.watch(cartProvider.notifier).createCart(customer.id, driverId);
        Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
          return Items(customer: customer);
        })));
      }),
      child: const Text('Continue'),
    );

    AlertDialog alert = AlertDialog(
      title: Text(customer.customerName),
      content: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("Do you want to order for this customer?.."),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [cencelButton, continueButton],
        ),
      ],
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      contentPadding: const EdgeInsets.all(10),
      elevation: 30,
    );

    showDialog(
        context: context,
        builder: ((context) {
          return alert;
        }));
  }
}
