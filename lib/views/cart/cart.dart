import 'package:badges/badges.dart';
import 'package:dsd/state/cart/models/cart_item.dart';
import 'package:dsd/state/cart/provider/cart_provider.dart';
import 'package:dsd/theme/colors.dart';
import 'package:dsd/theme/padding.dart';
import 'package:dsd/views/cart/cart_item.dart';
import 'package:dsd/views/invoice/api/pdf_api.dart';
import 'package:dsd/views/invoice/api/pdf_invoice_api.dart';
import 'package:dsd/views/invoice/model/inovice.dart';
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

    final cartVal = ref.watch(cartProvider.notifier).getTotal();
    final noOfItems = ref.watch(totalCartItemsProvider);
    return Column(
      children: [
        Container(
          width: size.width,
          height: 120,
          decoration: const BoxDecoration(
            color: Colors.grey,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: appPadding - 5, right: appPadding - 5),
            child: Column(
              children: [
                const SizedBox(
                  height: spacer,
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
                      'Your Cart',
                      style: TextStyle(
                        color: textWhite,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
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
        Expanded(
            child: Stack(
          children: [
            Container(
              child: getCartItems(),
            ),
            if (cartVal > 0) checkOutContainer(),
          ],
        )),
      ],
    );
  }

  Widget checkOutContainer() {
    var size = MediaQuery.of(context).size;
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
                Consumer(builder: ((context, ref, child) {
                  return TextButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: secondary,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () async {
                        final date = DateTime.now();
                        final dueDate = date.add(const Duration(days: 7));
                        final cart = ref.read(cartProvider);
                        final List<CartItem> itemsWithPromo = [];

                        if (cart.items != null && cart.items!.isNotEmpty) {
                          for (var element in cart.items!) {
                            itemsWithPromo.add(element);
                            if (element.isPromoApplied) {
                              var ci = element;
                              //ci.itemId = element.promoId;
                              ci.saleprice = element.promoPrice;
                              itemsWithPromo.add(ci);
                            }
                          }
                        }

                        final invoice = Invoice(
                          custoemrId: cart.customerId.toString(),
                          info: InvoiceInfo(
                            date: date,
                            dueDate: dueDate,
                            description: 'My description...',
                            number: '${DateTime.now().year}-9999',
                          ),
                          items: itemsWithPromo,
                        );
                        final pdfFile = await PdfInvoiceApi.generate(invoice);
                        PdfApi.openFile(pdfFile);
                        print('generate pdf here..');
                      },
                      child: const Text(
                        'Place Order',
                        style: TextStyle(color: textWhite, fontSize: 16),
                      ));
                }))
              ],
            ),
          ),
        ),
      ),
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
                      .showSnackBar(const SnackBar(content: Text('dismissed')));
                }),
                child: ListTile(
                  title: CartItemContainer(cartItem: items[index]),
                ),
              );
            }));
    ;
  }
}
